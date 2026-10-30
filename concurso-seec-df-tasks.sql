-- ============================================================
-- Concurso SEEC DF - board + sprints + cards
-- Gerado por concurso-seec-df-gerar-sql.py a partir de
-- concurso-seec-df-tasks.json. NAO edite este arquivo na mao.
-- ATENCAO: nao e idempotente. Rodar duas vezes duplica as linhas.
-- ============================================================
SET NAMES utf8mb4;
START TRANSACTION;
UPDATE boards SET deleted_at = NOW() WHERE id = 27 AND deleted_at IS NULL;

INSERT INTO boards (name, created_at, updated_at)
VALUES ('Concurso SEEC DF — Técnico de Planejamento Urbano (Segurança do Trabalho)', NOW(), NOW());
SET @board := LAST_INSERT_ID();

INSERT INTO statuses (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Em Fila', '#6B6B70', 0, NOW(), NOW());
INSERT INTO statuses (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Em Andamento', '#0284C7', 1, NOW(), NOW());
INSERT INTO statuses (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Em Revisao', '#D97706', 2, NOW(), NOW());
INSERT INTO statuses (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Concluida', '#059669', 3, NOW(), NOW());
INSERT INTO priorities (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Baixa', '#059669', 0, NOW(), NOW());
INSERT INTO priorities (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Media', '#0284C7', 1, NOW(), NOW());
INSERT INTO priorities (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Alta', '#EA580C', 2, NOW(), NOW());
INSERT INTO priorities (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Urgente', '#DC2626', 3, NOW(), NOW());
INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Teoria', '#2563EB', 0, NOW(), NOW());
INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Questões', '#059669', 1, NOW(), NOW());
INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Revisão', '#D97706', 2, NOW(), NOW());
INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Simulado', '#DC2626', 3, NOW(), NOW());
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Português', '#2563EB', NOW(), NOW());
SET @tag1 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Específicos', '#DC2626', NOW(), NOW());
SET @tag2 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Raciocínio Lógico', '#7C3AED', NOW(), NOW());
SET @tag3 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Direito Constitucional', '#059669', NOW(), NOW());
SET @tag4 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Informática', '#0891B2', NOW(), NOW());
SET @tag5 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Direito Administrativo', '#D97706', NOW(), NOW());
SET @tag6 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'DF e RIDE', '#16A34A', NOW(), NOW());
SET @tag7 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Política para Mulheres', '#DB2777', NOW(), NOW());
SET @tag8 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Inteligência Emocional', '#6B6B70', NOW(), NOW());
SET @tag9 := LAST_INSERT_ID();
SET @fila := (SELECT id FROM statuses WHERE board_id = @board AND name = 'Em Fila' LIMIT 1);

INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 1 (23/10 a 29/10)', '2026-10-23', '2026-10-29', 1, NOW(), NOW());
SET @sprint1 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 2 (30/10 a 05/11)', '2026-10-30', '2026-11-05', 2, NOW(), NOW());
SET @sprint2 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 3 (06/11 a 12/11)', '2026-11-06', '2026-11-12', 3, NOW(), NOW());
SET @sprint3 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 4 (13/11 a 19/11)', '2026-11-13', '2026-11-19', 4, NOW(), NOW());
SET @sprint4 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 5 (20/11 a 26/11)', '2026-11-20', '2026-11-26', 5, NOW(), NOW());
SET @sprint5 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 6 (27/11 a 03/12)', '2026-11-27', '2026-12-03', 6, NOW(), NOW());
SET @sprint6 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 7 (04/12 a 10/12)', '2026-12-04', '2026-12-10', 7, NOW(), NOW());
SET @sprint7 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 8 (11/12 a 17/12)', '2026-12-11', '2026-12-17', 8, NOW(), NOW());
SET @sprint8 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 9 (18/12 a 24/12)', '2026-12-18', '2026-12-24', 9, NOW(), NOW());
SET @sprint9 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 10 (25/12 a 31/12)', '2026-12-25', '2026-12-31', 10, NOW(), NOW());
SET @sprint10 := LAST_INSERT_ID();

-- SEEC-001
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-001] Sex 23/10 — Português — Gramática: T1 Aulas 1–5 · Gramática', '📅 Sex 23/10 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h55 de vídeo):
- Tópico 1 · Aula 1 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 2 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 3 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 4 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 5 — nome: conferir no Gran (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-10-23 08:00:00',
        1, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-002
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-002] Sex 23/10 — Direito Administrativo: T1 Aulas 1–4 · Organização Administrativa', '📅 Sex 23/10 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Organização administrativa.

Aulas do Gran (assistir em 1.25x; total 2h10 de vídeo):
- Tópico 1 · Aula 1 — Organização Administrativa (32 min)
- Tópico 1 · Aula 2 — Organização Administrativa II (33 min)
- Tópico 1 · Aula 3 — Organização Administrativa III (30 min)
- Tópico 1 · Aula 4 — Organização Administrativa IV (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-10-23 14:00:00',
        2, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-003
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-003] Sex 23/10 — Bateria de questões — Português + Direito Administrativo (2h)', '📅 Sex 23/10 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Direito Administrativo (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-10-23 19:00:00',
        3, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-004
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-004] Sáb 24/10 — Raciocínio Lógico: T1 Aulas 1–6 · Proposições', '📅 Sáb 24/10 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Lógica.

Aulas do Gran (assistir em 1.25x; total 3h01 de vídeo):
- Tópico 1 · Aula 1 — Proposições (29 min)
- Tópico 1 · Aula 2 — Proposições Simples e Composta (34 min)
- Tópico 1 · Aula 3 — Sinônimos dos Conectivos Lógicos (32 min)
- Tópico 1 · Aula 4 — Sinônimos dos Conectivos Lógicos - Questões (33 min)
- Tópico 1 · Aula 5 — Tabela Verdade (25 min)
- Tópico 1 · Aula 6 — Tabela Verdade das Proposições Compostas (28 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-10-24 08:00:00',
        4, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-005
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-005] Sáb 24/10 — Informática: T1 Aulas 1–4 · Hardware - Evolução dos Computadores', '📅 Sáb 24/10 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: Hardware e software.

Aulas do Gran (assistir em 1.25x; total 2h09 de vídeo):
- Tópico 1 · Aula 1 — Hardware - Evolução dos Computadores (31 min)
- Tópico 1 · Aula 2 — Hardware - Tipos de Hardware e Periféricos (36 min)
- Tópico 1 · Aula 3 — Hardware - Chipset, Interfaces e Barramentos (32 min)
- Tópico 1 · Aula 4 — Hardware - Componentes Internos do PC (30 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-10-24 14:00:00',
        5, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-006
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-006] Sáb 24/10 — Bateria de questões — Raciocínio Lógico + Informática (2h)', '📅 Sáb 24/10 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Raciocínio Lógico e 20 de Informática (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-10-24 19:00:00',
        6, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-007
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-007] Dom 25/10 — 🎯 Simulado da semana — 60 questões (4h)', '📅 Dom 25/10 · ⏰ 08:00

Como candidato(a), quero medir o que ficou da semana em condição de prova.

O que fazer:
- 60 questões das matérias vistas na semana (Caderno de questões do Gran; filtro da banca Consulpam se existir)
- Cronometrar, sem consultar

Critérios de aceite:
- Nota anotada por matéria',
        'Urgente', 'Simulado', 'Simulado', NULL, '2026-10-25 08:00:00',
        7, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-008
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-008] Dom 25/10 — Correção do simulado + revisão da semana (2h)', '📅 Dom 25/10 · ⏰ 14:00

Como candidato(a), quero transformar cada erro em aprendizado.

O que fazer:
- Corrigir questão por questão
- Reler os resumos da semana
- Olhar as cards da próxima semana

Critérios de aceite:
- Caderno de erros atualizado · resto do domingo livre',
        'Alta', 'Simulado', 'Revisão', NULL, '2026-10-25 14:00:00',
        8, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-009
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-009] Seg 26/10 — Direito Constitucional: T1 Aulas 1–3 + T2 Aulas 1–3 + T3 Aula 1 · Conceito de Constituição', '📅 Seg 26/10 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Constitucional: Teoria da Constituição, Princípios fundamentais, Direitos e garantias.

Aulas do Gran (assistir em 1.25x; total 3h08 de vídeo):
- Tópico 1 · Aula 1 — Conceito de Constituição (26 min)
- Tópico 1 · Aula 2 — Classificação das Constituições (31 min)
- Tópico 1 · Aula 3 — Classificação das Constituições II (19 min)
- Tópico 2 · Aula 1 — Princípios Fundamentais (19 min)
- Tópico 2 · Aula 2 — Princípios Fundamentais II (35 min)
- Tópico 2 · Aula 3 — Princípios Fundamentais III (31 min)
- Tópico 3 · Aula 1 — Teoria Geral dos Direitos Fundamentais (27 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Constitucional', 'Teoria', NULL, '2026-10-26 08:00:00',
        9, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-010
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-010] Seg 26/10 — Específicos (Segurança do Trabalho): T1 Aulas 1–4 · NR 01 — Gerenciamento de Riscos Ocupacionais', '📅 Seg 26/10 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Específicos (Segurança do Trabalho): NR 01 — Gerenciamento de Riscos Ocupacionais.

Aulas do Gran (assistir em 1.25x; total 2h01 de vídeo):
- Tópico 1 · Aula 1 — NR 01 — Gerenciamento de Riscos Ocupacionais (31 min)
- Tópico 1 · Aula 2 — NR 01 — Gerenciamento de Riscos Ocupacionais II (31 min)
- Tópico 1 · Aula 3 — NR 01 — Gerenciamento de Riscos Ocupacionais III (30 min)
- Tópico 1 · Aula 4 — NR 01 — Gerenciamento de Riscos Ocupacionais IV (29 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Específicos (Segurança do Trabalho)', 'Teoria', NULL, '2026-10-26 14:00:00',
        10, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-011
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-011] Seg 26/10 — Bateria de questões — Direito Constitucional + Específicos (2h)', '📅 Seg 26/10 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Direito Constitucional e 20 de Específicos (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-10-26 19:00:00',
        11, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-012
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-012] Ter 27/10 — Português — Interpretação: T2 Aulas 1–6 · Interpretação', '📅 Ter 27/10 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Interpretação: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 3h00 de vídeo):
- Tópico 2 · Aula 1 — nome: conferir no Gran (30 min)
- Tópico 2 · Aula 2 — nome: conferir no Gran (30 min)
- Tópico 2 · Aula 3 — nome: conferir no Gran (30 min)
- Tópico 2 · Aula 4 — nome: conferir no Gran (30 min)
- Tópico 2 · Aula 5 — nome: conferir no Gran (30 min)
- Tópico 2 · Aula 6 — nome: conferir no Gran (30 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Interpretação', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-10-27 08:00:00',
        12, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-013
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-013] Ter 27/10 — DF e RIDE: T1 Aulas 1–4 · Conhecimentos sobre o Distrito Federal', '📅 Ter 27/10 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar DF e RIDE: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h09 de vídeo):
- Tópico 1 · Aula 1 — Conhecimentos sobre o Distrito Federal (33 min)
- Tópico 1 · Aula 2 — Conhecimentos sobre o Distrito Federal (parte 2) (32 min)
- Tópico 1 · Aula 3 — História do DF (31 min)
- Tópico 1 · Aula 4 — História do DF (parte 2) (33 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'DF e RIDE', 'Teoria', NULL, '2026-10-27 14:00:00',
        13, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag7);
-- SEEC-014
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-014] Ter 27/10 — Bateria de questões — Português + DF e RIDE (2h)', '📅 Ter 27/10 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de DF e RIDE (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-10-27 19:00:00',
        14, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag7);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-015
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-015] Qua 28/10 — Política para Mulheres: T1 Aulas 1–6 · Decreto 42.590/2021 - Parte I', '📅 Qua 28/10 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Política para Mulheres: Decreto 42.590/2021.

Aulas do Gran (assistir em 1.25x; total 3h05 de vídeo):
- Tópico 1 · Aula 1 — Decreto 42.590/2021 - Parte I (34 min)
- Tópico 1 · Aula 2 — Decreto 42.590/2021 - Parte II (31 min)
- Tópico 1 · Aula 3 — Decreto 42.590/2021 - Parte III (31 min)
- Tópico 1 · Aula 4 — Decreto 42.590/2021 - Resolução de Questões (28 min)
- Tópico 1 · Aula 5 — Decreto 42.590/2021 - Resolução de Questões II (31 min)
- Tópico 1 · Aula 6 — Decreto 42.590/2021 - Resolução de Questões III (30 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Política para Mulheres', 'Teoria', NULL, '2026-10-28 08:00:00',
        15, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag8);
-- SEEC-016
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-016] Qua 28/10 — Inteligência Emocional: T1 Aulas 1–5 · Os 50 Fundamentos Emocionais do Concurseiro', '📅 Qua 28/10 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Inteligência Emocional: Inteligência emocional.

Aulas do Gran (assistir em 1.25x; total 1h59 de vídeo):
- Tópico 1 · Aula 1 — Os 50 Fundamentos Emocionais do Concurseiro (25 min)
- Tópico 1 · Aula 2 — Protagonista, Coadjuvante e Antagonista (31 min)
- Tópico 1 · Aula 3 — Os 50 Fundamentos Emocionais (parte 2) (16 min)
- Tópico 1 · Aula 4 — Autossabotagem (21 min)
- Tópico 1 · Aula 5 — Feridas da Alma (26 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Inteligência Emocional', 'Teoria', NULL, '2026-10-28 14:00:00',
        16, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag9);
-- SEEC-017
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-017] Qua 28/10 — Bateria de questões — Política para Mulheres + Inteligência Emocional (2h)', '📅 Qua 28/10 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Política para Mulheres e 20 de Inteligência Emocional (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-10-28 19:00:00',
        17, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag9);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag8);
-- SEEC-018
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-018] Qui 29/10 — Português — Gramática: T1 Aulas 6–10 · Gramática', '📅 Qui 29/10 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h55 de vídeo):
- Tópico 1 · Aula 6 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 7 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 8 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 9 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 10 — nome: conferir no Gran (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-10-29 08:00:00',
        18, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-019
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-019] Qui 29/10 — Direito Administrativo: T1 Aulas 5–8 · Organização Administrativa V', '📅 Qui 29/10 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Organização administrativa.

Aulas do Gran (assistir em 1.25x; total 2h14 de vídeo):
- Tópico 1 · Aula 5 — Organização Administrativa V (33 min)
- Tópico 1 · Aula 6 — Organização Administrativa VI (34 min)
- Tópico 1 · Aula 7 — Terceiro Setor (32 min)
- Tópico 1 · Aula 8 — Terceiro Setor II (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-10-29 14:00:00',
        19, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-020
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SEEC-020] Qui 29/10 — Bateria de questões — Português + Direito Administrativo (2h)', '📅 Qui 29/10 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Direito Administrativo (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-10-29 19:00:00',
        20, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-021
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-021] Sex 30/10 — Específicos (Segurança do Trabalho): T1 Aula 5 + T2 Aulas 1–4 + T3 Aula 1 · NR 01 - Exercícios', '📅 Sex 30/10 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Específicos (Segurança do Trabalho): NR 01 — Gerenciamento de Riscos Ocupacionais, NR 04 — SESMT, NR 06 — EPI.

Aulas do Gran (assistir em 1.25x; total 2h55 de vídeo):
- Tópico 1 · Aula 5 — NR 01 - Exercícios (20 min)
- Tópico 2 · Aula 1 — NR 04 — SESMT (30 min)
- Tópico 2 · Aula 2 — NR 04 — SESMT II (32 min)
- Tópico 2 · Aula 3 — NR 04 — SESMT III (32 min)
- Tópico 2 · Aula 4 — NR 04 — SESMT IV (29 min)
- Tópico 3 · Aula 1 — NR 06 — EPI (32 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Específicos (Segurança do Trabalho)', 'Teoria', NULL, '2026-10-30 08:00:00',
        21, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-022
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-022] Sex 30/10 — Informática: T1 Aulas 5–8 · Hardware - Memórias Primárias', '📅 Sex 30/10 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: Hardware e software.

Aulas do Gran (assistir em 1.25x; total 2h10 de vídeo):
- Tópico 1 · Aula 5 — Hardware - Memórias Primárias (31 min)
- Tópico 1 · Aula 6 — Hardware - Memórias Secundárias e Resumo (43 min)
- Tópico 1 · Aula 7 — Conceitos Básicos de Software (25 min)
- Tópico 1 · Aula 8 — Conceitos Básicos de Software II (31 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-10-30 14:00:00',
        22, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-023
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-023] Sex 30/10 — Bateria de questões — Específicos + Informática (2h)', '📅 Sex 30/10 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Específicos e 20 de Informática (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-10-30 19:00:00',
        23, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-024
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-024] Sáb 31/10 — Português — Gramática: T1 Aulas 11–15 · Gramática', '📅 Sáb 31/10 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h55 de vídeo):
- Tópico 1 · Aula 11 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 12 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 13 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 14 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 15 — nome: conferir no Gran (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-10-31 08:00:00',
        24, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-025
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-025] Sáb 31/10 — Raciocínio Lógico: T1 Aulas 7–9 · Tabela Verdade das Proposições Compostas - Questões', '📅 Sáb 31/10 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Lógica.

Aulas do Gran (assistir em 1.25x; total 1h57 de vídeo):
- Tópico 1 · Aula 7 — Tabela Verdade das Proposições Compostas - Questões (30 min)
- Tópico 1 · Aula 8 — Tabela Verdade das Proposições Compostas - Questões II (43 min)
- Tópico 1 · Aula 9 — Tautologia, Contradição e Contingência (44 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-10-31 14:00:00',
        25, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-026
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-026] Sáb 31/10 — Bateria de questões — Português + Raciocínio Lógico (2h)', '📅 Sáb 31/10 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Raciocínio Lógico (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-10-31 19:00:00',
        26, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-027
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-027] Dom 01/11 — 🎯 Simulado da semana — 60 questões (4h)', '📅 Dom 01/11 · ⏰ 08:00

Como candidato(a), quero medir o que ficou da semana em condição de prova.

O que fazer:
- 60 questões das matérias vistas na semana (Caderno de questões do Gran; filtro da banca Consulpam se existir)
- Cronometrar, sem consultar

Critérios de aceite:
- Nota anotada por matéria',
        'Urgente', 'Simulado', 'Simulado', NULL, '2026-11-01 08:00:00',
        27, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-028
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-028] Dom 01/11 — Correção do simulado + revisão da semana (2h)', '📅 Dom 01/11 · ⏰ 14:00

Como candidato(a), quero transformar cada erro em aprendizado.

O que fazer:
- Corrigir questão por questão
- Reler os resumos da semana
- Olhar as cards da próxima semana

Critérios de aceite:
- Caderno de erros atualizado · resto do domingo livre',
        'Alta', 'Simulado', 'Revisão', NULL, '2026-11-01 14:00:00',
        28, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-029
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-029] Seg 02/11 — Direito Administrativo: T1 Aula 9 + T2 Aulas 1–4 · Organização Administrativa e Terceiro Setor - Resumo', '📅 Seg 02/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Organização administrativa, Princípios.

Aulas do Gran (assistir em 1.25x; total 2h42 de vídeo):
- Tópico 1 · Aula 9 — Organização Administrativa e Terceiro Setor - Resumo (33 min)
- Tópico 2 · Aula 1 — Estado, Governo e Administração Pública (33 min)
- Tópico 2 · Aula 2 — Regime Jurídico Administrativo (32 min)
- Tópico 2 · Aula 3 — Princípios do Direito Administrativo (30 min)
- Tópico 2 · Aula 4 — Princípios do Direito Administrativo II (34 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-11-02 08:00:00',
        29, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-030
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-030] Seg 02/11 — Direito Constitucional: T3 Aulas 2–5 · Teoria Geral dos Direitos Fundamentais II', '📅 Seg 02/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Constitucional: Direitos e garantias.

Aulas do Gran (assistir em 1.25x; total 2h02 de vídeo):
- Tópico 3 · Aula 2 — Teoria Geral dos Direitos Fundamentais II (31 min)
- Tópico 3 · Aula 3 — Direitos e Deveres Individuais e Coletivos I (37 min)
- Tópico 3 · Aula 4 — Direitos e Deveres Individuais e Coletivos II (22 min)
- Tópico 3 · Aula 5 — Direitos e Deveres Individuais e Coletivos III (32 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Constitucional', 'Teoria', NULL, '2026-11-02 14:00:00',
        30, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-031
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-031] Seg 02/11 — Bateria de questões — Direito Administrativo + Direito Constitucional (2h)', '📅 Seg 02/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Direito Administrativo e 20 de Direito Constitucional (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-02 19:00:00',
        31, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-032
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-032] Ter 03/11 — Informática: T1 Aulas 9–10 + T2 Aulas 1–3 · Conceitos Básicos de Software III', '📅 Ter 03/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: Hardware e software, Internet e nuvem.

Aulas do Gran (assistir em 1.25x; total 3h07 de vídeo):
- Tópico 1 · Aula 9 — Conceitos Básicos de Software III (34 min)
- Tópico 1 · Aula 10 — Conceitos Básicos de Software IV (39 min)
- Tópico 2 · Aula 1 — Internet - Tipos de Redes (43 min)
- Tópico 2 · Aula 2 — Internet - WWW, Deep Web, Páginas e Sites (31 min)
- Tópico 2 · Aula 3 — Internet - Transferência de Arquivos, Busca, Grupos (40 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-11-03 08:00:00',
        32, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-033
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-033] Ter 03/11 — Português — Gramática: T1 Aulas 16–18 · Gramática', '📅 Ter 03/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 1h45 de vídeo):
- Tópico 1 · Aula 16 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 17 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 18 — nome: conferir no Gran (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-11-03 14:00:00',
        33, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-034
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-034] Ter 03/11 — Bateria de questões — Informática + Português (2h)', '📅 Ter 03/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Informática e 20 de Português (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-03 19:00:00',
        34, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-035
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-035] Qua 04/11 — Específicos (Segurança do Trabalho): T3 Aulas 2–4 + T4 Aulas 1–2 · NR 06 — EPI II', '📅 Qua 04/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Específicos (Segurança do Trabalho): NR 06 — EPI, NR 09 — Exposições a agentes físicos, químicos e biológicos.

Aulas do Gran (assistir em 1.25x; total 2h43 de vídeo):
- Tópico 3 · Aula 2 — NR 06 — EPI II (34 min)
- Tópico 3 · Aula 3 — NR 06 — EPI III (31 min)
- Tópico 3 · Aula 4 — NR 06 - EPI IV (34 min)
- Tópico 4 · Aula 1 — NR 09 — Exposições a agentes físicos, químicos e biológicos (31 min)
- Tópico 4 · Aula 2 — NR 09 — Exposições a agentes físicos, químicos e biológicos II (33 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Específicos (Segurança do Trabalho)', 'Teoria', NULL, '2026-11-04 08:00:00',
        35, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-036
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-036] Qua 04/11 — Raciocínio Lógico: T1 Aulas 10–13 · Diagramas Lógicos', '📅 Qua 04/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Lógica.

Aulas do Gran (assistir em 1.25x; total 2h10 de vídeo):
- Tópico 1 · Aula 10 — Diagramas Lógicos (41 min)
- Tópico 1 · Aula 11 — Lógica de Argumentação - Diagrama Lógico (34 min)
- Tópico 1 · Aula 12 — Lógica de Argumentação - Diagrama Lógico II (30 min)
- Tópico 1 · Aula 13 — Lógica de Argumentação - Diagrama Lógico III (25 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-11-04 14:00:00',
        36, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-037
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-037] Qua 04/11 — Bateria de questões — Específicos + Raciocínio Lógico (2h)', '📅 Qua 04/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Específicos e 20 de Raciocínio Lógico (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-04 19:00:00',
        37, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-038
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-038] Qui 05/11 — Direito Administrativo: T2 Aula 5 + T3 Aulas 1–2 + T4 Aulas 1–3 · Princípios do Direito Administrativo III', '📅 Qui 05/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Princípios, Agentes públicos, Lei 8.112/90.

Aulas do Gran (assistir em 1.25x; total 3h09 de vídeo):
- Tópico 2 · Aula 5 — Princípios do Direito Administrativo III (36 min)
- Tópico 3 · Aula 1 — Agentes Públicos (25 min)
- Tópico 3 · Aula 2 — Agentes Públicos II (29 min)
- Tópico 4 · Aula 1 — Lei 8.112/90 (nome: conferir no Gran) (33 min)
- Tópico 4 · Aula 2 — Lei 8.112/90 (nome: conferir no Gran) (33 min)
- Tópico 4 · Aula 3 — Lei 8.112/90 (nome: conferir no Gran) (33 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-11-05 08:00:00',
        38, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-039
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-039] Qui 05/11 — Direito Constitucional: T3 Aulas 6–9 · Direitos e Deveres Individuais e Coletivos IV', '📅 Qui 05/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Constitucional: Direitos e garantias.

Aulas do Gran (assistir em 1.25x; total 2h09 de vídeo):
- Tópico 3 · Aula 6 — Direitos e Deveres Individuais e Coletivos IV (28 min)
- Tópico 3 · Aula 7 — Direitos e Deveres Individuais e Coletivos V (37 min)
- Tópico 3 · Aula 8 — Direitos e Deveres Individuais e Coletivos VI (37 min)
- Tópico 3 · Aula 9 — Direitos e Deveres Individuais e Coletivos VII (27 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Constitucional', 'Teoria', NULL, '2026-11-05 14:00:00',
        39, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-040
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SEEC-040] Qui 05/11 — Bateria de questões — Direito Administrativo + Direito Constitucional (2h)', '📅 Qui 05/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Direito Administrativo e 20 de Direito Constitucional (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-05 19:00:00',
        40, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-041
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-041] Sex 06/11 — Português — Gramática: T1 Aulas 19–23 · Gramática', '📅 Sex 06/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h55 de vídeo):
- Tópico 1 · Aula 19 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 20 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 21 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 22 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 23 — nome: conferir no Gran (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-11-06 08:00:00',
        41, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-042
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-042] Sex 06/11 — Raciocínio Lógico: T1 Aulas 14–15 + T2 Aulas 1–2 · Lógica de Argumentação - Tabela Verdade', '📅 Sex 06/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Lógica, Contagem e probabilidade.

Aulas do Gran (assistir em 1.25x; total 2h12 de vídeo):
- Tópico 1 · Aula 14 — Lógica de Argumentação - Tabela Verdade (36 min)
- Tópico 1 · Aula 15 — Lógica de Argumentação - Tabela Verdade II (29 min)
- Tópico 2 · Aula 1 — Princípio da Técnica de Contagem - Teoria (29 min)
- Tópico 2 · Aula 2 — Princípio da Técnica de Contagem - Questões (38 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-11-06 14:00:00',
        42, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-043
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-043] Sex 06/11 — Bateria de questões — Português + Raciocínio Lógico (2h)', '📅 Sex 06/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Raciocínio Lógico (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-06 19:00:00',
        43, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-044
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-044] Sáb 07/11 — Português — Interpretação: T2 Aulas 7–12 · Mecanismos de Coesão Textual VI', '📅 Sáb 07/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Interpretação: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 3h00 de vídeo):
- Tópico 2 · Aula 7 — nome: conferir no Gran (30 min)
- Tópico 2 · Aula 8 — nome: conferir no Gran (30 min)
- Tópico 2 · Aula 9 — nome: conferir no Gran (30 min)
- Tópico 2 · Aula 10 — Mecanismos de Coesão Textual VI (31 min)
- Tópico 2 · Aula 11 — Significação de Palavras (29 min)
- Tópico 2 · Aula 12 — Significação de Palavras (parte 2) (30 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Interpretação', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-11-07 08:00:00',
        44, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-045
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-045] Sáb 07/11 — Direito Administrativo: T4 Aulas 4–6 · Lei 8.112/90 IV', '📅 Sáb 07/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Lei 8.112/90.

Aulas do Gran (assistir em 1.25x; total 1h39 de vídeo):
- Tópico 4 · Aula 4 — Lei 8.112/90 IV (35 min)
- Tópico 4 · Aula 5 — Lei 8.112/90 V (30 min)
- Tópico 4 · Aula 6 — Lei 8.112/90 VI (34 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-11-07 14:00:00',
        45, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-046
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-046] Sáb 07/11 — Bateria de questões — Português + Direito Administrativo (2h)', '📅 Sáb 07/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Direito Administrativo (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-07 19:00:00',
        46, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-047
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-047] Dom 08/11 — 🎯 Simulado da semana — 60 questões (4h)', '📅 Dom 08/11 · ⏰ 08:00

Como candidato(a), quero medir o que ficou da semana em condição de prova.

O que fazer:
- 60 questões das matérias vistas na semana (Caderno de questões do Gran; filtro da banca Consulpam se existir)
- Cronometrar, sem consultar

Critérios de aceite:
- Nota anotada por matéria',
        'Urgente', 'Simulado', 'Simulado', NULL, '2026-11-08 08:00:00',
        47, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-048
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-048] Dom 08/11 — Correção do simulado + revisão da semana (2h)', '📅 Dom 08/11 · ⏰ 14:00

Como candidato(a), quero transformar cada erro em aprendizado.

O que fazer:
- Corrigir questão por questão
- Reler os resumos da semana
- Olhar as cards da próxima semana

Critérios de aceite:
- Caderno de erros atualizado · resto do domingo livre',
        'Alta', 'Simulado', 'Revisão', NULL, '2026-11-08 14:00:00',
        48, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-049
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-049] Seg 09/11 — Português — Gramática: T1 Aulas 24–28 · Gramática', '📅 Seg 09/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h55 de vídeo):
- Tópico 1 · Aula 24 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 25 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 26 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 27 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 28 — nome: conferir no Gran (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-11-09 08:00:00',
        49, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-050
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-050] Seg 09/11 — Informática: T2 Aulas 4–5 + T3 Aulas 1–2 · Internet - Redes Sociais e Computação na Nuvem', '📅 Seg 09/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: Internet e nuvem, Office.

Aulas do Gran (assistir em 1.25x; total 1h47 de vídeo):
- Tópico 2 · Aula 4 — Internet - Redes Sociais e Computação na Nuvem (34 min)
- Tópico 2 · Aula 5 — Internet - Acesso a Distância a Computadores (13 min)
- Tópico 3 · Aula 1 — Word 365 - Características Principais (30 min)
- Tópico 3 · Aula 2 — Word 365 - Guias, Faixa de Opções e Grupos (30 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-11-09 14:00:00',
        50, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-051
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-051] Seg 09/11 — Bateria de questões — Português + Informática (2h)', '📅 Seg 09/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Informática (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-09 19:00:00',
        51, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-052
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-052] Ter 10/11 — Específicos (Segurança do Trabalho): T4 Aulas 3–4 + T5 Aulas 1–3 · NR 09 — Exposições a agentes físicos, químicos e biológicos III', '📅 Ter 10/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Específicos (Segurança do Trabalho): NR 09 — Exposições a agentes físicos, químicos e biológicos, NR 10 — Eletricidade.

Aulas do Gran (assistir em 1.25x; total 2h49 de vídeo):
- Tópico 4 · Aula 3 — NR 09 — Exposições a agentes físicos, químicos e biológicos III (31 min)
- Tópico 4 · Aula 4 — NR 09 - Exercícios (42 min)
- Tópico 5 · Aula 1 — NR 10 — Eletricidade (31 min)
- Tópico 5 · Aula 2 — NR 10 — Eletricidade II (30 min)
- Tópico 5 · Aula 3 — NR 10 — Eletricidade III (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Específicos (Segurança do Trabalho)', 'Teoria', NULL, '2026-11-10 08:00:00',
        52, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-053
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-053] Ter 10/11 — Direito Constitucional: T3 Aulas 10–12 + T4 Aula 1 · Direitos e Deveres Individuais e Coletivos VIII', '📅 Ter 10/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Constitucional: Direitos e garantias, Organização político-administrativa.

Aulas do Gran (assistir em 1.25x; total 2h01 de vídeo):
- Tópico 3 · Aula 10 — Direitos e Deveres Individuais e Coletivos VIII (33 min)
- Tópico 3 · Aula 11 — Direitos e Deveres Individuais e Coletivos IX (34 min)
- Tópico 3 · Aula 12 — Direitos e Deveres Individuais e Coletivos X (33 min)
- Tópico 4 · Aula 1 — Organização Político-Administrativa (21 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Constitucional', 'Teoria', NULL, '2026-11-10 14:00:00',
        53, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-054
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-054] Ter 10/11 — Bateria de questões — Específicos + Direito Constitucional (2h)', '📅 Ter 10/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Específicos e 20 de Direito Constitucional (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-10 19:00:00',
        54, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-055
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-055] Qua 11/11 — Português — Gramática: T1 Aulas 29–33 · Gramática', '📅 Qua 11/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h55 de vídeo):
- Tópico 1 · Aula 29 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 30 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 31 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 32 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 33 — nome: conferir no Gran (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-11-11 08:00:00',
        55, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-056
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-056] Qua 11/11 — Direito Administrativo: T4 Aulas 7–9 · Lei 8.112/90 VII', '📅 Qua 11/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Lei 8.112/90.

Aulas do Gran (assistir em 1.25x; total 1h51 de vídeo):
- Tópico 4 · Aula 7 — Lei 8.112/90 VII (37 min)
- Tópico 4 · Aula 8 — Lei 8.112/90 VIII (36 min)
- Tópico 4 · Aula 9 — Lei 8.112/90 IX (38 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-11-11 14:00:00',
        56, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-057
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-057] Qua 11/11 — Bateria de questões — Português + Direito Administrativo (2h)', '📅 Qua 11/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Direito Administrativo (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-11 19:00:00',
        57, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-058
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-058] Qui 12/11 — Informática: T3 Aulas 3–8 · Word 365 - Guia Arquivo', '📅 Qui 12/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: Office.

Aulas do Gran (assistir em 1.25x; total 3h05 de vídeo):
- Tópico 3 · Aula 3 — Word 365 - Guia Arquivo (30 min)
- Tópico 3 · Aula 4 — Word 365 - Guia Página Inicial (32 min)
- Tópico 3 · Aula 5 — Word 365 - Guia Inserir (31 min)
- Tópico 3 · Aula 6 — Word 365 - Inserir Tabelas (29 min)
- Tópico 3 · Aula 7 — Word 365 - Inserir Ilustrações (31 min)
- Tópico 3 · Aula 8 — Word 365 - Desenhar, Design e Layout (32 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-11-12 08:00:00',
        58, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-059
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-059] Qui 12/11 — Raciocínio Lógico: T2 Aulas 3–6 · Permutação - Teoria', '📅 Qui 12/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Contagem e probabilidade.

Aulas do Gran (assistir em 1.25x; total 2h05 de vídeo):
- Tópico 2 · Aula 3 — Permutação - Teoria (26 min)
- Tópico 2 · Aula 4 — Permutação - Questões de Concurso (28 min)
- Tópico 2 · Aula 5 — Permutação com Repetição (43 min)
- Tópico 2 · Aula 6 — Permutação Circular (28 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-11-12 14:00:00',
        59, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-060
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SEEC-060] Qui 12/11 — Bateria de questões — Informática + Raciocínio Lógico (2h)', '📅 Qui 12/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Informática e 20 de Raciocínio Lógico (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-12 19:00:00',
        60, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-061
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-061] Sex 13/11 — Direito Constitucional: T4 Aulas 2–7 · Organização Político-Administrativa II', '📅 Sex 13/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Constitucional: Organização político-administrativa.

Aulas do Gran (assistir em 1.25x; total 2h49 de vídeo):
- Tópico 4 · Aula 2 — Organização Político-Administrativa II (30 min)
- Tópico 4 · Aula 3 — Formação de Novos Estados e Municípios (19 min)
- Tópico 4 · Aula 4 — União (25 min)
- Tópico 4 · Aula 5 — Estados (36 min)
- Tópico 4 · Aula 6 — Estados II (22 min)
- Tópico 4 · Aula 7 — Municípios (37 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Constitucional', 'Teoria', NULL, '2026-11-13 08:00:00',
        61, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-062
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-062] Sex 13/11 — Direito Administrativo: T4 Aulas 10–13 · Lei 8.112/90 X', '📅 Sex 13/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Lei 8.112/90.

Aulas do Gran (assistir em 1.25x; total 2h06 de vídeo):
- Tópico 4 · Aula 10 — Lei 8.112/90 X (36 min)
- Tópico 4 · Aula 11 — Lei 8.112/90 XI (27 min)
- Tópico 4 · Aula 12 — Lei 8.112/90 XII (36 min)
- Tópico 4 · Aula 13 — Lei 8.112/90 XIII (27 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-11-13 14:00:00',
        62, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-063
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-063] Sex 13/11 — Bateria de questões — Direito Constitucional + Direito Administrativo (2h)', '📅 Sex 13/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Direito Constitucional e 20 de Direito Administrativo (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-13 19:00:00',
        63, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-064
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-064] Sáb 14/11 — Português — Gramática: T1 Aulas 34–38 · Gramática', '📅 Sáb 14/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h55 de vídeo):
- Tópico 1 · Aula 34 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 35 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 36 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 37 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 38 — nome: conferir no Gran (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-11-14 08:00:00',
        64, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-065
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-065] Sáb 14/11 — Específicos (Segurança do Trabalho): T5 Aulas 4–5 + T6 Aulas 1–2 · NR 10 — Eletricidade IV', '📅 Sáb 14/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Específicos (Segurança do Trabalho): NR 10 — Eletricidade, NR 16 — Atividades perigosas.

Aulas do Gran (assistir em 1.25x; total 2h06 de vídeo):
- Tópico 5 · Aula 4 — NR 10 — Eletricidade IV (31 min)
- Tópico 5 · Aula 5 — NR 10 - Questões (33 min)
- Tópico 6 · Aula 1 — NR 16 — Atividades perigosas (37 min)
- Tópico 6 · Aula 2 — NR 16 — Atividades perigosas II (25 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Específicos (Segurança do Trabalho)', 'Teoria', NULL, '2026-11-14 14:00:00',
        65, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-066
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-066] Sáb 14/11 — Bateria de questões — Português + Específicos (2h)', '📅 Sáb 14/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Específicos (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-14 19:00:00',
        66, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-067
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-067] Dom 15/11 — 🎯 Simulado da semana — 60 questões (4h)', '📅 Dom 15/11 · ⏰ 08:00

Como candidato(a), quero medir o que ficou da semana em condição de prova.

O que fazer:
- 60 questões das matérias vistas na semana (Caderno de questões do Gran; filtro da banca Consulpam se existir)
- Cronometrar, sem consultar

Critérios de aceite:
- Nota anotada por matéria',
        'Urgente', 'Simulado', 'Simulado', NULL, '2026-11-15 08:00:00',
        67, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-068
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-068] Dom 15/11 — Correção do simulado + revisão da semana (2h)', '📅 Dom 15/11 · ⏰ 14:00

Como candidato(a), quero transformar cada erro em aprendizado.

O que fazer:
- Corrigir questão por questão
- Reler os resumos da semana
- Olhar as cards da próxima semana

Critérios de aceite:
- Caderno de erros atualizado · resto do domingo livre',
        'Alta', 'Simulado', 'Revisão', NULL, '2026-11-15 14:00:00',
        68, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-069
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-069] Seg 16/11 — DF e RIDE: T1 Aulas 5–10 · História do DF (parte 3)', '📅 Seg 16/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar DF e RIDE: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h58 de vídeo):
- Tópico 1 · Aula 5 — História do DF (parte 3) (32 min)
- Tópico 1 · Aula 6 — Principais Monumentos (26 min)
- Tópico 1 · Aula 7 — Principais Monumentos II (25 min)
- Tópico 1 · Aula 8 — Geografia do DF (30 min)
- Tópico 1 · Aula 9 — Geografia do DF II (33 min)
- Tópico 1 · Aula 10 — Geografia III (32 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'DF e RIDE', 'Teoria', NULL, '2026-11-16 08:00:00',
        69, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag7);
-- SEEC-070
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-070] Seg 16/11 — Direito Administrativo: T4 Aulas 14–15 + T5 Aulas 1–2 · Lei 8.112/90 - Aula Resumo', '📅 Seg 16/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Lei 8.112/90, Processo administrativo.

Aulas do Gran (assistir em 1.25x; total 2h01 de vídeo):
- Tópico 4 · Aula 14 — Lei 8.112/90 - Aula Resumo (30 min)
- Tópico 4 · Aula 15 — Lei 8.112/90 - Aula Resumo II (27 min)
- Tópico 5 · Aula 1 — Processo Administrativo (32 min)
- Tópico 5 · Aula 2 — Processo Administrativo II (32 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-11-16 14:00:00',
        70, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-071
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-071] Seg 16/11 — Bateria de questões — DF e RIDE + Direito Administrativo (2h)', '📅 Seg 16/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de DF e RIDE e 20 de Direito Administrativo (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-16 19:00:00',
        71, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag7);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-072
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-072] Ter 17/11 — Raciocínio Lógico: T2 Aulas 7–11 · Arranjo e Combinação - Teoria', '📅 Ter 17/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Contagem e probabilidade.

Aulas do Gran (assistir em 1.25x; total 2h59 de vídeo):
- Tópico 2 · Aula 7 — Arranjo e Combinação - Teoria (45 min)
- Tópico 2 · Aula 8 — Arranjo e Combinação II (37 min)
- Tópico 2 · Aula 9 — Arranjo e Combinação III (40 min)
- Tópico 2 · Aula 10 — Probabilidade - Teoria (28 min)
- Tópico 2 · Aula 11 — Probabilidade II (29 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-11-17 08:00:00',
        72, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-073
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-073] Ter 17/11 — Português — Gramática: T1 Aulas 39–41 · Gramática', '📅 Ter 17/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 1h45 de vídeo):
- Tópico 1 · Aula 39 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 40 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 41 — nome: conferir no Gran (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-11-17 14:00:00',
        73, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-074
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-074] Ter 17/11 — Bateria de questões — Raciocínio Lógico + Português (2h)', '📅 Ter 17/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Raciocínio Lógico e 20 de Português (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-17 19:00:00',
        74, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-075
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-075] Qua 18/11 — Específicos (Segurança do Trabalho): T7 Aulas 1–4 + T8 Aulas 1–2 · NR 17 - Avaliação Ergonômica Preliminar', '📅 Qua 18/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Específicos (Segurança do Trabalho): NR 17 — Ergonomia, NR 23 — Comportamento do fogo.

Aulas do Gran (assistir em 1.25x; total 2h51 de vídeo):
- Tópico 7 · Aula 1 — NR 17 - Avaliação Ergonômica Preliminar (32 min)
- Tópico 7 · Aula 2 — NR 17 - Análise Ergonômica do Trabalho (30 min)
- Tópico 7 · Aula 3 — NR 17 - Organização do Trabalho/Materiais (28 min)
- Tópico 7 · Aula 4 — NR 17 - Posto de Trabalho/Resumo (15 min)
- Tópico 8 · Aula 1 — NR 23 — Comportamento do fogo (30 min)
- Tópico 8 · Aula 2 — NR 23 — Comportamento do fogo II (36 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Específicos (Segurança do Trabalho)', 'Teoria', NULL, '2026-11-18 08:00:00',
        75, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-076
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-076] Qua 18/11 — Informática: T3 Aulas 9–11 · Word 365 - Referências e Correspondências', '📅 Qua 18/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: Office.

Aulas do Gran (assistir em 1.25x; total 1h44 de vídeo):
- Tópico 3 · Aula 9 — Word 365 - Referências e Correspondências (30 min)
- Tópico 3 · Aula 10 — Word 365 - Revisão, Exibir, Cursor e Seleção (44 min)
- Tópico 3 · Aula 11 — Excel 365 - Características Principais (30 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-11-18 14:00:00',
        76, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-077
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-077] Qua 18/11 — Bateria de questões — Específicos + Informática (2h)', '📅 Qua 18/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Específicos e 20 de Informática (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-18 19:00:00',
        77, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-078
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-078] Qui 19/11 — Português — Gramática: T1 Aulas 42–46 · Gramática', '📅 Qui 19/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h55 de vídeo):
- Tópico 1 · Aula 42 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 43 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 44 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 45 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 46 — nome: conferir no Gran (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-11-19 08:00:00',
        78, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-079
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-079] Qui 19/11 — Direito Constitucional: T4 Aulas 8–11 · Municípios II', '📅 Qui 19/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Constitucional: Organização político-administrativa.

Aulas do Gran (assistir em 1.25x; total 1h53 de vídeo):
- Tópico 4 · Aula 8 — Municípios II (37 min)
- Tópico 4 · Aula 9 — Distrito Federal e Territórios (26 min)
- Tópico 4 · Aula 10 — Repartição de Competências (17 min)
- Tópico 4 · Aula 11 — Repartição de Competências II (33 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Constitucional', 'Teoria', NULL, '2026-11-19 14:00:00',
        79, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-080
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SEEC-080] Qui 19/11 — Bateria de questões — Português + Direito Constitucional (2h)', '📅 Qui 19/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Direito Constitucional (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-19 19:00:00',
        80, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-081
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-081] Sex 20/11 — Direito Administrativo: T5 Aulas 3–7 · Lei 9.784/1999', '📅 Sex 20/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Processo administrativo.

Aulas do Gran (assistir em 1.25x; total 3h05 de vídeo):
- Tópico 5 · Aula 3 — Lei 9.784/1999 (34 min)
- Tópico 5 · Aula 4 — Lei 9.784/1999 II (31 min)
- Tópico 5 · Aula 5 — Lei 9.784/1999 III (33 min)
- Tópico 5 · Aula 6 — Lei 9.784/1999 IV (42 min)
- Tópico 5 · Aula 7 — Processo Administrativo - Resumo (45 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-11-20 08:00:00',
        81, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-082
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-082] Sex 20/11 — Português — Gramática: T1 Aulas 47–49 · Gramática', '📅 Sex 20/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 1h45 de vídeo):
- Tópico 1 · Aula 47 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 48 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 49 — nome: conferir no Gran (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-11-20 14:00:00',
        82, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-083
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-083] Sex 20/11 — Bateria de questões — Direito Administrativo + Português (2h)', '📅 Sex 20/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Direito Administrativo e 20 de Português (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-20 19:00:00',
        83, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-084
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-084] Sáb 21/11 — Informática: T3 Aulas 12–13 + T4 Aulas 1–4 · Excel 365 - Intervalos de Células', '📅 Sáb 21/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: Office, Navegadores.

Aulas do Gran (assistir em 1.25x; total 3h02 de vídeo):
- Tópico 3 · Aula 12 — Excel 365 - Intervalos de Células (32 min)
- Tópico 3 · Aula 13 — Excel 365 - Operadores (25 min)
- Tópico 4 · Aula 1 — Google Chrome (28 min)
- Tópico 4 · Aula 2 — Google Chrome II (29 min)
- Tópico 4 · Aula 3 — Google Chrome III (31 min)
- Tópico 4 · Aula 4 — Google Chrome IV (37 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-11-21 08:00:00',
        84, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-085
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-085] Sáb 21/11 — Raciocínio Lógico: T2 Aulas 12–13 + T3 Aulas 1–2 · Probabilidade III', '📅 Sáb 21/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Contagem e probabilidade, Conjuntos.

Aulas do Gran (assistir em 1.25x; total 2h02 de vídeo):
- Tópico 2 · Aula 12 — Probabilidade III (40 min)
- Tópico 2 · Aula 13 — Probabilidade IV (38 min)
- Tópico 3 · Aula 1 — Operação com Conjuntos (22 min)
- Tópico 3 · Aula 2 — Operação com Conjuntos - Diagrama de Venn (22 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-11-21 14:00:00',
        85, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-086
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-086] Sáb 21/11 — Bateria de questões — Informática + Raciocínio Lógico (2h)', '📅 Sáb 21/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Informática e 20 de Raciocínio Lógico (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-21 19:00:00',
        86, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-087
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-087] Dom 22/11 — 🎯 Simulado da semana — 60 questões (4h)', '📅 Dom 22/11 · ⏰ 08:00

Como candidato(a), quero medir o que ficou da semana em condição de prova.

O que fazer:
- 60 questões das matérias vistas na semana (Caderno de questões do Gran; filtro da banca Consulpam se existir)
- Cronometrar, sem consultar

Critérios de aceite:
- Nota anotada por matéria',
        'Urgente', 'Simulado', 'Simulado', NULL, '2026-11-22 08:00:00',
        87, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-088
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-088] Dom 22/11 — Correção do simulado + revisão da semana (2h)', '📅 Dom 22/11 · ⏰ 14:00

Como candidato(a), quero transformar cada erro em aprendizado.

O que fazer:
- Corrigir questão por questão
- Reler os resumos da semana
- Olhar as cards da próxima semana

Critérios de aceite:
- Caderno de erros atualizado · resto do domingo livre',
        'Alta', 'Simulado', 'Revisão', NULL, '2026-11-22 14:00:00',
        88, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-089
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-089] Seg 23/11 — Português — Interpretação: T2 Aulas 13–18 · Reescritas de Trechos e Parágrafos dos Textos', '📅 Seg 23/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Interpretação: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h58 de vídeo):
- Tópico 2 · Aula 13 — Reescritas de Trechos e Parágrafos dos Textos (30 min)
- Tópico 2 · Aula 14 — Figuras de Linguagem (30 min)
- Tópico 2 · Aula 15 — Figuras de Linguagem II (30 min)
- Tópico 2 · Aula 16 — Figuras de Linguagem II (parte 2) (30 min)
- Tópico 2 · Aula 17 — Figuras de Linguagem III (31 min)
- Tópico 2 · Aula 18 — Figuras de Linguagem IV (27 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Interpretação', 'Teoria', NULL, '2026-11-23 08:00:00',
        89, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-090
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-090] Seg 23/11 — Direito Constitucional: T4 Aula 12 + T5 Aulas 1–2 · Repartição de Competências III', '📅 Seg 23/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Constitucional: Organização político-administrativa, Administração pública.

Aulas do Gran (assistir em 1.25x; total 1h34 de vídeo):
- Tópico 4 · Aula 12 — Repartição de Competências III (43 min)
- Tópico 5 · Aula 1 — Adm. Pública - Princípios (36 min)
- Tópico 5 · Aula 2 — Adm. Pública - Princípios II (15 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Constitucional', 'Teoria', NULL, '2026-11-23 14:00:00',
        90, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-091
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-091] Seg 23/11 — Bateria de questões — Português + Direito Constitucional (2h)', '📅 Seg 23/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Direito Constitucional (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-23 19:00:00',
        91, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-092
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-092] Ter 24/11 — Português — Gramática: T1 Aulas 50–53 · Pronomes Pessoais e Colocação Pronominal III', '📅 Ter 24/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h30 de vídeo):
- Tópico 1 · Aula 50 — nome: conferir no Gran (35 min)
- Tópico 1 · Aula 51 — Pronomes Pessoais e Colocação Pronominal III (38 min)
- Tópico 1 · Aula 52 — Pronomes Pessoais e Colocação Pronominal IV (42 min)
- Tópico 1 · Aula 53 — Pronomes Pessoais e Colocação Pronominal V (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', '⚠️ Algumas aulas aparecem como ''conferir o nome no Gran'' porque a página não listou o início do tópico. Siga a ordem do Gran.', '2026-11-24 08:00:00',
        92, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-093
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-093] Ter 24/11 — Específicos (Segurança do Trabalho): T8 Aulas 3–5 · NR 23 — Comportamento do fogo III', '📅 Ter 24/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Específicos (Segurança do Trabalho): NR 23 — Comportamento do fogo.

Aulas do Gran (assistir em 1.25x; total 1h51 de vídeo):
- Tópico 8 · Aula 3 — NR 23 — Comportamento do fogo III (40 min)
- Tópico 8 · Aula 4 — NR 23 — Comportamento do fogo IV (34 min)
- Tópico 8 · Aula 5 — NR 23 — Comportamento do fogo V (37 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Específicos (Segurança do Trabalho)', 'Teoria', NULL, '2026-11-24 14:00:00',
        93, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-094
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-094] Ter 24/11 — Bateria de questões — Português + Específicos (2h)', '📅 Ter 24/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Específicos (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-24 19:00:00',
        94, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-095
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-095] Qua 25/11 — Direito Administrativo: T6 Aulas 1–5 · Poderes Administrativos', '📅 Qua 25/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Poderes.

Aulas do Gran (assistir em 1.25x; total 2h44 de vídeo):
- Tópico 6 · Aula 1 — Poderes Administrativos (31 min)
- Tópico 6 · Aula 2 — Poderes Administrativos II (31 min)
- Tópico 6 · Aula 3 — Poderes Administrativos III (29 min)
- Tópico 6 · Aula 4 — Poderes Administrativos IV (40 min)
- Tópico 6 · Aula 5 — Poderes Administrativos - Resumo (33 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-11-25 08:00:00',
        95, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-096
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-096] Qua 25/11 — Português — Gramática: T1 Aulas 54–56 · Pronomes Pessoais e Colocação Pronominal - Exercícios', '📅 Qua 25/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 1h58 de vídeo):
- Tópico 1 · Aula 54 — Pronomes Pessoais e Colocação Pronominal - Exercícios (42 min)
- Tópico 1 · Aula 55 — Vozes verbais e Funções do SE (38 min)
- Tópico 1 · Aula 56 — Vozes verbais e Funções do SE II (38 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', NULL, '2026-11-25 14:00:00',
        96, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-097
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-097] Qua 25/11 — Bateria de questões — Direito Administrativo + Português (2h)', '📅 Qua 25/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Direito Administrativo e 20 de Português (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-25 19:00:00',
        97, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-098
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-098] Qui 26/11 — Direito Constitucional: T5 Aulas 3–8 · Cargos Públicos', '📅 Qui 26/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Constitucional: Administração pública.

Aulas do Gran (assistir em 1.25x; total 3h08 de vídeo):
- Tópico 5 · Aula 3 — Cargos Públicos (49 min)
- Tópico 5 · Aula 4 — Teto de Remuneração (39 min)
- Tópico 5 · Aula 5 — Acumulação de Cargos Públicos (30 min)
- Tópico 5 · Aula 6 — Improbidade Administrativa (29 min)
- Tópico 5 · Aula 7 — Responsabilidade Civil do Estado (33 min)
- Tópico 5 · Aula 8 — Servidor no Exercício de Mandato Eletivo (8 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Constitucional', 'Teoria', NULL, '2026-11-26 08:00:00',
        98, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-099
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-099] Qui 26/11 — Raciocínio Lógico: T3 Aulas 3–4 + T4 Aulas 1–2 · Operação com Conjuntos - Diagrama de Venn II', '📅 Qui 26/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Conjuntos, Problemas lógicos.

Aulas do Gran (assistir em 1.25x; total 2h11 de vídeo):
- Tópico 3 · Aula 3 — Operação com Conjuntos - Diagrama de Venn II (31 min)
- Tópico 3 · Aula 4 — Operação com Conjuntos - Diagrama de Venn III (38 min)
- Tópico 4 · Aula 1 — Associação Lógica (26 min)
- Tópico 4 · Aula 2 — Associação Lógica II (36 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-11-26 14:00:00',
        99, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-100
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SEEC-100] Qui 26/11 — Bateria de questões — Direito Constitucional + Raciocínio Lógico (2h)', '📅 Qui 26/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Direito Constitucional e 20 de Raciocínio Lógico (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-26 19:00:00',
        100, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-101
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-101] Sex 27/11 — Específicos (Segurança do Trabalho): T8 Aulas 6–7 + T9 Aulas 1–3 + T10 Aula 1 · NR 23 — Comportamento do fogo VI', '📅 Sex 27/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Específicos (Segurança do Trabalho): NR 23 — Comportamento do fogo, NR 24 — Condições sanitárias e de conforto, NR 33 — Espaços confinados.

Aulas do Gran (assistir em 1.25x; total 3h03 de vídeo):
- Tópico 8 · Aula 6 — NR 23 — Comportamento do fogo VI (34 min)
- Tópico 8 · Aula 7 — NR 23 — Comportamento do fogo VII (24 min)
- Tópico 9 · Aula 1 — NR 24 — Condições sanitárias e de conforto (31 min)
- Tópico 9 · Aula 2 — NR 24 — Condições sanitárias e de conforto II (30 min)
- Tópico 9 · Aula 3 — NR 24 — Condições sanitárias e de conforto III (33 min)
- Tópico 10 · Aula 1 — NR 33 — Espaços confinados (31 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Específicos (Segurança do Trabalho)', 'Teoria', NULL, '2026-11-27 08:00:00',
        101, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-102
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-102] Sex 27/11 — Português — Gramática: T1 Aulas 57–59 · Vozes verbais e Funções do SE III', '📅 Sex 27/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 1h57 de vídeo):
- Tópico 1 · Aula 57 — Vozes verbais e Funções do SE III (42 min)
- Tópico 1 · Aula 58 — Vozes Verbais e Funções do SE IV (38 min)
- Tópico 1 · Aula 59 — Vozes Verbais e Funções do SE V (37 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', NULL, '2026-11-27 14:00:00',
        102, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-103
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-103] Sex 27/11 — Bateria de questões — Específicos + Português (2h)', '📅 Sex 27/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Específicos e 20 de Português (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-27 19:00:00',
        103, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-104
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-104] Sáb 28/11 — Direito Administrativo: T7 Aulas 1–5 · Atos Administrativos', '📅 Sáb 28/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Atos.

Aulas do Gran (assistir em 1.25x; total 2h46 de vídeo):
- Tópico 7 · Aula 1 — Atos Administrativos (34 min)
- Tópico 7 · Aula 2 — Atos Administrativos II (33 min)
- Tópico 7 · Aula 3 — Atos Administrativos III (35 min)
- Tópico 7 · Aula 4 — Atos Administrativos IV (32 min)
- Tópico 7 · Aula 5 — Atos Administrativos V (32 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-11-28 08:00:00',
        104, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-105
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-105] Sáb 28/11 — Informática: T4 Aulas 5–8 · Mozilla Firefox', '📅 Sáb 28/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: Navegadores.

Aulas do Gran (assistir em 1.25x; total 1h56 de vídeo):
- Tópico 4 · Aula 5 — Mozilla Firefox (31 min)
- Tópico 4 · Aula 6 — Mozilla Firefox II (28 min)
- Tópico 4 · Aula 7 — Mozilla Firefox III (28 min)
- Tópico 4 · Aula 8 — Mozilla Firefox IV (29 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-11-28 14:00:00',
        105, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-106
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-106] Sáb 28/11 — Bateria de questões — Direito Administrativo + Informática (2h)', '📅 Sáb 28/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Direito Administrativo e 20 de Informática (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-28 19:00:00',
        106, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-107
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-107] Dom 29/11 — 🎯 Simulado da semana — 60 questões (4h)', '📅 Dom 29/11 · ⏰ 08:00

Como candidato(a), quero medir o que ficou da semana em condição de prova.

O que fazer:
- 60 questões das matérias vistas na semana (Caderno de questões do Gran; filtro da banca Consulpam se existir)
- Cronometrar, sem consultar

Critérios de aceite:
- Nota anotada por matéria',
        'Urgente', 'Simulado', 'Simulado', NULL, '2026-11-29 08:00:00',
        107, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-108
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-108] Dom 29/11 — Correção do simulado + revisão da semana (2h)', '📅 Dom 29/11 · ⏰ 14:00

Como candidato(a), quero transformar cada erro em aprendizado.

O que fazer:
- Corrigir questão por questão
- Reler os resumos da semana
- Olhar as cards da próxima semana

Critérios de aceite:
- Caderno de erros atualizado · resto do domingo livre',
        'Alta', 'Simulado', 'Revisão', NULL, '2026-11-29 14:00:00',
        108, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-109
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-109] Seg 30/11 — Política para Mulheres: T1 Aulas 7–11 · Decreto 42.590/2021 - Resolução de Questões IV', '📅 Seg 30/11 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Política para Mulheres: Decreto 42.590/2021.

Aulas do Gran (assistir em 1.25x; total 2h25 de vídeo):
- Tópico 1 · Aula 7 — Decreto 42.590/2021 - Resolução de Questões IV (27 min)
- Tópico 1 · Aula 8 — Decreto 42.590/2021 - Resolução de Questões V (30 min)
- Tópico 1 · Aula 9 — Decreto 42.590/2021 - Resolução de Questões VI (26 min)
- Tópico 1 · Aula 10 — Decreto 42.590/2021 - Resolução de Questões VII (31 min)
- Tópico 1 · Aula 11 — Decreto 42.590/2021 - Resolução de Questões VIII (31 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Política para Mulheres', 'Teoria', NULL, '2026-11-30 08:00:00',
        109, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag8);
-- SEEC-110
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-110] Seg 30/11 — Português — Gramática: T1 Aulas 60–62 · Crase', '📅 Seg 30/11 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 1h49 de vídeo):
- Tópico 1 · Aula 60 — Crase (41 min)
- Tópico 1 · Aula 61 — Crase II (37 min)
- Tópico 1 · Aula 62 — Crase III (31 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', NULL, '2026-11-30 14:00:00',
        110, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-111
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-111] Seg 30/11 — Bateria de questões — Política para Mulheres + Português (2h)', '📅 Seg 30/11 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Política para Mulheres e 20 de Português (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-11-30 19:00:00',
        111, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag8);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-112
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-112] Ter 01/12 — Raciocínio Lógico: T4 Aulas 3–7 · Orientação Espacial e Temporal', '📅 Ter 01/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Problemas lógicos.

Aulas do Gran (assistir em 1.25x; total 2h41 de vídeo):
- Tópico 4 · Aula 3 — Orientação Espacial e Temporal (33 min)
- Tópico 4 · Aula 4 — Orientação Espacial e Temporal II (27 min)
- Tópico 4 · Aula 5 — Raciocínio Sequencial (30 min)
- Tópico 4 · Aula 6 — Raciocínio Sequencial II (32 min)
- Tópico 4 · Aula 7 — Problemas com Calendários (39 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-12-01 08:00:00',
        112, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-113
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-113] Ter 01/12 — Informática: T4 Aulas 9–12 · MS Edge', '📅 Ter 01/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: Navegadores.

Aulas do Gran (assistir em 1.25x; total 2h01 de vídeo):
- Tópico 4 · Aula 9 — MS Edge (30 min)
- Tópico 4 · Aula 10 — MS Edge II (30 min)
- Tópico 4 · Aula 11 — MS Edge III (31 min)
- Tópico 4 · Aula 12 — MS Edge IV (30 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-12-01 14:00:00',
        113, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-114
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-114] Ter 01/12 — Bateria de questões — Raciocínio Lógico + Informática (2h)', '📅 Ter 01/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Raciocínio Lógico e 20 de Informática (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-01 19:00:00',
        114, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-115
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-115] Qua 02/12 — Português — Gramática: T1 Aulas 63–65 · Crase - Exercícios', '📅 Qua 02/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h55 de vídeo):
- Tópico 1 · Aula 63 — Crase - Exercícios (59 min)
- Tópico 1 · Aula 64 — Reescrita e Reconhecimento de Frases Corretas/Incorretas (76 min)
- Tópico 1 · Aula 65 — Casos Especiais de Concordância Verbal e Nominal (40 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', NULL, '2026-12-02 08:00:00',
        115, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-116
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-116] Qua 02/12 — Direito Administrativo: T7 Aula 6 + T8 Aulas 1–3 · Atos Administrativos - Resumo', '📅 Qua 02/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Atos, Controle.

Aulas do Gran (assistir em 1.25x; total 2h14 de vídeo):
- Tópico 7 · Aula 6 — Atos Administrativos - Resumo (35 min)
- Tópico 8 · Aula 1 — Controle da Administração Pública (33 min)
- Tópico 8 · Aula 2 — Controle da Administração Pública II (32 min)
- Tópico 8 · Aula 3 — Controle da Administração Pública III (34 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-12-02 14:00:00',
        116, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-117
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-117] Qua 02/12 — Bateria de questões — Português + Direito Administrativo (2h)', '📅 Qua 02/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Direito Administrativo (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-02 19:00:00',
        117, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-118
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-118] Qui 03/12 — Direito Constitucional: T5 Aulas 9–12 + T6 Aula 1 · Aposentadorias e Pensões', '📅 Qui 03/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Constitucional: Administração pública, Poder Judiciário.

Aulas do Gran (assistir em 1.25x; total 2h44 de vídeo):
- Tópico 5 · Aula 9 — Aposentadorias e Pensões (36 min)
- Tópico 5 · Aula 10 — Aposentadorias e Pensões II (38 min)
- Tópico 5 · Aula 11 — Aposentadorias e Pensões III (29 min)
- Tópico 5 · Aula 12 — Aposentadorias e Pensões IV (34 min)
- Tópico 6 · Aula 1 — Poder Judiciário - Introdução (27 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Constitucional', 'Teoria', NULL, '2026-12-03 08:00:00',
        118, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-119
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-119] Qui 03/12 — Específicos (Segurança do Trabalho): T10 Aulas 2–4 · NR 33 — Espaços confinados II', '📅 Qui 03/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Específicos (Segurança do Trabalho): NR 33 — Espaços confinados.

Aulas do Gran (assistir em 1.25x; total 1h39 de vídeo):
- Tópico 10 · Aula 2 — NR 33 — Espaços confinados II (31 min)
- Tópico 10 · Aula 3 — NR 33 — Espaços confinados III (33 min)
- Tópico 10 · Aula 4 — NR 33 — Espaços confinados IV (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Específicos (Segurança do Trabalho)', 'Teoria', NULL, '2026-12-03 14:00:00',
        119, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-120
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SEEC-120] Qui 03/12 — Bateria de questões — Direito Constitucional + Específicos (2h)', '📅 Qui 03/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Direito Constitucional e 20 de Específicos (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-03 19:00:00',
        120, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-121
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-121] Sex 04/12 — Português — Gramática: T1 Aulas 66–70 · Particularidades Léxicas', '📅 Sex 04/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h59 de vídeo):
- Tópico 1 · Aula 66 — Particularidades Léxicas (51 min)
- Tópico 1 · Aula 67 — Processo de Formação de Palavras (27 min)
- Tópico 1 · Aula 68 — Processo de Formação de Palavras - Exercícios (49 min)
- Tópico 1 · Aula 69 — Estudo do Verbo (26 min)
- Tópico 1 · Aula 70 — Estudo do Verbo II (26 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', NULL, '2026-12-04 08:00:00',
        121, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-122
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-122] Sex 04/12 — Direito Administrativo: T8 Aulas 4–5 + T9 Aulas 1–2 · Controle da Administração Pública IV', '📅 Sex 04/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Controle, Improbidade.

Aulas do Gran (assistir em 1.25x; total 2h13 de vídeo):
- Tópico 8 · Aula 4 — Controle da Administração Pública IV (33 min)
- Tópico 8 · Aula 5 — Controle da Administração - Resumo (34 min)
- Tópico 9 · Aula 1 — Improbidade Administrativa I (32 min)
- Tópico 9 · Aula 2 — Improbidade Administrativa II (34 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-12-04 14:00:00',
        122, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-123
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-123] Sex 04/12 — Bateria de questões — Português + Direito Administrativo (2h)', '📅 Sex 04/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Direito Administrativo (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-04 19:00:00',
        123, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-124
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-124] Sáb 05/12 — Informática: T5 Aulas 1–5 · Segurança - Princípios Básicos', '📅 Sáb 05/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: Segurança e backup.

Aulas do Gran (assistir em 1.25x; total 2h50 de vídeo):
- Tópico 5 · Aula 1 — Segurança - Princípios Básicos (38 min)
- Tópico 5 · Aula 2 — Segurança - Princípios Básicos II (28 min)
- Tópico 5 · Aula 3 — Segurança - Ameaças, Ataques, Pragas Virtuais (27 min)
- Tópico 5 · Aula 4 — Segurança - Ameaças, Ataques, Pragas Virtuais II (35 min)
- Tópico 5 · Aula 5 — Segurança - Ameaças, Ataques, Pragas Virtuais III (42 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-12-05 08:00:00',
        124, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-125
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-125] Sáb 05/12 — Raciocínio Lógico: T4 Aulas 8–10 · Problemas Aritméticos, Geométricos e Matriciais', '📅 Sáb 05/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Problemas lógicos.

Aulas do Gran (assistir em 1.25x; total 1h39 de vídeo):
- Tópico 4 · Aula 8 — Problemas Aritméticos, Geométricos e Matriciais (35 min)
- Tópico 4 · Aula 9 — Problemas Aritméticos, Geométricos e Matriciais II (33 min)
- Tópico 4 · Aula 10 — Problemas Aritméticos, Geométricos e Matriciais III (31 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-12-05 14:00:00',
        125, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-126
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-126] Sáb 05/12 — Bateria de questões — Informática + Raciocínio Lógico (2h)', '📅 Sáb 05/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Informática e 20 de Raciocínio Lógico (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-05 19:00:00',
        126, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-127
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-127] Dom 06/12 — 🎯 Simulado da semana — 60 questões (4h)', '📅 Dom 06/12 · ⏰ 08:00

Como candidato(a), quero medir o que ficou da semana em condição de prova.

O que fazer:
- 60 questões das matérias vistas na semana (Caderno de questões do Gran; filtro da banca Consulpam se existir)
- Cronometrar, sem consultar

Critérios de aceite:
- Nota anotada por matéria',
        'Urgente', 'Simulado', 'Simulado', NULL, '2026-12-06 08:00:00',
        127, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-128
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-128] Dom 06/12 — Correção do simulado + revisão da semana (2h)', '📅 Dom 06/12 · ⏰ 14:00

Como candidato(a), quero transformar cada erro em aprendizado.

O que fazer:
- Corrigir questão por questão
- Reler os resumos da semana
- Olhar as cards da próxima semana

Critérios de aceite:
- Caderno de erros atualizado · resto do domingo livre',
        'Alta', 'Simulado', 'Revisão', NULL, '2026-12-06 14:00:00',
        128, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-129
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-129] Seg 07/12 — Específicos (Segurança do Trabalho): T10 Aula 5 + T11 Aulas 1–3 · NR 33 — Espaços confinados V', '📅 Seg 07/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Específicos (Segurança do Trabalho): NR 33 — Espaços confinados, NR 35 — Trabalho em altura.

Aulas do Gran (assistir em 1.25x; total 2h33 de vídeo):
- Tópico 10 · Aula 5 — NR 33 — Espaços confinados V (39 min)
- Tópico 11 · Aula 1 — NR 35 - Trabalho em Altura (39 min)
- Tópico 11 · Aula 2 — NR 35 - Trabalho em Altura (parte 2) (46 min)
- Tópico 11 · Aula 3 — NR 35 - Trabalho em Altura (parte 3) (29 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Específicos (Segurança do Trabalho)', 'Teoria', NULL, '2026-12-07 08:00:00',
        129, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-130
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-130] Seg 07/12 — Português — Interpretação: T2 Aulas 19–20 · Figuras de Linguagem V', '📅 Seg 07/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Interpretação: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 0h57 de vídeo):
- Tópico 2 · Aula 19 — Figuras de Linguagem V (29 min)
- Tópico 2 · Aula 20 — Domínios Discursivos (28 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Interpretação', 'Teoria', NULL, '2026-12-07 14:00:00',
        130, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-131
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-131] Seg 07/12 — Bateria de questões — Específicos + Português (2h)', '📅 Seg 07/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Específicos e 20 de Português (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-07 19:00:00',
        131, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-132
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-132] Ter 08/12 — Português — Gramática: T1 Aulas 71–74 · Estudo do Verbo III', '📅 Ter 08/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 2h48 de vídeo):
- Tópico 1 · Aula 71 — Estudo do Verbo III (62 min)
- Tópico 1 · Aula 72 — Estudo do Verbo IV (29 min)
- Tópico 1 · Aula 73 — Estudo do Verbo V (28 min)
- Tópico 1 · Aula 74 — Estudo do Verbo VI (49 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', NULL, '2026-12-08 08:00:00',
        132, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-133
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-133] Ter 08/12 — Direito Constitucional: T6 Aulas 2–5 · Ingresso e Promoção na Carreira', '📅 Ter 08/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Constitucional: Poder Judiciário.

Aulas do Gran (assistir em 1.25x; total 1h58 de vídeo):
- Tópico 6 · Aula 2 — Ingresso e Promoção na Carreira (44 min)
- Tópico 6 · Aula 3 — Artigo 93 (26 min)
- Tópico 6 · Aula 4 — Quinto Constitucional, Garantias e Proibições (25 min)
- Tópico 6 · Aula 5 — Autonomia dos Tribunais (23 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Constitucional', 'Teoria', NULL, '2026-12-08 14:00:00',
        133, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-134
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-134] Ter 08/12 — Bateria de questões — Português + Direito Constitucional (2h)', '📅 Ter 08/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Direito Constitucional (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-08 19:00:00',
        134, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-135
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-135] Qua 09/12 — Direito Administrativo: T9 Aulas 3–7 · Improbidade Administrativa III', '📅 Qua 09/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Improbidade.

Aulas do Gran (assistir em 1.25x; total 2h56 de vídeo):
- Tópico 9 · Aula 3 — Improbidade Administrativa III (32 min)
- Tópico 9 · Aula 4 — Improbidade Administrativa IV (36 min)
- Tópico 9 · Aula 5 — Improbidade Administrativa V (35 min)
- Tópico 9 · Aula 6 — Improbidade Administrativa VI (37 min)
- Tópico 9 · Aula 7 — Improbidade Administrativa (fechamento) (36 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-12-09 08:00:00',
        135, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-136
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-136] Qua 09/12 — Raciocínio Lógico: T5 Aulas 1–4 · Conjuntos Numéricos - Teoria', '📅 Qua 09/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Conjuntos numéricos e operações.

Aulas do Gran (assistir em 1.25x; total 2h10 de vídeo):
- Tópico 5 · Aula 1 — Conjuntos Numéricos - Teoria (42 min)
- Tópico 5 · Aula 2 — Conjuntos Numéricos - Questões (27 min)
- Tópico 5 · Aula 3 — Conjuntos Numéricos - Questões II (32 min)
- Tópico 5 · Aula 4 — Potenciação - Teoria (29 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-12-09 14:00:00',
        136, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-137
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-137] Qua 09/12 — Bateria de questões — Direito Administrativo + Raciocínio Lógico (2h)', '📅 Qua 09/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Direito Administrativo e 20 de Raciocínio Lógico (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-09 19:00:00',
        137, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-138
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-138] Qui 10/12 — Português — Gramática: T1 Aulas 75–76 · Estudo do Verbo VII', '📅 Qui 10/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Português — Gramática: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 0h53 de vídeo):
- Tópico 1 · Aula 75 — Estudo do Verbo VII (32 min)
- Tópico 1 · Aula 76 — Estudo do Verbo - Exercícios (21 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Urgente', 'Português — Gramática', 'Teoria', NULL, '2026-12-10 08:00:00',
        138, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-139
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-139] Qui 10/12 — Informática: T5 Aulas 6–8 · Segurança - Ferramentas de Proteção', '📅 Qui 10/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: Segurança e backup.

Aulas do Gran (assistir em 1.25x; total 1h36 de vídeo):
- Tópico 5 · Aula 6 — Segurança - Ferramentas de Proteção (36 min)
- Tópico 5 · Aula 7 — Segurança - Ferramentas de Proteção II (32 min)
- Tópico 5 · Aula 8 — Segurança - Ferramentas de Proteção III (28 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-12-10 14:00:00',
        139, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-140
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SEEC-140] Qui 10/12 — Bateria de questões — Português + Informática (2h)', '📅 Qui 10/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Português e 20 de Informática (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-10 19:00:00',
        140, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-141
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-141] Sex 11/12 — Direito Constitucional: T6 Aulas 6–11 · Cláusula de Reserva de Plenário', '📅 Sex 11/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Constitucional: Poder Judiciário.

Aulas do Gran (assistir em 1.25x; total 3h09 de vídeo):
- Tópico 6 · Aula 6 — Cláusula de Reserva de Plenário (28 min)
- Tópico 6 · Aula 7 — Precatórios (34 min)
- Tópico 6 · Aula 8 — Precatórios II (31 min)
- Tópico 6 · Aula 9 — Foro Especial para Julgamento de Autoridades (33 min)
- Tópico 6 · Aula 10 — STF (34 min)
- Tópico 6 · Aula 11 — STF II (29 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Constitucional', 'Teoria', NULL, '2026-12-11 08:00:00',
        141, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-142
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-142] Sex 11/12 — Direito Administrativo: T10 Aulas 1–4 · Responsabilidade Civil do Estado', '📅 Sex 11/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Responsabilidade civil.

Aulas do Gran (assistir em 1.25x; total 2h13 de vídeo):
- Tópico 10 · Aula 1 — Responsabilidade Civil do Estado (33 min)
- Tópico 10 · Aula 2 — Responsabilidade Civil do Estado II (37 min)
- Tópico 10 · Aula 3 — Responsabilidade Civil do Estado III (32 min)
- Tópico 10 · Aula 4 — Responsabilidade Civil do Estado - Resumo (31 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-12-11 14:00:00',
        142, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-143
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-143] Sex 11/12 — Bateria de questões — Direito Constitucional + Direito Administrativo (2h)', '📅 Sex 11/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Direito Constitucional e 20 de Direito Administrativo (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-11 19:00:00',
        143, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-144
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-144] Sáb 12/12 — Raciocínio Lógico: T5 Aulas 5–7 + T6 Aulas 1–3 · Potenciação - Questões', '📅 Sáb 12/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Conjuntos numéricos e operações, Equações e inequações.

Aulas do Gran (assistir em 1.25x; total 3h01 de vídeo):
- Tópico 5 · Aula 5 — Potenciação - Questões (29 min)
- Tópico 5 · Aula 6 — Radiciação - Teoria (30 min)
- Tópico 5 · Aula 7 — Radiciação - Questões (29 min)
- Tópico 6 · Aula 1 — Equação do 1º Grau - Teoria (32 min)
- Tópico 6 · Aula 2 — Equação do 1º Grau - Questões (28 min)
- Tópico 6 · Aula 3 — Equação do 1º Grau - Questões II (33 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-12-12 08:00:00',
        144, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-145
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-145] Sáb 12/12 — Informática: T5 Aulas 9–10 + T6 Aulas 1–2 · Segurança - Procedimentos de Backups', '📅 Sáb 12/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: Segurança e backup, LGPD.

Aulas do Gran (assistir em 1.25x; total 2h14 de vídeo):
- Tópico 5 · Aula 9 — Segurança - Procedimentos de Backups (41 min)
- Tópico 5 · Aula 10 — Segurança - Procedimentos de Backups II (37 min)
- Tópico 6 · Aula 1 — LGPD (Lei 13.709/2018) (30 min)
- Tópico 6 · Aula 2 — LGPD (Lei 13.709/2018) II (26 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-12-12 14:00:00',
        145, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-146
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-146] Sáb 12/12 — Bateria de questões — Raciocínio Lógico + Informática (2h)', '📅 Sáb 12/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Raciocínio Lógico e 20 de Informática (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-12 19:00:00',
        146, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-147
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-147] Dom 13/12 — 🎯 Simulado da semana — 60 questões (4h)', '📅 Dom 13/12 · ⏰ 08:00

Como candidato(a), quero medir o que ficou da semana em condição de prova.

O que fazer:
- 60 questões das matérias vistas na semana (Caderno de questões do Gran; filtro da banca Consulpam se existir)
- Cronometrar, sem consultar

Critérios de aceite:
- Nota anotada por matéria',
        'Urgente', 'Simulado', 'Simulado', NULL, '2026-12-13 08:00:00',
        147, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-148
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-148] Dom 13/12 — Correção do simulado + revisão da semana (2h)', '📅 Dom 13/12 · ⏰ 14:00

Como candidato(a), quero transformar cada erro em aprendizado.

O que fazer:
- Corrigir questão por questão
- Reler os resumos da semana
- Olhar as cards da próxima semana

Critérios de aceite:
- Caderno de erros atualizado · resto do domingo livre',
        'Alta', 'Simulado', 'Revisão', NULL, '2026-12-13 14:00:00',
        148, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-149
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-149] Seg 14/12 — Direito Administrativo: T11 Aulas 1–5 · Lei 14.133/2021 - Licitações', '📅 Seg 14/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Licitações (Lei 14.133/21).

Aulas do Gran (assistir em 1.25x; total 3h04 de vídeo):
- Tópico 11 · Aula 1 — Lei 14.133/2021 - Licitações (28 min)
- Tópico 11 · Aula 2 — Lei 14.133/2021 - Licitações II (46 min)
- Tópico 11 · Aula 3 — Lei 14.133/2021 - Licitações III (33 min)
- Tópico 11 · Aula 4 — Lei 14.133/2021 - Licitações IV (32 min)
- Tópico 11 · Aula 5 — Lei 14.133/2021 - Licitações V (45 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-12-14 08:00:00',
        149, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-150
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-150] Seg 14/12 — DF e RIDE: T1 Aulas 11–12 · Geografia IV', '📅 Seg 14/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar DF e RIDE: aulas do dia.

Aulas do Gran (assistir em 1.25x; total 0h55 de vídeo):
- Tópico 1 · Aula 11 — Geografia IV (24 min)
- Tópico 1 · Aula 12 — Sociedade (31 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'DF e RIDE', 'Teoria', NULL, '2026-12-14 14:00:00',
        150, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag7);
-- SEEC-151
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-151] Seg 14/12 — Bateria de questões — Direito Administrativo + DF e RIDE (2h)', '📅 Seg 14/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Direito Administrativo e 20 de DF e RIDE (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-14 19:00:00',
        151, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag7);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-152
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-152] Ter 15/12 — Inteligência Emocional: T1 Aula 6 · Aprendendo a Dizer Não', '📅 Ter 15/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Inteligência Emocional: Inteligência emocional.

Aulas do Gran (assistir em 1.25x; total 0h21 de vídeo):
- Tópico 1 · Aula 6 — Aprendendo a Dizer Não (21 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Inteligência Emocional', 'Teoria', NULL, '2026-12-15 08:00:00',
        152, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag9);
-- SEEC-153
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-153] Ter 15/12 — Direito Constitucional: T6 Aula 12 + T7 Aulas 1–3 · STJ', '📅 Ter 15/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Constitucional: Poder Judiciário, Funções essenciais à Justiça.

Aulas do Gran (assistir em 1.25x; total 1h54 de vídeo):
- Tópico 6 · Aula 12 — STJ (22 min)
- Tópico 7 · Aula 1 — Ministério Público (23 min)
- Tópico 7 · Aula 2 — Ministério Público II (34 min)
- Tópico 7 · Aula 3 — Ministério Público III (35 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Constitucional', 'Teoria', NULL, '2026-12-15 14:00:00',
        153, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-154
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-154] Ter 15/12 — Bateria de questões — Inteligência Emocional + Direito Constitucional (2h)', '📅 Ter 15/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Inteligência Emocional e 20 de Direito Constitucional (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-15 19:00:00',
        154, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag9);
-- SEEC-155
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-155] Qua 16/12 — Informática: T6 Aulas 3–9 · LGPD (Lei 13.709/2018) III', '📅 Qua 16/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: LGPD.

Aulas do Gran (assistir em 1.25x; total 2h55 de vídeo):
- Tópico 6 · Aula 3 — LGPD (Lei 13.709/2018) III (28 min)
- Tópico 6 · Aula 4 — LGPD (Lei 13.709/2018) IV (29 min)
- Tópico 6 · Aula 5 — LGPD (Lei 13.709/2018) V (24 min)
- Tópico 6 · Aula 6 — LGPD (Lei 13.709/2018) VI (27 min)
- Tópico 6 · Aula 7 — LGPD (Lei 13.709/2018) VII (20 min)
- Tópico 6 · Aula 8 — LGPD (Lei 13.709/2018) VIII (27 min)
- Tópico 6 · Aula 9 — LGPD (Lei 13.709/2018) IX (20 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-12-16 08:00:00',
        155, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-156
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-156] Qua 16/12 — Raciocínio Lógico: T6 Aulas 4–7 · Sistema de Equações do 1º Grau', '📅 Qua 16/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Equações e inequações.

Aulas do Gran (assistir em 1.25x; total 2h00 de vídeo):
- Tópico 6 · Aula 4 — Sistema de Equações do 1º Grau (29 min)
- Tópico 6 · Aula 5 — Sistema de Equações do 1º Grau II (34 min)
- Tópico 6 · Aula 6 — Inequação do 1º Grau (28 min)
- Tópico 6 · Aula 7 — Equação do 2º Grau (29 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-12-16 14:00:00',
        156, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-157
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-157] Qua 16/12 — Bateria de questões — Informática + Raciocínio Lógico (2h)', '📅 Qua 16/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Informática e 20 de Raciocínio Lógico (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-16 19:00:00',
        157, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-158
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-158] Qui 17/12 — Direito Administrativo: T11 Aulas 6–10 · Lei 14.133/2021 - Licitações VI', '📅 Qui 17/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Licitações (Lei 14.133/21).

Aulas do Gran (assistir em 1.25x; total 2h53 de vídeo):
- Tópico 11 · Aula 6 — Lei 14.133/2021 - Licitações VI (33 min)
- Tópico 11 · Aula 7 — Lei 14.133/2021 - Licitações VII (34 min)
- Tópico 11 · Aula 8 — Lei 14.133/2021 - Licitações VIII (36 min)
- Tópico 11 · Aula 9 — Lei 14.133/2021 - Licitações IX (36 min)
- Tópico 11 · Aula 10 — Lei 14.133/2021 - Licitações X (34 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-12-17 08:00:00',
        158, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-159
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-159] Qui 17/12 — Direito Constitucional: T7 Aulas 4–6 · Advocacia Pública', '📅 Qui 17/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Constitucional: Funções essenciais à Justiça.

Aulas do Gran (assistir em 1.25x; total 1h40 de vídeo):
- Tópico 7 · Aula 4 — Advocacia Pública (43 min)
- Tópico 7 · Aula 5 — Advocacia (19 min)
- Tópico 7 · Aula 6 — Defensoria Pública (38 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Constitucional', 'Teoria', NULL, '2026-12-17 14:00:00',
        159, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-160
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SEEC-160] Qui 17/12 — Bateria de questões — Direito Administrativo + Direito Constitucional (2h)', '📅 Qui 17/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Direito Administrativo e 20 de Direito Constitucional (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-17 19:00:00',
        160, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-161
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-161] Sex 18/12 — Raciocínio Lógico: T6 Aulas 8–9 · Inequação do 2º Grau', '📅 Sex 18/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Raciocínio Lógico: Equações e inequações.

Aulas do Gran (assistir em 1.25x; total 0h59 de vídeo):
- Tópico 6 · Aula 8 — Inequação do 2º Grau (30 min)
- Tópico 6 · Aula 9 — Equação do 2º Grau II (29 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Raciocínio Lógico', 'Teoria', NULL, '2026-12-18 08:00:00',
        161, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-162
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-162] Sex 18/12 — Direito Administrativo: T11 Aulas 11–12 · Lei 14.133/2021 - Licitações XI', '📅 Sex 18/12 · ⏰ 14:00 às 17:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Direito Administrativo: Licitações (Lei 14.133/21).

Aulas do Gran (assistir em 1.25x; total 1h12 de vídeo):
- Tópico 11 · Aula 11 — Lei 14.133/2021 - Licitações XI (36 min)
- Tópico 11 · Aula 12 — Lei 14.133/2021 - Licitações XII (36 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Direito Administrativo', 'Teoria', NULL, '2026-12-18 14:00:00',
        162, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-163
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-163] Sex 18/12 — Bateria de questões — Raciocínio Lógico + Direito Administrativo (2h)', '📅 Sex 18/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Raciocínio Lógico e 20 de Direito Administrativo (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-18 19:00:00',
        163, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-164
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-164] Sáb 19/12 — Informática: T6 Aula 10 · LGPD (Lei 13.709/2018) X', '📅 Sáb 19/12 · ⏰ 08:00 às 12:00

Como candidato(a) a Técnico de Planejamento Urbano e Infraestrutura, quero dominar Informática: LGPD.

Aulas do Gran (assistir em 1.25x; total 0h29 de vídeo):
- Tópico 6 · Aula 10 — LGPD (Lei 13.709/2018) X (29 min)

Depois das aulas:
- Ler o PDF das mesmas aulas marcando o que ''cai muito''
- Resumo de 1 página (ou mapa mental)
- 20 questões no ''Caderno de questões'' do Gran sobre essas aulas
- Errou? Anotar a regra no caderno de erros

Critérios de aceite:
- Todas as aulas acima marcadas como concluídas no Gran
- Resumo feito e 20 questões resolvidas',
        'Alta', 'Informática', 'Teoria', NULL, '2026-12-19 08:00:00',
        164, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-165
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-165] Sáb 19/12 — Bateria de questões — Informática + Informática (2h)', '📅 Sáb 19/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero fixar a matéria do dia resolvendo questões.

O que fazer:
- 20 questões de Informática e 20 de Informática (das aulas de hoje)
- 10 min revendo os resumos de ontem

Critérios de aceite:
- 40 questões feitas e taxa de acerto anotada',
        'Alta', 'Questões', 'Questões', NULL, '2026-12-19 19:00:00',
        165, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-166
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-166] Dom 20/12 — 🎯 Simulado completo final — 60 questões (4h)', '📅 Dom 20/12 · ⏰ 08:00

Como candidato(a), quero fechar o ciclo com um simulado completo.

O que fazer:
- 60 questões, cronometrado
- À tarde, correção

Critérios de aceite:
- Nota por matéria anotada · plano da 2ª volta definido',
        'Urgente', 'Simulado', 'Simulado', NULL, '2026-12-20 08:00:00',
        166, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-167
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-167] Seg 21/12 — Revisão final — Português + 40 questões', '📅 Seg 21/12 · ⏰ 08:00 às 12:00

Como candidato(a), quero consolidar Português depois de ver todas as aulas.

O que fazer:
- Reler os resumos e o caderno de erros de Português
- 40 questões misturando todos os tópicos

Critérios de aceite:
- Acerto acima de 70% (se não, voltar nas aulas do tópico mais fraco)',
        'Urgente', 'Português', 'Revisão', NULL, '2026-12-21 08:00:00',
        167, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-168
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-168] Seg 21/12 — Revisão final — Específicos + 40 questões', '📅 Seg 21/12 · ⏰ 14:00 às 17:00

Como candidato(a), quero consolidar Específicos depois de ver todas as aulas.

O que fazer:
- Reler os resumos e o caderno de erros de Específicos
- 40 questões misturando todos os tópicos

Critérios de aceite:
- Acerto acima de 70% (se não, voltar nas aulas do tópico mais fraco)',
        'Urgente', 'Específicos', 'Revisão', NULL, '2026-12-21 14:00:00',
        168, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-169
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-169] Seg 21/12 — Mini-simulado misto — 30 questões', '📅 Seg 21/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero treinar a troca de matéria como na prova.

O que fazer:
- 30 questões de todas as matérias, cronometrado

Critérios de aceite:
- Nota anotada',
        'Alta', 'Simulado', 'Simulado', NULL, '2026-12-21 19:00:00',
        169, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-170
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-170] Ter 22/12 — Revisão final — Direito Administrativo + 40 questões', '📅 Ter 22/12 · ⏰ 08:00 às 12:00

Como candidato(a), quero consolidar Direito Administrativo depois de ver todas as aulas.

O que fazer:
- Reler os resumos e o caderno de erros de Direito Administrativo
- 40 questões misturando todos os tópicos

Critérios de aceite:
- Acerto acima de 70% (se não, voltar nas aulas do tópico mais fraco)',
        'Urgente', 'Direito Administrativo', 'Revisão', NULL, '2026-12-22 08:00:00',
        170, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-171
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-171] Ter 22/12 — Revisão final — Direito Constitucional + 40 questões', '📅 Ter 22/12 · ⏰ 14:00 às 17:00

Como candidato(a), quero consolidar Direito Constitucional depois de ver todas as aulas.

O que fazer:
- Reler os resumos e o caderno de erros de Direito Constitucional
- 40 questões misturando todos os tópicos

Critérios de aceite:
- Acerto acima de 70% (se não, voltar nas aulas do tópico mais fraco)',
        'Urgente', 'Direito Constitucional', 'Revisão', NULL, '2026-12-22 14:00:00',
        171, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- SEEC-172
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-172] Ter 22/12 — Mini-simulado misto — 30 questões', '📅 Ter 22/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero treinar a troca de matéria como na prova.

O que fazer:
- 30 questões de todas as matérias, cronometrado

Critérios de aceite:
- Nota anotada',
        'Alta', 'Simulado', 'Simulado', NULL, '2026-12-22 19:00:00',
        172, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-173
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-173] Qua 23/12 — Revisão final — Raciocínio Lógico + 40 questões', '📅 Qua 23/12 · ⏰ 08:00 às 12:00

Como candidato(a), quero consolidar Raciocínio Lógico depois de ver todas as aulas.

O que fazer:
- Reler os resumos e o caderno de erros de Raciocínio Lógico
- 40 questões misturando todos os tópicos

Critérios de aceite:
- Acerto acima de 70% (se não, voltar nas aulas do tópico mais fraco)',
        'Urgente', 'Raciocínio Lógico', 'Revisão', NULL, '2026-12-23 08:00:00',
        173, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-174
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-174] Qua 23/12 — Revisão final — Informática + 40 questões', '📅 Qua 23/12 · ⏰ 14:00 às 17:00

Como candidato(a), quero consolidar Informática depois de ver todas as aulas.

O que fazer:
- Reler os resumos e o caderno de erros de Informática
- 40 questões misturando todos os tópicos

Critérios de aceite:
- Acerto acima de 70% (se não, voltar nas aulas do tópico mais fraco)',
        'Urgente', 'Informática', 'Revisão', NULL, '2026-12-23 14:00:00',
        174, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- SEEC-175
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-175] Qua 23/12 — Mini-simulado misto — 30 questões', '📅 Qua 23/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero treinar a troca de matéria como na prova.

O que fazer:
- 30 questões de todas as matérias, cronometrado

Critérios de aceite:
- Nota anotada',
        'Alta', 'Simulado', 'Simulado', NULL, '2026-12-23 19:00:00',
        175, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-176
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-176] Qui 24/12 — Revisão final — Português + 40 questões', '📅 Qui 24/12 · ⏰ 08:00 às 12:00

Como candidato(a), quero consolidar Português depois de ver todas as aulas.

O que fazer:
- Reler os resumos e o caderno de erros de Português
- 40 questões misturando todos os tópicos

Critérios de aceite:
- Acerto acima de 70% (se não, voltar nas aulas do tópico mais fraco)',
        'Urgente', 'Português', 'Revisão', NULL, '2026-12-24 08:00:00',
        176, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SEEC-177
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-177] Qui 24/12 — Revisão final — Específicos + 40 questões', '📅 Qui 24/12 · ⏰ 14:00 às 17:00

Como candidato(a), quero consolidar Específicos depois de ver todas as aulas.

O que fazer:
- Reler os resumos e o caderno de erros de Específicos
- 40 questões misturando todos os tópicos

Critérios de aceite:
- Acerto acima de 70% (se não, voltar nas aulas do tópico mais fraco)',
        'Urgente', 'Específicos', 'Revisão', NULL, '2026-12-24 14:00:00',
        177, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SEEC-178
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SEEC-178] Qui 24/12 — Mini-simulado misto — 30 questões', '📅 Qui 24/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero treinar a troca de matéria como na prova.

O que fazer:
- 30 questões de todas as matérias, cronometrado

Critérios de aceite:
- Nota anotada',
        'Alta', 'Simulado', 'Simulado', NULL, '2026-12-24 19:00:00',
        178, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-179
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint10, @fila, '[SEEC-179] Sex 25/12 — Revisão final — DF e RIDE + 40 questões', '📅 Sex 25/12 · ⏰ 08:00 às 12:00

Como candidato(a), quero consolidar DF e RIDE depois de ver todas as aulas.

O que fazer:
- Reler os resumos e o caderno de erros de DF e RIDE
- 40 questões misturando todos os tópicos

Critérios de aceite:
- Acerto acima de 70% (se não, voltar nas aulas do tópico mais fraco)',
        'Urgente', 'DF e RIDE', 'Revisão', NULL, '2026-12-25 08:00:00',
        179, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag7);
-- SEEC-180
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint10, @fila, '[SEEC-180] Sex 25/12 — Revisão final — Política para Mulheres + 40 questões', '📅 Sex 25/12 · ⏰ 14:00 às 17:00

Como candidato(a), quero consolidar Política para Mulheres depois de ver todas as aulas.

O que fazer:
- Reler os resumos e o caderno de erros de Política para Mulheres
- 40 questões misturando todos os tópicos

Critérios de aceite:
- Acerto acima de 70% (se não, voltar nas aulas do tópico mais fraco)',
        'Urgente', 'Política para Mulheres', 'Revisão', NULL, '2026-12-25 14:00:00',
        180, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag8);
-- SEEC-181
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint10, @fila, '[SEEC-181] Sex 25/12 — Mini-simulado misto — 30 questões', '📅 Sex 25/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero treinar a troca de matéria como na prova.

O que fazer:
- 30 questões de todas as matérias, cronometrado

Critérios de aceite:
- Nota anotada',
        'Alta', 'Simulado', 'Simulado', NULL, '2026-12-25 19:00:00',
        181, NOW(), NOW());
SET @t := LAST_INSERT_ID();
-- SEEC-182
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint10, @fila, '[SEEC-182] Sáb 26/12 — Revisão final — Direito Administrativo + 40 questões', '📅 Sáb 26/12 · ⏰ 08:00 às 12:00

Como candidato(a), quero consolidar Direito Administrativo depois de ver todas as aulas.

O que fazer:
- Reler os resumos e o caderno de erros de Direito Administrativo
- 40 questões misturando todos os tópicos

Critérios de aceite:
- Acerto acima de 70% (se não, voltar nas aulas do tópico mais fraco)',
        'Urgente', 'Direito Administrativo', 'Revisão', NULL, '2026-12-26 08:00:00',
        182, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- SEEC-183
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint10, @fila, '[SEEC-183] Sáb 26/12 — Revisão final — Raciocínio Lógico + 40 questões', '📅 Sáb 26/12 · ⏰ 14:00 às 17:00

Como candidato(a), quero consolidar Raciocínio Lógico depois de ver todas as aulas.

O que fazer:
- Reler os resumos e o caderno de erros de Raciocínio Lógico
- 40 questões misturando todos os tópicos

Critérios de aceite:
- Acerto acima de 70% (se não, voltar nas aulas do tópico mais fraco)',
        'Urgente', 'Raciocínio Lógico', 'Revisão', NULL, '2026-12-26 14:00:00',
        183, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- SEEC-184
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint10, @fila, '[SEEC-184] Sáb 26/12 — Mini-simulado misto — 30 questões', '📅 Sáb 26/12 · ⏰ 19:00 às 21:00

Como candidato(a), quero treinar a troca de matéria como na prova.

O que fazer:
- 30 questões de todas as matérias, cronometrado

Critérios de aceite:
- Nota anotada',
        'Alta', 'Simulado', 'Simulado', NULL, '2026-12-26 19:00:00',
        184, NOW(), NOW());
SET @t := LAST_INSERT_ID();

COMMIT;
SELECT @board AS board_criado;
