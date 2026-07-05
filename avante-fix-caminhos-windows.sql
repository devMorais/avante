-- ============================================================
-- Correção: caminhos Windows (C:\Users\...) perderam todas as
-- barras invertidas em produção — MySQL trata \ como caractere de
-- escape dentro de string com aspas simples, e o script original
-- (avante-novo-plano.sql) não escapou isso. Afeta as 17 demandas
-- do board 8 (Avante) que têm passo "1. Acesse: C:\Users\...".
-- Rodar UMA VEZ.
-- ============================================================

SELECT COUNT(*) AS afetadas_antes FROM tasks WHERE board_id = 8 AND description LIKE '%C:UsersUITECHerd%' OR (board_id = 8 AND description LIKE '%C:UsersClaudiaHerd%');

UPDATE tasks SET description = REPLACE(description, 'C:UsersUITECHerdgestao-tarefas', 'C:\\Users\\UITEC\\Herd\\gestao-tarefas') WHERE board_id = 8;
UPDATE tasks SET description = REPLACE(description, 'C:UsersClaudiaHerdgestao-tarefas', 'C:\\Users\\Claudia\\Herd\\gestao-tarefas') WHERE board_id = 8;
UPDATE tasks SET description = REPLACE(description, 'gestao-tarefasbackend', 'gestao-tarefas\\backend') WHERE board_id = 8;
UPDATE tasks SET description = REPLACE(description, 'gestao-tarefasfrontend', 'gestao-tarefas\\frontend') WHERE board_id = 8;

SELECT COUNT(*) AS ainda_com_bug FROM tasks WHERE board_id = 8 AND (description LIKE '%C:UsersUITECHerd%' OR description LIKE '%C:UsersClaudiaHerd%');
SELECT id, SUBSTRING(description, 1, LOCATE('\n', description)) AS titulo,
  SUBSTRING(description, LOCATE('Acesse:', description), 70) AS trecho_acesse
FROM tasks WHERE board_id = 8 AND description LIKE '%Acesse:%' ORDER BY sort_order;
