CREATE OR REPLACE PACKAGE PKG_ALUNO AS
    PROCEDURE EXCLUIR_ALUNO(p_id_aluno IN NUMBER);
    CURSOR LISTAR_ALUNOS_MAIORES_18;
    CURSOR LISTAR_ALUNOS_POR_CURSO(p_id_curso IN NUMBER);
END PKG_ALUNO;

CREATE OR REPLACE PACKAGE PKG_DISCIPLINA AS
    PROCEDURE CADASTRAR_DISCIPLINA(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER);
    CURSOR TOTAL_ALUNOS_POR_DISCIPLINA;
    CURSOR MEDIA_IDADE_POR_DISCIPLINA(p_id_disciplina IN NUMBER);
    PROCEDURE LISTAR_ALUNOS_POR_DISCIPLINA(p_id_disciplina IN NUMBER);
END PKG_DISCIPLINA;

CREATE OR REPLACE PACKAGE PKG_PROFESSOR AS
    CURSOR TOTAL_TURMAS_POR_PROFESSOR;
    FUNCTION TOTAL_TURMAS_PROFESSOR(p_id_professor IN NUMBER) RETURN NUMBER;
    FUNCTION PROFESSOR_DA_DISCIPLINA(p_id_disciplina IN NUMBER) RETURN VARCHAR2;
END PKG_PROFESSOR;

CREATE OR REPLACE PACKAGE BODY PKG_ALUNO AS
    PROCEDURE EXCLUIR_ALUNO(p_id_aluno IN NUMBER) IS
    BEGIN
        DELETE FROM matricula WHERE id_aluno = p_id_aluno;
        DELETE FROM aluno WHERE id = p_id_aluno;
    END EXCLUIR_ALUNO;

    CURSOR LISTAR_ALUNOS_MAIORES_18 IS
        SELECT nome, data_nascimento
        FROM aluno
        WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM data_nascimento) > 18;

    CURSOR LISTAR_ALUNOS_POR_CURSO(p_id_curso IN NUMBER) IS
        SELECT a.nome
        FROM aluno a
        JOIN matricula m ON a.id = m.id_aluno
        WHERE m.id_curso = p_id_curso;
END PKG_ALUNO;

CREATE OR REPLACE PACKAGE BODY PKG_DISCIPLINA AS
    PROCEDURE CADASTRAR_DISCIPLINA(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER) IS
    BEGIN
        INSERT INTO disciplina (nome, descricao, carga_horaria)
        VALUES (p_nome, p_descricao, p_carga_horaria);
    END CADASTRAR_DISCIPLINA;

    CURSOR TOTAL_ALUNOS_POR_DISCIPLINA IS
        SELECT d.nome, COUNT(m.id_aluno) AS total_alunos
        FROM disciplina d
        JOIN matricula m ON d.id = m.id_disciplina
        GROUP BY d.nome
        HAVING COUNT(m.id_aluno) > 10;

    CURSOR MEDIA_IDADE_POR_DISCIPLINA(p_id_disciplina IN NUMBER) IS
        SELECT AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM a.data_nascimento)) AS media_idade
        FROM aluno a
        JOIN matricula m ON a.id = m.id_aluno
        WHERE m.id_disciplina = p_id_disciplina;

    PROCEDURE LISTAR_ALUNOS_POR_DISCIPLINA(p_id_disciplina IN NUMBER) IS
        CURSOR alunos_disciplina IS
            SELECT a.nome
            FROM aluno a
            JOIN matricula m ON a.id = m.id_aluno
            WHERE m.id_disciplina = p_id_disciplina;
    BEGIN
        FOR aluno IN alunos_disciplina LOOP
            DBMS_OUTPUT.PUT_LINE(aluno.nome);
        END LOOP;
    END LISTAR_ALUNOS_POR_DISCIPLINA;
END PKG_DISCIPLINA;


CREATE OR REPLACE PACKAGE BODY PKG_PROFESSOR AS
    CURSOR TOTAL_TURMAS_POR_PROFESSOR IS
        SELECT p.nome, COUNT(t.id) AS total_turmas
        FROM professor p
        JOIN turma t ON p.id = t.id_professor
        GROUP BY p.nome
        HAVING COUNT(t.id) > 1;

    FUNCTION TOTAL_TURMAS_PROFESSOR(p_id_professor IN NUMBER) RETURN NUMBER IS
        v_total_turmas NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_total_turmas
        FROM turma
        WHERE id_professor = p_id_professor;
        RETURN v_total_turmas;
    END TOTAL_TURMAS_PROFESSOR;

    FUNCTION PROFESSOR_DA_DISCIPLINA(p_id_disciplina IN NUMBER) RETURN VARCHAR2 IS
        v_nome_professor VARCHAR2(100);
    BEGIN
        SELECT p.nome INTO v_nome_professor
        FROM professor p
        JOIN disciplina d ON p.id = d.id_professor
        WHERE d.id = p_id_disciplina;
        RETURN v_nome_professor;
    END PROFESSOR_DA_DISCIPLINA;
END PKG_PROFESSOR;



