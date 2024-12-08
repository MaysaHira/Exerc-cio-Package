Resumo dos Pacotes

PKG_ ALUNO
Este pacote contém operações relacionadas aos alunos e suas matrículas:
1. Procedure EXCLUIR_ALUNO
Remove um aluno com base no ID fornecido e exclui todas as matrículas associadas a ele.
2. Cursor LISTAR_ALUNOS_MAIORES_18
Lista o nome e a data de nascimento de todos os alunos com mais de 18 anos.
3. Cursor LISTAR_ALUNOS_POR_CURSO
Lista os nomes dos alunos matriculados em um curso específico, identificado pelo ID do curso.

PKG_DISCIPLINA
Este pacote lida com o gerenciamento de disciplinas e informações relacionadas:
1. Procedure CADASTRAR_DISCIPLINA
Cadastra uma nova disciplina, recebendo como parâmetros o nome, a descrição e a carga horária.
2. Cursor TOTAL_ALUNOS_POR_DISCIPLINA
Exibe a quantidade total de alunos por disciplina, listando apenas as disciplinas com mais de 10 alunos matriculados.
3. Cursor MEDIA_IDADE_ POR_ DISCIPLINA
Calcula a média de idade dos alunos matriculados em uma disciplina específica, identificada pelo ID.
4. Procedure LISTAR_ALUNOS_POR_DISCIPLINA
Lista os nomes dos alunos matriculados em uma disciplina específica, identificada pelo ID.

PKG_PROFESSOR
Este pacote gerencia informações relacionadas aos professores e turmas:
1. Cursor TOTAL_TURMAS POR PROFESSOR
Lista os nomes dos professores e a quantidade de turmas que cada um leciona, mostrando apenas aqueles responsáveis por mais de uma turma.
2. Function TOTAL_TURMAS_PROFESSOR
Retorna a quantidade total de turmas nas quais um professor, identificado pelo ID, atua como responsável.
3. Function PROFESSOR_DA_DISCIPLINA
Retorna o nome do professor responsável por ministrar uma disciplina específica, identificada pelo ID.
