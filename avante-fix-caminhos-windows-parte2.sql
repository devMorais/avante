-- ============================================================
-- Correção parte 2: o sufixo "\backend" ficou pior que o previsto —
-- MySQL trata \b como caractere de escape de BACKSPACE (não só
-- ignora a barra como nos outros casos), então "\backend" virou
-- backspace + "ackend" (perdeu a barra E o "b"). Este script busca
-- exatamente esse padrão (escrevendo \backend na busca, que o MySQL
-- também interpreta como backspace+ackend, batendo com o dado já
-- corrompido) e substitui pela barra dupla escapada correta.
-- ============================================================

SELECT COUNT(*) AS ainda_quebrado_antes FROM tasks WHERE board_id = 8 AND description LIKE '%gestao-tarefas\backend%';

UPDATE tasks SET description = REPLACE(description, 'gestao-tarefas\backend', 'gestao-tarefas\\backend') WHERE board_id = 8;

SELECT COUNT(*) AS ainda_quebrado_depois FROM tasks WHERE board_id = 8 AND description LIKE '%gestao-tarefas\backend%';
SELECT id, SUBSTRING(description, LOCATE('Acesse:', description), 60) AS trecho
FROM tasks WHERE board_id = 8 AND description LIKE '%Acesse:%' ORDER BY sort_order;
