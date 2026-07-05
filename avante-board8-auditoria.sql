-- ============================================================
-- Auditoria READ-ONLY — board "Avante - Plataforma de gestão de tarefas" (board_id = 8)
-- Banco: u846585591_gestao_tarefas (produção)
-- Objetivo: visualizar o estado atual completo do board antes de decidir
--           o que será excluído/recriado. NENHUM INSERT/UPDATE/DELETE aqui.
--
-- Como rodar (via SSH, porta 65002):
--   mysql -u u846585591_gestao_tarefas -p'SENHA' -h 127.0.0.1 -t \
--     u846585591_gestao_tarefas < avante-board8-auditoria.sql > auditoria-board8.txt
--
-- O "-t" força saída em formato de tabela (mais legível ao redirecionar para arquivo).
-- ============================================================

SET @board_id = 8;

-- 0) Confirmação: este é mesmo o board certo?
SELECT '=== 0. BOARD ===' AS secao;
SELECT id, name, icon_path, archived_at, created_at, updated_at, deleted_at
FROM boards
WHERE id = @board_id;

-- 1) Sprints do board
SELECT '=== 1. SPRINTS ===' AS secao;
SELECT id, name, start_date, end_date, finished_at, created_at, updated_at, deleted_at
FROM sprints
WHERE board_id = @board_id
ORDER BY start_date;

-- 2) Status configurados no board
SELECT '=== 2. STATUSES ===' AS secao;
SELECT id, name, color, `order`, created_at, updated_at, deleted_at
FROM statuses
WHERE board_id = @board_id
ORDER BY `order`;

-- 3) Prioridades configuradas no board
SELECT '=== 3. PRIORITIES ===' AS secao;
SELECT id, name, color, `order`, created_at, updated_at, deleted_at
FROM priorities
WHERE board_id = @board_id
ORDER BY `order`;

-- 4) Tipos de tarefa configurados no board
SELECT '=== 4. TASK_TYPES ===' AS secao;
SELECT id, name, color, `order`, created_at, updated_at, deleted_at
FROM task_types
WHERE board_id = @board_id
ORDER BY `order`;

-- 5) Tags configuradas no board (com contagem de uso real em task_tag)
SELECT '=== 5. TAGS (com contagem de uso) ===' AS secao;
SELECT
  tg.id, tg.name, tg.color, tg.deleted_at,
  (SELECT COUNT(*) FROM task_tag tt
     JOIN tasks t ON t.id = tt.task_id
    WHERE tt.tag_id = tg.id AND t.board_id = @board_id) AS qtd_tasks_com_tag
FROM tags tg
WHERE tg.board_id = @board_id
ORDER BY tg.name;

-- 6) Todas as tasks do board (via board_id direto), com nomes resolvidos de sprint/status
SELECT '=== 6. TASKS (board_id direto) ===' AS secao;
SELECT
  t.id, t.description, t.priority, t.epic, t.release, t.type,
  s.name AS sprint_name, st.name AS status_name,
  t.assigned_to AS assigned_to_legado,
  t.sort_order, t.completed_at,
  t.created_at, t.updated_at, t.deleted_at
FROM tasks t
LEFT JOIN sprints s ON s.id = t.sprint_id
LEFT JOIN statuses st ON st.id = t.status_id
WHERE t.board_id = @board_id
ORDER BY s.start_date, t.sort_order;

-- 6b) Checagem de inconsistência: tasks presas a uma sprint do board 8
--     mas com board_id diferente (não deveria existir, mas vale conferir)
SELECT '=== 6b. TASKS via sprint_id mas com board_id diferente (inconsistência) ===' AS secao;
SELECT t.id, t.board_id, t.sprint_id, t.description
FROM tasks t
JOIN sprints s ON s.id = t.sprint_id
WHERE s.board_id = @board_id AND t.board_id <> @board_id;

-- 7) Tags aplicadas a cada task do board
SELECT '=== 7. TAGS POR TASK ===' AS secao;
SELECT tt.task_id, GROUP_CONCAT(tg.name ORDER BY tg.name SEPARATOR ', ') AS tags
FROM task_tag tt
JOIN tags tg ON tg.id = tt.tag_id
JOIN tasks t ON t.id = tt.task_id
WHERE t.board_id = @board_id
GROUP BY tt.task_id;

-- 8) Responsáveis (assignees) de cada task via pivot task_user
SELECT '=== 8. RESPONSÁVEIS POR TASK (task_user) ===' AS secao;
SELECT tu.task_id, GROUP_CONCAT(u.name ORDER BY u.name SEPARATOR ', ') AS responsaveis
FROM task_user tu
JOIN users u ON u.id = tu.user_id
JOIN tasks t ON t.id = tu.task_id
WHERE t.board_id = @board_id
GROUP BY tu.task_id;

-- 9) Todos os usuários que aparecem em alguma task do board (assignee ou autor de comentário/anexo)
SELECT '=== 9. USUÁRIOS ENVOLVIDOS NO BOARD ===' AS secao;
SELECT DISTINCT u.id, u.name, u.email, u.role
FROM users u
WHERE u.id IN (
  SELECT tu.user_id FROM task_user tu JOIN tasks t ON t.id = tu.task_id WHERE t.board_id = @board_id
  UNION
  SELECT t.assigned_to FROM tasks t WHERE t.board_id = @board_id AND t.assigned_to IS NOT NULL
  UNION
  SELECT c.user_id FROM comments c JOIN tasks t ON t.id = c.task_id WHERE t.board_id = @board_id
  UNION
  SELECT a.user_id FROM attachments a JOIN tasks t ON t.id = a.task_id WHERE t.board_id = @board_id
)
ORDER BY u.name;

-- 10) Comentários de todas as tasks do board
SELECT '=== 10. COMENTÁRIOS ===' AS secao;
SELECT c.id, c.task_id, u.name AS autor, c.content, c.created_at, c.deleted_at
FROM comments c
JOIN tasks t ON t.id = c.task_id
LEFT JOIN users u ON u.id = c.user_id
WHERE t.board_id = @board_id
ORDER BY c.task_id, c.created_at;

-- 11) Anexos de todas as tasks do board
SELECT '=== 11. ANEXOS ===' AS secao;
SELECT a.id, a.task_id, u.name AS enviado_por, a.original_name, a.size, a.mime_type,
       a.path, a.created_at, a.deleted_at
FROM attachments a
JOIN tasks t ON t.id = a.task_id
LEFT JOIN users u ON u.id = a.user_id
WHERE t.board_id = @board_id
ORDER BY a.task_id, a.created_at;

-- 12) Resumo agregado — visão rápida do estado do board
SELECT '=== 12. RESUMO — tasks por status ===' AS secao;
SELECT COALESCE(st.name, '(sem status)') AS status, COUNT(*) AS qtd
FROM tasks t
LEFT JOIN statuses st ON st.id = t.status_id
WHERE t.board_id = @board_id AND t.deleted_at IS NULL
GROUP BY st.name
ORDER BY qtd DESC;

SELECT '=== 12. RESUMO — tasks por prioridade ===' AS secao;
SELECT COALESCE(priority, '(sem prioridade)') AS prioridade, COUNT(*) AS qtd
FROM tasks
WHERE board_id = @board_id AND deleted_at IS NULL
GROUP BY priority
ORDER BY qtd DESC;

SELECT '=== 12. RESUMO — tasks por tipo ===' AS secao;
SELECT COALESCE(type, '(sem tipo)') AS tipo, COUNT(*) AS qtd
FROM tasks
WHERE board_id = @board_id AND deleted_at IS NULL
GROUP BY type
ORDER BY qtd DESC;

SELECT '=== 12. RESUMO — tasks por sprint ===' AS secao;
SELECT COALESCE(s.name, '(sem sprint)') AS sprint, COUNT(*) AS qtd
FROM tasks t
LEFT JOIN sprints s ON s.id = t.sprint_id
WHERE t.board_id = @board_id AND t.deleted_at IS NULL
GROUP BY s.name
ORDER BY s.name;

SELECT '=== 12. RESUMO — totais gerais ===' AS secao;
SELECT
  (SELECT COUNT(*) FROM tasks WHERE board_id = @board_id) AS total_tasks_incl_excluidas,
  (SELECT COUNT(*) FROM tasks WHERE board_id = @board_id AND deleted_at IS NULL) AS total_tasks_ativas,
  (SELECT COUNT(*) FROM tasks WHERE board_id = @board_id AND deleted_at IS NOT NULL) AS total_tasks_excluidas_soft,
  (SELECT COUNT(*) FROM tasks t JOIN statuses st ON st.id = t.status_id
     WHERE t.board_id = @board_id AND t.deleted_at IS NULL AND st.name IN ('Concluída','Concluido','Concluído','Done','Finalizado')) AS total_tasks_concluidas,
  (SELECT COUNT(*) FROM sprints WHERE board_id = @board_id) AS total_sprints,
  (SELECT COUNT(*) FROM sprints WHERE board_id = @board_id AND finished_at IS NOT NULL) AS sprints_finalizadas,
  (SELECT COUNT(*) FROM comments c JOIN tasks t ON t.id = c.task_id WHERE t.board_id = @board_id) AS total_comentarios,
  (SELECT COUNT(*) FROM attachments a JOIN tasks t ON t.id = a.task_id WHERE t.board_id = @board_id) AS total_anexos;

-- 13) (bônus) Notificações geradas a partir de tasks deste board
SELECT '=== 13. NOTIFICAÇÕES LIGADAS A TASKS DO BOARD ===' AS secao;
SELECT n.id, n.user_id AS destinatario, n.from_user_id, n.type, n.task_id, n.message, n.read_at, n.created_at
FROM notifications n
JOIN tasks t ON t.id = n.task_id
WHERE t.board_id = @board_id
ORDER BY n.created_at DESC;
