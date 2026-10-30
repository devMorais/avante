-- ============================================================
-- Estudo CIS-DF + CAD - board + sprints + cards
-- Gerado por estudo-cad-cisdf-gerar-sql.py a partir de
-- estudo-cad-cisdf-tasks.json. NAO edite este arquivo na mao.
-- ATENCAO: nao e idempotente. Rodar duas vezes duplica as linhas.
-- ============================================================
SET NAMES utf8mb4;
START TRANSACTION;

INSERT INTO boards (name, created_at, updated_at)
VALUES ('Estudo CIS-DF + CAD — Dezembro 2026', NOW(), NOW());
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
VALUES (@board, 'programming', 'Estudo', '#0284C7', 0, NOW(), NOW());
INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Prática', '#059669', 1, NOW(), NOW());
INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Simulado', '#DC2626', 2, NOW(), NOW());
INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Revisão', '#D97706', 3, NOW(), NOW());
INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Prova', '#7C3AED', 4, NOW(), NOW());
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'CIS-DF', '#7C3AED', NOW(), NOW());
SET @tag1 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'CAD', '#0891B2', NOW(), NOW());
SET @tag2 := LAST_INSERT_ID();
SET @fila := (SELECT id FROM statuses WHERE board_id = @board AND name = 'Em Fila' LIMIT 1);

INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 0 — Arranque', '2026-10-23', '2026-10-25', 1, NOW(), NOW());
SET @sprint1 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 1 — Ingest × Criar app', '2026-10-26', '2026-11-01', 2, NOW(), NOW());
SET @sprint2 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 2 — CSDM/Govern × Criar app/Interface', '2026-11-02', '2026-11-08', 3, NOW(), NOW());
SET @sprint3 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 3 — Govern × Interface', '2026-11-09', '2026-11-15', 4, NOW(), NOW());
SET @sprint4 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 4 — Configuration × Segurança', '2026-11-16', '2026-11-22', 5, NOW(), NOW());
SET @sprint5 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 5 — Insight × Automação', '2026-11-23', '2026-11-29', 6, NOW(), NOW());
SET @sprint6 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 6 — Reta final CIS-DF (1)', '2026-11-30', '2026-12-06', 7, NOW(), NOW());
SET @sprint7 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 7 — PROVA CIS-DF 10/12', '2026-12-07', '2026-12-10', 8, NOW(), NOW());
SET @sprint8 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Semana 8 — Reta final + PROVA CAD', '2026-12-11', '2026-12-15', 9, NOW(), NOW());
SET @sprint9 := LAST_INSERT_ID();

-- CIS-01
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[CIS-01] Sex 23/10 — Objetivo 7 — como Asset e CI se alinham', '📅 Sex 23/10 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Objetivo 7 — como Asset e CI se alinham", para acertar as questões de Ingest (20,7% da prova).

O que fazer:
- Ler a doc de sincronização Asset × CI (Model category é o elo)
- Escrever o ANCHOR do objetivo 7 no CIS-DF-INGEST.md
- Explicar em voz alta, em PT e em EN, sem olhar

Critérios de aceite:
- Objetivo 7 marcado ✅ no CIS-DF-INGEST.md
- Você sabe dizer qual campo liga asset e CI

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Ingest', 'Estudo', 'Doc: Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\servicenow-platform\\configuration-management-database-cmdb\\ (buscar ''model category'', ''asset CI''). Na aula 2 do Arno o instrutor errou este ponto.', '2026-10-23 07:00:00',
        1, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-01
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[CAD-01] Sex 23/10 — Arranque do CAD — PDI, cursos oficiais e simulado', '📅 Sex 23/10 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Arranque do CAD — PDI, cursos oficiais e simulado", para acertar as questões de Preparação (— da prova).

O que fazer:
- Conferir a PDI de desenvolvimento ativa
- Inscrever-se nos 3 cursos oficiais: Welcome to ServiceNow · Scripting in ServiceNow Fundamentals · Application Development Fundamentals
- Comprar o simulado de CAD (Lucky X na Udemy)
- Ler o 07-CAD\\CAD-BLUEPRINT.md inteiro

Critérios de aceite:
- Cursos na sua lista da ServiceNow University e simulado comprado

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · Preparação', 'Estudo', 'Blueprint: Desktop\\Contexto-IA\\07-CAD\\CAD-BLUEPRINT.md', '2026-10-23 09:00:00',
        2, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-01
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[PRA-01] Sex 23/10 — Prática do dia — CIS-DF (Ingest) + CAD (Preparação)', '📅 Sex 23/10 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Ingest), 1min30 cada
- 15 questões de CAD (Preparação)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-10-23 11:00:00',
        3, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SIM-01
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[SIM-01] Sáb 24/10 — 🎯 Simulado CIS-DF completo e cronometrado', '📅 Sáb 24/10 · ⏰ 07:00

Como candidato ao CIS-DF, quero medir onde estou em condição de prova, para saber onde atacar na semana.

O que fazer:
- Simulado completo, 90 min, sem consultar, celular longe
- Registrar a nota por domínio

Critérios de aceite:
- Nota anotada e comparada com a anterior',
        'Urgente', 'CIS-DF · Simulado', 'Simulado', 'CIS-DF: Lucky X / curso oficial (não o banco de 178).', '2026-10-24 07:00:00',
        4, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- REV-01
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[REV-01] Sáb 24/10 — Revisão do simulado CIS-DF — cada erro vira card', '📅 Sáb 24/10 · ⏰ 09:00

Como candidato ao CIS-DF, quero entender cada erro, para não repetir na prova.

O que fazer:
- Cada erro: traduzir o enunciado → por que errei (inglês? objeto? conceito?) → doc → card/anotação
- Se o gabarito estiver errado, anotar (terceiros já erraram 7 vezes)

Critérios de aceite:
- Nenhum erro sem card',
        'Alta', 'CIS-DF · Simulado', 'Revisão', NULL, '2026-10-24 09:00:00',
        5, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- PRA-02
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[PRA-02] Sáb 24/10 — Prática CAD — 20 questões do domínio da semana', '📅 Sáb 24/10 · ⏰ 11:00

Como candidato ao CAD, quero manter o ritmo de questões no dia do simulado de CIS-DF.

O que fazer:
- 20 questões
- Erros → anotação

Critérios de aceite:
- Nota anotada

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Media', 'CAD · Prática', 'Prática', NULL, '2026-10-24 11:00:00',
        6, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- REV-02
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[REV-02] Dom 25/10 — Revisão leve da semana (3h) — CIS-DF e CAD', '📅 Dom 25/10 · ⏰ 08:00

Como candidato às duas provas, quero fixar o que vi na semana sem me cansar, para chegar inteiro em dezembro.

O que fazer:
- 1h: reler os cards/ANCHOR de CIS-DF da semana
- 1h: reler as anotações de CAD da semana
- 1h: refazer só as questões que errei na semana
- Olhar o quadro da próxima semana

Critérios de aceite:
- Erros da semana refeitos
- Descanso no resto do dia',
        'Media', 'Revisão semanal', 'Revisão', NULL, '2026-10-25 08:00:00',
        7, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-02
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[CIS-02] Seg 26/10 — Objetivo 1 — relacionamentos automáticos × manuais', '📅 Seg 26/10 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Objetivo 1 — relacionamentos automáticos × manuais", para acertar as questões de Ingest (20,7% da prova).

O que fazer:
- Discovery / Service Mapping / Service Graph Connector criam relacionamento sozinhos; Relationship Editor e suggested relationships são manuais
- ANCHOR do objetivo 1
- Na PDI: criar 1 relacionamento pelo Relationship Editor

Critérios de aceite:
- Objetivo 1 ✅
- Regra fixada: no Relationship Editor, (Parent) = o CI aberto vira pai

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Ingest', 'Estudo', 'PDI dev384562 (Australia — não fazer upgrade).', '2026-10-26 07:00:00',
        8, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-02
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[CAD-02] Seg 26/10 — O app combina com a ServiceNow? + o que é Application scope', '📅 Seg 26/10 · ⏰ 09:00

Como candidato ao CAD, quero dominar "O app combina com a ServiceNow? + o que é Application scope", para acertar as questões de D1 Criar app (20% da prova).

O que fazer:
- Critérios de ''good fit'' (processo com registro, aprovação, tarefa, relatório)
- Global × scoped: o que o escopo protege

Critérios de aceite:
- Você explica quando NÃO construir na ServiceNow

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D1 Criar app (20%)', 'Estudo', 'Doc: Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\application-development\\', '2026-10-26 09:00:00',
        9, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-03
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[PRA-03] Seg 26/10 — Prática do dia — CIS-DF (Ingest) + CAD (D1 Criar app)', '📅 Seg 26/10 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Ingest), 1min30 cada
- 15 questões de CAD (D1 Criar app)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-10-26 11:00:00',
        10, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-03
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[CIS-03] Ter 27/10 — Objetivo 5 — CIs e atributos não descobríveis', '📅 Ter 27/10 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Objetivo 5 — CIs e atributos não descobríveis", para acertar as questões de Ingest (20,7% da prova).

O que fazer:
- Transformar a lista discoverable × non-discoverable (13/10) em ANCHOR
- Como manter o manual: Data Manager (attestation), CMDB Workspace, import

Critérios de aceite:
- Objetivo 5 ✅
- Regra: gravado na máquina = discoverable; group/owner/assigned/used for = manual

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Ingest', 'Estudo', 'Fonte: Desktop\\Contexto-IA\\01-CIS-DF\\CIS-DF-HANDOFF.md (entrada de 13/10).', '2026-10-27 07:00:00',
        11, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-03
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[CAD-03] Ter 27/10 — Criar o app scoped na PDI', '📅 Ter 27/10 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Criar o app scoped na PDI", para acertar as questões de D1 Criar app (20% da prova).

O que fazer:
- Criar app no App Engine Studio (ou Studio)
- Ver o prefixo x_ e o que o app gera

Critérios de aceite:
- App criado na PDI

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D1 Criar app (20%)', 'Estudo', 'Doc: Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\application-development\\app-engine-studio\\', '2026-10-27 09:00:00',
        12, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-04
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[PRA-04] Ter 27/10 — Prática do dia — CIS-DF (Ingest) + CAD (D1 Criar app)', '📅 Ter 27/10 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Ingest), 1min30 cada
- 15 questões de CAD (D1 Criar app)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-10-27 11:00:00',
        13, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-04
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[CIS-04] Qua 28/10 — Objetivo 2 — automação da integração (IntegrationHub ETL, Service Graph Connectors)', '📅 Qua 28/10 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Objetivo 2 — automação da integração (IntegrationHub ETL, Service Graph Connectors)", para acertar as questões de Ingest (20,7% da prova).

O que fazer:
- O que é cada um e quando usar
- Por que os dois passam pelo IRE
- ANCHOR do objetivo 2

Critérios de aceite:
- Objetivo 2 ✅
- Você responde: dado externo que precisa passar pelo IRE → qual ferramenta

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Ingest', 'Estudo', 'Doc: Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\servicenow-platform\\cmdb-integration-commons\\ e Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-apis\\cmdb-ingest-api.md', '2026-10-28 07:00:00',
        14, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-04
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[CAD-04] Qua 28/10 — Modelo de dados — tabelas, extensão, campos, referência', '📅 Qua 28/10 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Modelo de dados — tabelas, extensão, campos, referência", para acertar as questões de D1 Criar app (20% da prova).

O que fazer:
- Tabela nova estendendo Task × tabela sem extensão
- 5 campos de tipos diferentes (incluindo Reference e Choice)
- O que vem herdado da Task

Critérios de aceite:
- Tabela criada; você explica herança de tabela

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D1 Criar app (20%)', 'Estudo', NULL, '2026-10-28 09:00:00',
        15, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-05
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[PRA-05] Qua 28/10 — Prática do dia — CIS-DF (Ingest) + CAD (D1 Criar app)', '📅 Qua 28/10 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Ingest), 1min30 cada
- 15 questões de CAD (D1 Criar app)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-10-28 11:00:00',
        16, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-05
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[CIS-05] Qui 29/10 — Objetivo 4 — dívida técnica e upgradeability', '📅 Qui 29/10 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Objetivo 4 — dívida técnica e upgradeability", para acertar as questões de Ingest (20,7% da prova).

O que fazer:
- Não customizar tabela base; estender a classe certa
- IRE + identification rules em vez de script
- Service Graph Connector em vez de transform map caseiro
- ANCHOR com 3 ''faça × não faça''

Critérios de aceite:
- Objetivo 4 ✅

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Ingest', 'Estudo', 'Ligue com o objetivo 3: a pergunta nunca é ''como trago o dado'', é ''o dado passa pelo IRE?''.', '2026-10-29 07:00:00',
        17, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-05
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[CAD-05] Qui 29/10 — Módulos e menus da aplicação', '📅 Qui 29/10 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Módulos e menus da aplicação", para acertar as questões de D1 Criar app (20% da prova).

O que fazer:
- Application menu + módulos (list, new, filtered)
- Ordem e roles do módulo

Critérios de aceite:
- App navegável pelo menu

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D1 Criar app (20%)', 'Estudo', NULL, '2026-10-29 09:00:00',
        18, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-06
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[PRA-06] Qui 29/10 — Prática do dia — CIS-DF (Ingest) + CAD (D1 Criar app)', '📅 Qui 29/10 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Ingest), 1min30 cada
- 15 questões de CAD (D1 Criar app)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-10-29 11:00:00',
        19, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-06
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[CIS-06] Sex 30/10 — Objetivo 6 — identificadores de segurança/regulatórios × objetos CSDM', '📅 Sex 30/10 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Objetivo 6 — identificadores de segurança/regulatórios × objetos CSDM", para acertar as questões de Ingest (20,7% da prova).

O que fazer:
- Onde ficam classificação de dados e compliance contra Business Application / Service
- ANCHOR do objetivo 6

Critérios de aceite:
- Os 7 objetivos do CIS-DF-INGEST.md ✅

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Ingest', 'Estudo', 'Doc: buscar ''data classification'' e ''compliance'' em Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\servicenow-platform\\configuration-management-database-cmdb\\', '2026-10-30 07:00:00',
        20, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-06
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[CAD-06] Sex 30/10 — Application scope — cross-scope e restricted caller access', '📅 Sex 30/10 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Application scope — cross-scope e restricted caller access", para acertar as questões de D1 Criar app (20% da prova).

O que fazer:
- Cross-scope privileges, runtime access tracking
- Rodada de 15 questões do domínio 1

Critérios de aceite:
- Domínio 1 acima de 75%

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D1 Criar app (20%)', 'Estudo', NULL, '2026-10-30 09:00:00',
        21, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-07
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[PRA-07] Sex 30/10 — Prática do dia — CIS-DF (Ingest) + CAD (D1 Criar app)', '📅 Sex 30/10 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Ingest), 1min30 cada
- 15 questões de CAD (D1 Criar app)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-10-30 11:00:00',
        22, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SIM-02
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[SIM-02] Sáb 31/10 — 🎯 Simulado CAD: Lucky X Exam 1 + Exam 2 (58 questões, diagnóstico)', '📅 Sáb 31/10 · ⏰ 07:00

Como candidato ao CAD, quero medir onde estou em condição de prova, para saber onde atacar na semana.

O que fazer:
- Simulado completo, 90 min, sem consultar, celular longe
- Registrar a nota por domínio

Critérios de aceite:
- Nota anotada e comparada com a anterior',
        'Urgente', 'CAD · Simulado', 'Simulado', 'Udemy: Pass ServiceNow Certified Application Developer CAD 10/2026 (Lucky X). Exam 1 + Exam 2 seguidos, ~90 min. Diagnóstico: ainda é cedo, nota baixa é esperada. Pesos: usar a blueprint oficial (20/20/20/20/10/10), não os da descrição do curso.', '2026-10-31 07:00:00',
        23, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- REV-03
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[REV-03] Sáb 31/10 — Revisão do simulado CAD — cada erro vira card', '📅 Sáb 31/10 · ⏰ 09:00

Como candidato ao CAD, quero entender cada erro, para não repetir na prova.

O que fazer:
- Cada erro: traduzir o enunciado → por que errei (inglês? objeto? conceito?) → doc → card/anotação
- Se o gabarito estiver errado, anotar (terceiros já erraram 7 vezes)

Critérios de aceite:
- Nenhum erro sem card',
        'Alta', 'CAD · Simulado', 'Revisão', NULL, '2026-10-31 09:00:00',
        24, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-08
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[PRA-08] Sáb 31/10 — Prática CIS-DF — 20 questões do domínio da semana', '📅 Sáb 31/10 · ⏰ 11:00

Como candidato ao CIS-DF, quero manter o ritmo de questões no dia do simulado de CAD.

O que fazer:
- 20 questões
- Erros → card

Critérios de aceite:
- Nota anotada

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Media', 'CIS-DF · Prática', 'Prática', NULL, '2026-10-31 11:00:00',
        25, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- REV-04
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[REV-04] Dom 01/11 — Revisão leve da semana (3h) — CIS-DF e CAD', '📅 Dom 01/11 · ⏰ 08:00

Como candidato às duas provas, quero fixar o que vi na semana sem me cansar, para chegar inteiro em dezembro.

O que fazer:
- 1h: reler os cards/ANCHOR de CIS-DF da semana
- 1h: reler as anotações de CAD da semana
- 1h: refazer só as questões que errei na semana
- Olhar o quadro da próxima semana

Critérios de aceite:
- Erros da semana refeitos
- Descanso no resto do dia',
        'Media', 'Revisão semanal', 'Revisão', NULL, '2026-11-01 08:00:00',
        26, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-07
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[CIS-07] Seg 02/11 — Teste de fogo — 25 questões só de Ingest', '📅 Seg 02/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Teste de fogo — 25 questões só de Ingest", para acertar as questões de Ingest (20,7% da prova).

O que fazer:
- 25 questões cronometradas (1min30 cada), sem consultar
- Cada erro: traduzir o enunciado → doc → card

Critérios de aceite:
- Nota anotada no HANDOFF (meta > 70%; na prova foi 29%)

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Ingest', 'Estudo', 'Não usar o ''banco de 178'' (veio de dumps).', '2026-11-02 07:00:00',
        27, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-07
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[CAD-07] Seg 02/11 — Forms — layout, seções, views, adicionar/remover campos', '📅 Seg 02/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Forms — layout, seções, views, adicionar/remover campos", para acertar as questões de D2 Interface (20% da prova).

O que fazer:
- Form Designer × Form Layout
- Views e seções
- Adicionar e remover campos de form e de tabela

Critérios de aceite:
- Form da sua tabela com seções

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D2 Interface (20%)', 'Estudo', NULL, '2026-11-02 09:00:00',
        28, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-09
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[PRA-09] Seg 02/11 — Prática do dia — CIS-DF (Ingest) + CAD (D2 Interface)', '📅 Seg 02/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Ingest), 1min30 cada
- 15 questões de CAD (D2 Interface)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-02 11:00:00',
        29, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-08
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[CIS-08] Ter 03/11 — Curso do Arno — Seção 2 (CSDM Primer)', '📅 Ter 03/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Curso do Arno — Seção 2 (CSDM Primer)", para acertar as questões de CSDM (10% da prova).

O que fazer:
- Assistir a seção 2
- Ficha da aula: objetivos traduzidos · tabela 🇬🇧|🇧🇷|🔴 prova · frase-chave
- Conferir cada afirmação do instrutor na doc local

Critérios de aceite:
- Seção 2 concluída e ficha feita no CIS-DF-VOCAB.html

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · CSDM', 'Estudo', 'Slides: ServiceNow CMDB Course Materials - All slides.pdf', '2026-11-03 07:00:00',
        30, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-08
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[CAD-08] Ter 03/11 — Client Scripts — onLoad, onChange, onSubmit, onCellEdit', '📅 Ter 03/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Client Scripts — onLoad, onChange, onSubmit, onCellEdit", para acertar as questões de D2 Interface (20% da prova).

O que fazer:
- g_form, g_user (getFullName() é método válido de GlideUser)
- Um script de cada tipo na PDI

Critérios de aceite:
- 4 client scripts funcionando

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D2 Interface (20%)', 'Estudo', NULL, '2026-11-03 09:00:00',
        31, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-10
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[PRA-10] Ter 03/11 — Prática do dia — CIS-DF (CSDM) + CAD (D2 Interface)', '📅 Ter 03/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (CSDM), 1min30 cada
- 15 questões de CAD (D2 Interface)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-03 11:00:00',
        32, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-09
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[CIS-09] Qua 04/11 — CSDM — os 7 domínios e os estágios', '📅 Qua 04/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "CSDM — os 7 domínios e os estágios", para acertar as questões de CSDM (10% da prova).

O que fazer:
- Foundation, Ideation & Strategy, Design & Planning, Build & Integration, Service Delivery, Service Consumption, Manage Portfolio
- Foundation → Crawl → Walk → Run → Fly
- lifecycle_stage / lifecycle_stage_status

Critérios de aceite:
- Você desenha os 7 domínios de cabeça (CSDM 5 tem 7, não 5)

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · CSDM', 'Estudo', 'Material de terceiros com ''Sell/Consume'' está em CSDM 4.', '2026-11-04 07:00:00',
        33, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-09
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[CAD-09] Qua 04/11 — UI Policies × Client Scripts e debug no cliente', '📅 Qua 04/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "UI Policies × Client Scripts e debug no cliente", para acertar as questões de D2 Interface (20% da prova).

O que fazer:
- Quando usar cada um; ordem de execução
- Debug: console do navegador, JavaScript Log, jslog()

Critérios de aceite:
- Você debuga um client script quebrado de propósito

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D2 Interface (20%)', 'Estudo', NULL, '2026-11-04 09:00:00',
        34, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-11
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[PRA-11] Qua 04/11 — Prática do dia — CIS-DF (CSDM) + CAD (D2 Interface)', '📅 Qua 04/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (CSDM), 1min30 cada
- 15 questões de CAD (D2 Interface)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-04 11:00:00',
        35, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-10
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[CIS-10] Qui 05/11 — CSDM — Business Application × Application Service × Technical Service', '📅 Qui 05/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "CSDM — Business Application × Application Service × Technical Service", para acertar as questões de CSDM (10% da prova).

O que fazer:
- Quem é operacional e quem não é (cmdb_ci_business_app × cmdb_ci_service_auto)
- Onde o incidente aponta
- 15 questões de CSDM

Critérios de aceite:
- CSDM acima de 80% nas questões

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · CSDM', 'Estudo', NULL, '2026-11-05 07:00:00',
        36, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-10
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[CAD-10] Qui 05/11 — Server-side scripts — Business Rules e GlideRecord', '📅 Qui 05/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Server-side scripts — Business Rules e GlideRecord", para acertar as questões de D2 Interface (20% da prova).

O que fazer:
- before / after / async / display; current e previous
- Por que não usar current.update() no before
- Debug: gs.info, Script Debugger

Critérios de aceite:
- Uma BR de cada tipo na PDI

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D2 Interface (20%)', 'Estudo', 'Doc: Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\build-workflows\\business-rules-classic\\', '2026-11-05 09:00:00',
        37, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-12
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[PRA-12] Qui 05/11 — Prática do dia — CIS-DF (CSDM) + CAD (D2 Interface)', '📅 Qui 05/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (CSDM), 1min30 cada
- 15 questões de CAD (D2 Interface)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-05 11:00:00',
        38, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-11
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[CIS-11] Sex 06/11 — As 6 métricas do health score', '📅 Sex 06/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "As 6 métricas do health score", para acertar as questões de Govern (38,7% da prova).

O que fazer:
- 3 KPIs e 6 métricas: Completeness = Required + Recommended · Correctness = Orphan + Staleness + Duplicate · Compliance = Audit
- Staleness padrão = 60 dias

Critérios de aceite:
- Você escreve as 6 métricas de cabeça

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Govern', 'Estudo', 'Govern = 38,7% da prova (o maior peso).', '2026-11-06 07:00:00',
        39, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-11
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[CAD-11] Sex 06/11 — Record Producer como interface do app', '📅 Sex 06/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Record Producer como interface do app", para acertar as questões de D2 Interface (20% da prova).

O que fazer:
- Record Producer gravando na sua tabela
- Variáveis → campos; script do producer

Critérios de aceite:
- Registro criado pelo Service Portal via Record Producer

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D2 Interface (20%)', 'Estudo', NULL, '2026-11-06 09:00:00',
        40, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-13
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[PRA-13] Sex 06/11 — Prática do dia — CIS-DF (Govern) + CAD (D2 Interface)', '📅 Sex 06/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Govern), 1min30 cada
- 15 questões de CAD (D2 Interface)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-06 11:00:00',
        41, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SIM-03
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[SIM-03] Sáb 07/11 — 🎯 Simulado CIS-DF completo e cronometrado', '📅 Sáb 07/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero medir onde estou em condição de prova, para saber onde atacar na semana.

O que fazer:
- Simulado completo, 90 min, sem consultar, celular longe
- Registrar a nota por domínio

Critérios de aceite:
- Nota anotada e comparada com a anterior',
        'Urgente', 'CIS-DF · Simulado', 'Simulado', 'CIS-DF: Lucky X / curso oficial (não o banco de 178).', '2026-11-07 07:00:00',
        42, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- REV-05
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[REV-05] Sáb 07/11 — Revisão do simulado CIS-DF — cada erro vira card', '📅 Sáb 07/11 · ⏰ 09:00

Como candidato ao CIS-DF, quero entender cada erro, para não repetir na prova.

O que fazer:
- Cada erro: traduzir o enunciado → por que errei (inglês? objeto? conceito?) → doc → card/anotação
- Se o gabarito estiver errado, anotar (terceiros já erraram 7 vezes)

Critérios de aceite:
- Nenhum erro sem card',
        'Alta', 'CIS-DF · Simulado', 'Revisão', NULL, '2026-11-07 09:00:00',
        43, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- PRA-14
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[PRA-14] Sáb 07/11 — Prática CAD — 20 questões do domínio da semana', '📅 Sáb 07/11 · ⏰ 11:00

Como candidato ao CAD, quero manter o ritmo de questões no dia do simulado de CIS-DF.

O que fazer:
- 20 questões
- Erros → anotação

Critérios de aceite:
- Nota anotada

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Media', 'CAD · Prática', 'Prática', NULL, '2026-11-07 11:00:00',
        44, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- REV-06
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[REV-06] Dom 08/11 — Revisão leve da semana (3h) — CIS-DF e CAD', '📅 Dom 08/11 · ⏰ 08:00

Como candidato às duas provas, quero fixar o que vi na semana sem me cansar, para chegar inteiro em dezembro.

O que fazer:
- 1h: reler os cards/ANCHOR de CIS-DF da semana
- 1h: reler as anotações de CAD da semana
- 1h: refazer só as questões que errei na semana
- Olhar o quadro da próxima semana

Critérios de aceite:
- Erros da semana refeitos
- Descanso no resto do dia',
        'Media', 'Revisão semanal', 'Revisão', NULL, '2026-11-08 08:00:00',
        45, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-12
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[CIS-12] Seg 09/11 — Data Manager — políticas', '📅 Seg 09/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Data Manager — políticas", para acertar as questões de Govern (38,7% da prova).

O que fazer:
- Attestation, Certification, Retire, Archive, Delete
- Propósito e requisitos do Data Manager

Critérios de aceite:
- Attestation × Certification em uma frase cada

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Govern', 'Estudo', NULL, '2026-11-09 07:00:00',
        46, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-12
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[CAD-12] Seg 09/11 — Rodada de 20 questões do domínio 2', '📅 Seg 09/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Rodada de 20 questões do domínio 2", para acertar as questões de D2 Interface (20% da prova).

O que fazer:
- 20 questões
- Erros → anotação

Critérios de aceite:
- Domínio 2 acima de 75%

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D2 Interface (20%)', 'Estudo', NULL, '2026-11-09 09:00:00',
        47, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-15
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[PRA-15] Seg 09/11 — Prática do dia — CIS-DF (Govern) + CAD (D2 Interface)', '📅 Seg 09/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Govern), 1min30 cada
- 15 questões de CAD (D2 Interface)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-09 11:00:00',
        48, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-13
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[CIS-13] Ter 10/11 — Papéis-chave e governança', '📅 Ter 10/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Papéis-chave e governança", para acertar as questões de Govern (38,7% da prova).

O que fazer:
- Papéis: CMDB admin, data steward, owner, data manager
- Metas de boa governança e o que é preciso para governar

Critérios de aceite:
- Você liga cada papel à sua responsabilidade

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Govern', 'Estudo', NULL, '2026-11-10 07:00:00',
        49, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-13
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[CAD-13] Ter 10/11 — Restringir acesso ao app e aos módulos', '📅 Ter 10/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Restringir acesso ao app e aos módulos", para acertar as questões de D3 Segurança (20% da prova).

O que fazer:
- Roles no application menu e nos módulos
- Role do app, herança de role

Critérios de aceite:
- Usuário sem role não vê o app

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D3 Segurança (20%)', 'Estudo', 'Doc: Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\platform-security\\access-control\\', '2026-11-10 09:00:00',
        50, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-16
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[PRA-16] Ter 10/11 — Prática do dia — CIS-DF (Govern) + CAD (D3 Segurança)', '📅 Ter 10/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Govern), 1min30 cada
- 15 questões de CAD (D3 Segurança)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-10 11:00:00',
        51, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-14
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[CIS-14] Qua 11/11 — Rodada de 30 questões de Govern', '📅 Qua 11/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Rodada de 30 questões de Govern", para acertar as questões de Govern (38,7% da prova).

O que fazer:
- 30 questões cronometradas
- Erros → tradução → doc → card

Critérios de aceite:
- Govern acima de 75%

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Govern', 'Estudo', NULL, '2026-11-11 07:00:00',
        52, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-14
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[CAD-14] Qua 11/11 — Access Controls — tipos e ordem de avaliação', '📅 Qua 11/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Access Controls — tipos e ordem de avaliação", para acertar as questões de D3 Segurança (20% da prova).

O que fazer:
- Table × field, wildcard (*)
- Ordem: role → condition → script; tabela antes do campo
- ACL criada automaticamente ao criar tabela no app

Critérios de aceite:
- Você descreve a ordem de avaliação sem olhar

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D3 Segurança (20%)', 'Estudo', 'Doc: Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\application-development\\ACL-access-checks.md', '2026-11-11 09:00:00',
        53, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-17
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[PRA-17] Qua 11/11 — Prática do dia — CIS-DF (Govern) + CAD (D3 Segurança)', '📅 Qua 11/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Govern), 1min30 cada
- 15 questões de CAD (D3 Segurança)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-11 11:00:00',
        54, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-15
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[CIS-15] Qui 12/11 — CI Class Manager', '📅 Qui 12/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "CI Class Manager", para acertar as questões de Configuration (14% da prova).

O que fazer:
- Atributos, hierarquia, identification e reconciliation rules, principal class, recommended fields
- Na PDI: abrir uma classe e achar cada item

Critérios de aceite:
- Regra: objeto é classe/atributo/regra → CI Class Manager, SEMPRE

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Configuration', 'Estudo', 'Doc: Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\servicenow-platform\\cmdb-ci-class-models\\', '2026-11-12 07:00:00',
        55, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-15
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[CAD-15] Qui 12/11 — Testar e debugar ACL', '📅 Qui 12/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Testar e debugar ACL", para acertar as questões de D3 Segurança (20% da prova).

O que fazer:
- Debug Security Rules, impersonar usuário
- Access Analyzer

Critérios de aceite:
- Você explica um ''acesso negado'' pelo debug

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D3 Segurança (20%)', 'Estudo', NULL, '2026-11-12 09:00:00',
        56, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-18
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[PRA-18] Qui 12/11 — Prática do dia — CIS-DF (Configuration) + CAD (D3 Segurança)', '📅 Qui 12/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Configuration), 1min30 cada
- 15 questões de CAD (D3 Segurança)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-12 11:00:00',
        57, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-16
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[CIS-16] Sex 13/11 — IRE — identificação, reconciliação e precedência', '📅 Sex 13/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "IRE — identificação, reconciliação e precedência", para acertar as questões de Configuration (14% da prova).

O que fazer:
- Identification rules, reconciliation rules, data source precedence
- O que o IRE faz quando há duplicata

Critérios de aceite:
- Você explica o caminho de um payload pelo IRE

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Configuration', 'Estudo', NULL, '2026-11-13 07:00:00',
        58, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-16
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[CAD-16] Sex 13/11 — GlideSystem para scriptar segurança', '📅 Sex 13/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "GlideSystem para scriptar segurança", para acertar as questões de D3 Segurança (20% da prova).

O que fazer:
- gs.hasRole(), gs.getUser(), gs.getUserID(), gs.isLoggedIn()
- ACL com script usando answer

Critérios de aceite:
- ACL com script funcionando na PDI

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D3 Segurança (20%)', 'Estudo', NULL, '2026-11-13 09:00:00',
        59, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-19
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[PRA-19] Sex 13/11 — Prática do dia — CIS-DF (Configuration) + CAD (D3 Segurança)', '📅 Sex 13/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Configuration), 1min30 cada
- 15 questões de CAD (D3 Segurança)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-13 11:00:00',
        60, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SIM-04
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[SIM-04] Sáb 14/11 — 🎯 Simulado CAD: Lucky X Exam 3 + Exam 4 (58 questões)', '📅 Sáb 14/11 · ⏰ 07:00

Como candidato ao CAD, quero medir onde estou em condição de prova, para saber onde atacar na semana.

O que fazer:
- Simulado completo, 90 min, sem consultar, celular longe
- Registrar a nota por domínio

Critérios de aceite:
- Nota anotada e comparada com a anterior',
        'Urgente', 'CAD · Simulado', 'Simulado', 'Lucky X Exam 3 + Exam 4. Comparar com 31/10 por domínio. Exams 1-4 se parecem (aluna relatou repetição): se reconhecer a questão de cor, marque e não conte como acerto.', '2026-11-14 07:00:00',
        61, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- REV-07
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[REV-07] Sáb 14/11 — Revisão do simulado CAD — cada erro vira card', '📅 Sáb 14/11 · ⏰ 09:00

Como candidato ao CAD, quero entender cada erro, para não repetir na prova.

O que fazer:
- Cada erro: traduzir o enunciado → por que errei (inglês? objeto? conceito?) → doc → card/anotação
- Se o gabarito estiver errado, anotar (terceiros já erraram 7 vezes)

Critérios de aceite:
- Nenhum erro sem card',
        'Alta', 'CAD · Simulado', 'Revisão', NULL, '2026-11-14 09:00:00',
        62, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-20
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[PRA-20] Sáb 14/11 — Prática CIS-DF — 20 questões do domínio da semana', '📅 Sáb 14/11 · ⏰ 11:00

Como candidato ao CIS-DF, quero manter o ritmo de questões no dia do simulado de CAD.

O que fazer:
- 20 questões
- Erros → card

Critérios de aceite:
- Nota anotada

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Media', 'CIS-DF · Prática', 'Prática', NULL, '2026-11-14 11:00:00',
        63, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- REV-08
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[REV-08] Dom 15/11 — Revisão leve da semana (3h) — CIS-DF e CAD', '📅 Dom 15/11 · ⏰ 08:00

Como candidato às duas provas, quero fixar o que vi na semana sem me cansar, para chegar inteiro em dezembro.

O que fazer:
- 1h: reler os cards/ANCHOR de CIS-DF da semana
- 1h: reler as anotações de CAD da semana
- 1h: refazer só as questões que errei na semana
- Olhar o quadro da próxima semana

Critérios de aceite:
- Erros da semana refeitos
- Descanso no resto do dia',
        'Media', 'Revisão semanal', 'Revisão', NULL, '2026-11-15 08:00:00',
        64, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-17
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[CIS-17] Seg 16/11 — CMDB 360 / multisource', '📅 Seg 16/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "CMDB 360 / multisource", para acertar as questões de Configuration (14% da prova).

O que fazer:
- CMDB 360 = 1 CI, N fontes (compare attribute values / find gap)
- Quando habilitar e o que mostra

Critérios de aceite:
- Você diferencia CMDB 360 de CMDB Health

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Configuration', 'Estudo', NULL, '2026-11-16 07:00:00',
        65, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-17
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[CAD-17] Seg 16/11 — Application Scope protegendo artefatos + 20 questões D3', '📅 Seg 16/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Application Scope protegendo artefatos + 20 questões D3", para acertar as questões de D3 Segurança (20% da prova).

O que fazer:
- Application access (can read/create/update/delete, web services)
- Protection policy (read-only / protected)
- 20 questões do domínio 3

Critérios de aceite:
- Domínio 3 acima de 75%

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D3 Segurança (20%)', 'Estudo', NULL, '2026-11-16 09:00:00',
        66, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-21
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[PRA-21] Seg 16/11 — Prática do dia — CIS-DF (Configuration) + CAD (D3 Segurança)', '📅 Seg 16/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Configuration), 1min30 cada
- 15 questões de CAD (D3 Segurança)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-16 11:00:00',
        67, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-18
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[CIS-18] Ter 17/11 — Rodada de 25 questões de Configuration', '📅 Ter 17/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Rodada de 25 questões de Configuration", para acertar as questões de Configuration (14% da prova).

O que fazer:
- 25 questões cronometradas
- Erros → card

Critérios de aceite:
- Configuration acima de 75%

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Configuration', 'Estudo', NULL, '2026-11-17 07:00:00',
        68, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-18
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[CAD-18] Ter 17/11 — Flow Designer — trigger, actions, flow logic, subflow', '📅 Ter 17/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Flow Designer — trigger, actions, flow logic, subflow", para acertar as questões de D4 Automação (20% da prova).

O que fazer:
- Flow com trigger de registro + aprovação
- Testar e debugar (Test, Execution Details)

Critérios de aceite:
- Flow rodando na PDI

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D4 Automação (20%)', 'Estudo', 'Doc: Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\build-workflows\\workflow-studio\\', '2026-11-17 09:00:00',
        69, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-22
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[PRA-22] Ter 17/11 — Prática do dia — CIS-DF (Configuration) + CAD (D4 Automação)', '📅 Ter 17/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Configuration), 1min30 cada
- 15 questões de CAD (D4 Automação)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-17 11:00:00',
        70, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-19
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[CIS-19] Qua 18/11 — CMDB Workspace, NLQ e Query Builder', '📅 Qua 18/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "CMDB Workspace, NLQ e Query Builder", para acertar as questões de Insight (16,7% da prova).

O que fazer:
- O que mora no Workspace (NLQ mora no Workspace — recaída nº5)
- Query Builder: consultas por relacionamento
- Na PDI: navegar o Workspace

Critérios de aceite:
- Regra: objeto que NÃO é classe (CI, task, policy, duplicata, busca) → CMDB Workspace

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Insight', 'Estudo', 'Insight = 16,7% da prova.', '2026-11-18 07:00:00',
        71, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-19
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[CAD-19] Qua 18/11 — Workflow (legado) — o mínimo da prova', '📅 Qua 18/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Workflow (legado) — o mínimo da prova", para acertar as questões de D4 Automação (20% da prova).

O que fazer:
- Activities, transições, testar o workflow
- Workflow × Flow Designer: quando cada um

Critérios de aceite:
- Você explica a diferença

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D4 Automação (20%)', 'Estudo', 'Doc: Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\build-workflows\\legacy-workflow\\', '2026-11-18 09:00:00',
        72, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-23
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[PRA-23] Qua 18/11 — Prática do dia — CIS-DF (Insight) + CAD (D4 Automação)', '📅 Qua 18/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Insight), 1min30 cada
- 15 questões de CAD (D4 Automação)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-18 11:00:00',
        73, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-20
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[CIS-20] Qui 19/11 — Dashboards de saúde e Data Foundations', '📅 Qui 19/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Dashboards de saúde e Data Foundations", para acertar as questões de Insight (16,7% da prova).

O que fazer:
- CMDB Health Dashboard, CMDB Data Foundations Dashboard
- Quem mede × quem age × quem define × quem mostra

Critérios de aceite:
- Tabela ''quem faz o quê'' refeita de cabeça

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Insight', 'Estudo', NULL, '2026-11-19 07:00:00',
        74, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-20
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[CAD-20] Qui 19/11 — Application Properties', '📅 Qui 19/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Application Properties", para acertar as questões de D4 Automação (20% da prova).

O que fazer:
- Criar propriedade no escopo do app
- gs.getProperty() e página de propriedades do app

Critérios de aceite:
- Propriedade lida por script na PDI

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D4 Automação (20%)', 'Estudo', NULL, '2026-11-19 09:00:00',
        75, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-24
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[PRA-24] Qui 19/11 — Prática do dia — CIS-DF (Insight) + CAD (D4 Automação)', '📅 Qui 19/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Insight), 1min30 cada
- 15 questões de CAD (D4 Automação)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-19 11:00:00',
        76, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-21
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[CIS-21] Sex 20/11 — Rodada de 25 questões de Insight', '📅 Sex 20/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Rodada de 25 questões de Insight", para acertar as questões de Insight (16,7% da prova).

O que fazer:
- 25 questões
- Erros → card

Critérios de aceite:
- Insight acima de 75%

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Insight', 'Estudo', NULL, '2026-11-20 07:00:00',
        77, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-21
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[CAD-21] Sex 20/11 — Events e Scheduled Script Executions', '📅 Sex 20/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Events e Scheduled Script Executions", para acertar as questões de D4 Automação (20% da prova).

O que fazer:
- Event Registry, gs.eventQueue(), Script Action
- Scheduled Job: Run = Monthly, Day = 31 roda no último dia do mês (questão oficial)

Critérios de aceite:
- Evento disparando script na PDI

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D4 Automação (20%)', 'Estudo', 'Doc: Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\build-workflows\\system-events\\', '2026-11-20 09:00:00',
        78, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-25
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[PRA-25] Sex 20/11 — Prática do dia — CIS-DF (Insight) + CAD (D4 Automação)', '📅 Sex 20/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Insight), 1min30 cada
- 15 questões de CAD (D4 Automação)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-20 11:00:00',
        79, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SIM-05
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[SIM-05] Sáb 21/11 — 🎯 Simulado CIS-DF completo e cronometrado', '📅 Sáb 21/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero medir onde estou em condição de prova, para saber onde atacar na semana.

O que fazer:
- Simulado completo, 90 min, sem consultar, celular longe
- Registrar a nota por domínio

Critérios de aceite:
- Nota anotada e comparada com a anterior',
        'Urgente', 'CIS-DF · Simulado', 'Simulado', 'CIS-DF: Lucky X / curso oficial (não o banco de 178).', '2026-11-21 07:00:00',
        80, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- REV-09
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[REV-09] Sáb 21/11 — Revisão do simulado CIS-DF — cada erro vira card', '📅 Sáb 21/11 · ⏰ 09:00

Como candidato ao CIS-DF, quero entender cada erro, para não repetir na prova.

O que fazer:
- Cada erro: traduzir o enunciado → por que errei (inglês? objeto? conceito?) → doc → card/anotação
- Se o gabarito estiver errado, anotar (terceiros já erraram 7 vezes)

Critérios de aceite:
- Nenhum erro sem card',
        'Alta', 'CIS-DF · Simulado', 'Revisão', NULL, '2026-11-21 09:00:00',
        81, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- PRA-26
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[PRA-26] Sáb 21/11 — Prática CAD — 20 questões do domínio da semana', '📅 Sáb 21/11 · ⏰ 11:00

Como candidato ao CAD, quero manter o ritmo de questões no dia do simulado de CIS-DF.

O que fazer:
- 20 questões
- Erros → anotação

Critérios de aceite:
- Nota anotada

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Media', 'CAD · Prática', 'Prática', NULL, '2026-11-21 11:00:00',
        82, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- REV-10
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[REV-10] Dom 22/11 — Revisão leve da semana (3h) — CIS-DF e CAD', '📅 Dom 22/11 · ⏰ 08:00

Como candidato às duas provas, quero fixar o que vi na semana sem me cansar, para chegar inteiro em dezembro.

O que fazer:
- 1h: reler os cards/ANCHOR de CIS-DF da semana
- 1h: reler as anotações de CAD da semana
- 1h: refazer só as questões que errei na semana
- Olhar o quadro da próxima semana

Critérios de aceite:
- Erros da semana refeitos
- Descanso no resto do dia',
        'Media', 'Revisão semanal', 'Revisão', NULL, '2026-11-22 08:00:00',
        83, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-22
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[CIS-22] Seg 23/11 — Ingest — revisão + 20 questões', '📅 Seg 23/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Ingest — revisão + 20 questões", para acertar as questões de Ingest (20,7% da prova).

O que fazer:
- Reler o CIS-DF-INGEST.md inteiro
- 20 questões de Ingest

Critérios de aceite:
- Ingest acima de 75%

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Ingest', 'Estudo', 'Foi o domínio que reprovou a 1ª prova.', '2026-11-23 07:00:00',
        84, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-22
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[CAD-22] Seg 23/11 — Script Includes utilitários (Utils) + GlideAjax', '📅 Seg 23/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Script Includes utilitários (Utils) + GlideAjax", para acertar as questões de D4 Automação (20% da prova).

O que fazer:
- Script Include com classe (Class.create) × classless
- Client callable + GlideAjax assíncrono

Critérios de aceite:
- GlideAjax buscando valor de um Utils

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D4 Automação (20%)', 'Estudo', NULL, '2026-11-23 09:00:00',
        85, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-27
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[PRA-27] Seg 23/11 — Prática do dia — CIS-DF (Ingest) + CAD (D4 Automação)', '📅 Seg 23/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Ingest), 1min30 cada
- 15 questões de CAD (D4 Automação)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-23 11:00:00',
        86, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-23
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[CIS-23] Ter 24/11 — Govern — revisão + 25 questões', '📅 Ter 24/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Govern — revisão + 25 questões", para acertar as questões de Govern (38,7% da prova).

O que fazer:
- Reler Govern no CIS-DF.md
- 25 questões

Critérios de aceite:
- Govern acima de 80%

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Govern', 'Estudo', NULL, '2026-11-24 07:00:00',
        87, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-23
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[CAD-23] Ter 24/11 — E-mail — enviar e receber + 20 questões D4', '📅 Ter 24/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "E-mail — enviar e receber + 20 questões D4", para acertar as questões de D4 Automação (20% da prova).

O que fazer:
- Notification por evento e por registro
- Inbound Email Action (receber)
- 20 questões do domínio 4

Critérios de aceite:
- Domínio 4 acima de 75%

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D4 Automação (20%)', 'Estudo', NULL, '2026-11-24 09:00:00',
        88, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-28
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[PRA-28] Ter 24/11 — Prática do dia — CIS-DF (Govern) + CAD (D4 Automação)', '📅 Ter 24/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Govern), 1min30 cada
- 15 questões de CAD (D4 Automação)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-24 11:00:00',
        89, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-24
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[CIS-24] Qua 25/11 — Curso do Arno — próxima seção (Discovery / hands-on)', '📅 Qua 25/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Curso do Arno — próxima seção (Discovery / hands-on)", para acertar as questões de Configuration (14% da prova).

O que fazer:
- Próxima seção do curso
- Exercício na PDI
- Ficha da aula

Critérios de aceite:
- Seção concluída com ficha

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Configuration', 'Estudo', 'Sempre na PDI, nunca demo5/demo4/chaintech.', '2026-11-25 07:00:00',
        90, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-24
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[CAD-24] Qua 25/11 — Importar CSV/Excel — Import Sets e Transform Maps', '📅 Qua 25/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Importar CSV/Excel — Import Sets e Transform Maps", para acertar as questões de D5 Dados externos (10% da prova).

O que fazer:
- Staging table, transform map, coalesce, transform scripts
- Auto Map Matching Fields (questão oficial)
- Importar uma planilha na PDI

Critérios de aceite:
- Importação com coalesce funcionando

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D5 Dados externos (10%)', 'Estudo', 'Doc: Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\system-import-sets\\', '2026-11-25 09:00:00',
        91, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-29
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[PRA-29] Qua 25/11 — Prática do dia — CIS-DF (Configuration) + CAD (D5 Dados externos)', '📅 Qua 25/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Configuration), 1min30 cada
- 15 questões de CAD (D5 Dados externos)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-25 11:00:00',
        92, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-25
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[CIS-25] Qui 26/11 — 40 questões mistas — foco nos 2 domínios mais fracos', '📅 Qui 26/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "40 questões mistas — foco nos 2 domínios mais fracos", para acertar as questões de Misto (todos da prova).

O que fazer:
- 40 questões
- Erros → card

Critérios de aceite:
- Nota anotada por domínio

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Misto', 'Estudo', NULL, '2026-11-26 07:00:00',
        93, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-25
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[CAD-25] Qui 26/11 — REST — integrar, testar e debugar', '📅 Qui 26/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "REST — integrar, testar e debugar", para acertar as questões de D5 Dados externos (10% da prova).

O que fazer:
- REST Message (saída) e REST API Explorer
- Scripted REST API (entrada)
- Debug: outbound HTTP log

Critérios de aceite:
- Chamada REST funcionando nos dois sentidos

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D5 Dados externos (10%)', 'Estudo', NULL, '2026-11-26 09:00:00',
        94, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-30
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[PRA-30] Qui 26/11 — Prática do dia — CIS-DF (Misto) + CAD (D5 Dados externos)', '📅 Qui 26/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Misto), 1min30 cada
- 15 questões de CAD (D5 Dados externos)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-26 11:00:00',
        95, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-26
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[CIS-26] Sex 27/11 — 40 questões mistas — rodada 2', '📅 Sex 27/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "40 questões mistas — rodada 2", para acertar as questões de Misto (todos da prova).

O que fazer:
- 40 questões novas
- Erros → card

Critérios de aceite:
- Nota acima da rodada 1

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Misto', 'Estudo', NULL, '2026-11-27 07:00:00',
        96, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-26
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[CAD-26] Sex 27/11 — Baixar/instalar apps e Delegated Development', '📅 Sex 27/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Baixar/instalar apps e Delegated Development", para acertar as questões de D6 Gerir app (10% da prova).

O que fazer:
- Instalar app do repositório / Store
- Delegated Development: permissões de código e code review

Critérios de aceite:
- Você explica o que o delegated developer pode e não pode

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D6 Gerir app (10%)', 'Estudo', 'Doc: Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\application-development\\application-repository-self-hosted\\', '2026-11-27 09:00:00',
        97, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-31
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[PRA-31] Sex 27/11 — Prática do dia — CIS-DF (Misto) + CAD (D6 Gerir app)', '📅 Sex 27/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Misto), 1min30 cada
- 15 questões de CAD (D6 Gerir app)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-27 11:00:00',
        98, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SIM-06
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[SIM-06] Sáb 28/11 — 🎯 Simulado CAD: Lucky X Exam 5 (80 questões)', '📅 Sáb 28/11 · ⏰ 07:00

Como candidato ao CAD, quero medir onde estou em condição de prova, para saber onde atacar na semana.

O que fazer:
- Simulado completo, 90 min, sem consultar, celular longe
- Registrar a nota por domínio

Critérios de aceite:
- Nota anotada e comparada com a anterior',
        'Urgente', 'CAD · Simulado', 'Simulado', 'Lucky X Exam 5 (80 questões, ~2h). Um dos dois mais realistas segundo as avaliações.', '2026-11-28 07:00:00',
        99, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- REV-11
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[REV-11] Sáb 28/11 — Revisão do simulado CAD — cada erro vira card', '📅 Sáb 28/11 · ⏰ 09:00

Como candidato ao CAD, quero entender cada erro, para não repetir na prova.

O que fazer:
- Cada erro: traduzir o enunciado → por que errei (inglês? objeto? conceito?) → doc → card/anotação
- Se o gabarito estiver errado, anotar (terceiros já erraram 7 vezes)

Critérios de aceite:
- Nenhum erro sem card',
        'Alta', 'CAD · Simulado', 'Revisão', NULL, '2026-11-28 09:00:00',
        100, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-32
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[PRA-32] Sáb 28/11 — Prática CIS-DF — 20 questões do domínio da semana', '📅 Sáb 28/11 · ⏰ 11:00

Como candidato ao CIS-DF, quero manter o ritmo de questões no dia do simulado de CAD.

O que fazer:
- 20 questões
- Erros → card

Critérios de aceite:
- Nota anotada

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Media', 'CIS-DF · Prática', 'Prática', NULL, '2026-11-28 11:00:00',
        101, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- REV-12
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[REV-12] Dom 29/11 — Revisão leve da semana (3h) — CIS-DF e CAD', '📅 Dom 29/11 · ⏰ 08:00

Como candidato às duas provas, quero fixar o que vi na semana sem me cansar, para chegar inteiro em dezembro.

O que fazer:
- 1h: reler os cards/ANCHOR de CIS-DF da semana
- 1h: reler as anotações de CAD da semana
- 1h: refazer só as questões que errei na semana
- Olhar o quadro da próxima semana

Critérios de aceite:
- Erros da semana refeitos
- Descanso no resto do dia',
        'Media', 'Revisão semanal', 'Revisão', NULL, '2026-11-29 08:00:00',
        102, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-27
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[CIS-27] Seg 30/11 — Recaídas — os ANCHORs que já te derrubaram', '📅 Seg 30/11 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Recaídas — os ANCHORs que já te derrubaram", para acertar as questões de Misto (todos da prova).

O que fazer:
- Reler todos os ANCHOR de recaída no CIS-DF.md
- Refazer as questões que geraram cada recaída

Critérios de aceite:
- Nenhuma recaída sem revisão

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Alta', 'CIS-DF · Misto', 'Estudo', NULL, '2026-11-30 07:00:00',
        103, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-27
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[CAD-27] Seg 30/11 — Integração Git + 20 questões D5/D6', '📅 Seg 30/11 · ⏰ 09:00

Como candidato ao CAD, quero dominar "Integração Git + 20 questões D5/D6", para acertar as questões de D6 Gerir app (10% da prova).

O que fazer:
- Link do app ao Git, branch, commit, stash, apply remote changes
- 20 questões de D5 e D6

Critérios de aceite:
- Domínios 5 e 6 acima de 75%

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · D6 Gerir app (10%)', 'Estudo', NULL, '2026-11-30 09:00:00',
        104, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PRA-33
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[PRA-33] Seg 30/11 — Prática do dia — CIS-DF (Misto) + CAD (D6 Gerir app)', '📅 Seg 30/11 · ⏰ 11:00

Como candidato às duas provas, quero transformar a matéria do dia em acerto de questão.

O que fazer:
- 15 questões de CIS-DF (Misto), 1min30 cada
- 15 questões de CAD (D6 Gerir app)
- Cada erro: enunciado traduzido → regra certa

Critérios de aceite:
- 30 questões feitas e erros anotados',
        'Alta', 'Prática diária', 'Prática', NULL, '2026-11-30 11:00:00',
        105, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-28
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[CIS-28] Ter 01/12 — Ingest — revisão completa dos 7 objetivos', '📅 Ter 01/12 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Ingest — revisão completa dos 7 objetivos", para acertar as questões de todos os domínios (100% da prova).

O que fazer:
- Reler o material do tema
- Refazer as questões que errei nele

Critérios de aceite:
- Tema revisado

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Reta final', 'Revisão', NULL, '2026-12-01 07:00:00',
        106, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SIM-07
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SIM-07] Ter 01/12 — CIS-DF — Mini-simulado 30 questões', '📅 Ter 01/12 · ⏰ 09:00

Como candidato ao CIS-DF, quero volume de questões em condição de prova na reta final.

O que fazer:
- 30 questões cronometradas (45 min)
- Revisão dos erros

Critérios de aceite:
- Nota anotada; meta > 80%

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Simulado', 'Simulado', NULL, '2026-12-01 09:00:00',
        107, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- PRA-34
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[PRA-34] Ter 01/12 — CAD — 20 questões D1', '📅 Ter 01/12 · ⏰ 11:00

Como candidato ao CAD, quero não esfriar o CAD durante a reta final do CIS-DF.

O que fazer:
- 20 questões
- Erros → anotação

Critérios de aceite:
- Nota anotada

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Media', 'CAD · Prática', 'Prática', NULL, '2026-12-01 11:00:00',
        108, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-29
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[CIS-29] Qua 02/12 — Govern — revisão completa', '📅 Qua 02/12 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Govern — revisão completa", para acertar as questões de todos os domínios (100% da prova).

O que fazer:
- Reler o material do tema
- Refazer as questões que errei nele

Critérios de aceite:
- Tema revisado

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Reta final', 'Revisão', NULL, '2026-12-02 07:00:00',
        109, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SIM-08
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SIM-08] Qua 02/12 — CIS-DF — Mini-simulado 30 questões', '📅 Qua 02/12 · ⏰ 09:00

Como candidato ao CIS-DF, quero volume de questões em condição de prova na reta final.

O que fazer:
- 30 questões cronometradas (45 min)
- Revisão dos erros

Critérios de aceite:
- Nota anotada; meta > 80%

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Simulado', 'Simulado', NULL, '2026-12-02 09:00:00',
        110, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- PRA-35
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[PRA-35] Qua 02/12 — CAD — 20 questões D2', '📅 Qua 02/12 · ⏰ 11:00

Como candidato ao CAD, quero não esfriar o CAD durante a reta final do CIS-DF.

O que fazer:
- 20 questões
- Erros → anotação

Critérios de aceite:
- Nota anotada

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Media', 'CAD · Prática', 'Prática', NULL, '2026-12-02 11:00:00',
        111, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-30
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[CIS-30] Qui 03/12 — Configuration + CSDM — revisão', '📅 Qui 03/12 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Configuration + CSDM — revisão", para acertar as questões de todos os domínios (100% da prova).

O que fazer:
- Reler o material do tema
- Refazer as questões que errei nele

Critérios de aceite:
- Tema revisado

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Reta final', 'Revisão', NULL, '2026-12-03 07:00:00',
        112, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SIM-09
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SIM-09] Qui 03/12 — CIS-DF — Mini-simulado 30 questões', '📅 Qui 03/12 · ⏰ 09:00

Como candidato ao CIS-DF, quero volume de questões em condição de prova na reta final.

O que fazer:
- 30 questões cronometradas (45 min)
- Revisão dos erros

Critérios de aceite:
- Nota anotada; meta > 80%

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Simulado', 'Simulado', NULL, '2026-12-03 09:00:00',
        113, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- PRA-36
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[PRA-36] Qui 03/12 — CAD — 20 questões D3', '📅 Qui 03/12 · ⏰ 11:00

Como candidato ao CAD, quero não esfriar o CAD durante a reta final do CIS-DF.

O que fazer:
- 20 questões
- Erros → anotação

Critérios de aceite:
- Nota anotada

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Media', 'CAD · Prática', 'Prática', NULL, '2026-12-03 11:00:00',
        114, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-31
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[CIS-31] Sex 04/12 — Insight — revisão + tabela ''quem faz o quê''', '📅 Sex 04/12 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Insight — revisão + tabela ''quem faz o quê''", para acertar as questões de todos os domínios (100% da prova).

O que fazer:
- Reler o material do tema
- Refazer as questões que errei nele

Critérios de aceite:
- Tema revisado

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Reta final', 'Revisão', NULL, '2026-12-04 07:00:00',
        115, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SIM-10
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SIM-10] Sex 04/12 — CIS-DF — Mini-simulado 30 questões', '📅 Sex 04/12 · ⏰ 09:00

Como candidato ao CIS-DF, quero volume de questões em condição de prova na reta final.

O que fazer:
- 30 questões cronometradas (45 min)
- Revisão dos erros

Critérios de aceite:
- Nota anotada; meta > 80%

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Simulado', 'Simulado', NULL, '2026-12-04 09:00:00',
        116, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- PRA-37
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[PRA-37] Sex 04/12 — CAD — 20 questões D4', '📅 Sex 04/12 · ⏰ 11:00

Como candidato ao CAD, quero não esfriar o CAD durante a reta final do CIS-DF.

O que fazer:
- 20 questões
- Erros → anotação

Critérios de aceite:
- Nota anotada

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Media', 'CAD · Prática', 'Prática', NULL, '2026-12-04 11:00:00',
        117, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SIM-11
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[SIM-11] Sáb 05/12 — 🎯 Simulado CIS-DF completo e cronometrado', '📅 Sáb 05/12 · ⏰ 07:00

Como candidato ao CIS-DF, quero medir onde estou em condição de prova, para saber onde atacar na semana.

O que fazer:
- Simulado completo, 90 min, sem consultar, celular longe
- Registrar a nota por domínio

Critérios de aceite:
- Nota anotada e comparada com a anterior',
        'Urgente', 'CIS-DF · Simulado', 'Simulado', 'CIS-DF: Lucky X / curso oficial (não o banco de 178).', '2026-12-05 07:00:00',
        118, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- REV-13
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[REV-13] Sáb 05/12 — Revisão do simulado CIS-DF — cada erro vira card', '📅 Sáb 05/12 · ⏰ 09:00

Como candidato ao CIS-DF, quero entender cada erro, para não repetir na prova.

O que fazer:
- Cada erro: traduzir o enunciado → por que errei (inglês? objeto? conceito?) → doc → card/anotação
- Se o gabarito estiver errado, anotar (terceiros já erraram 7 vezes)

Critérios de aceite:
- Nenhum erro sem card',
        'Alta', 'CIS-DF · Simulado', 'Revisão', NULL, '2026-12-05 09:00:00',
        119, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- REV-14
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[REV-14] Dom 06/12 — Revisão leve da semana (3h) — CIS-DF e CAD', '📅 Dom 06/12 · ⏰ 08:00

Como candidato às duas provas, quero fixar o que vi na semana sem me cansar, para chegar inteiro em dezembro.

O que fazer:
- 1h: reler os cards/ANCHOR de CIS-DF da semana
- 1h: reler as anotações de CAD da semana
- 1h: refazer só as questões que errei na semana
- Olhar o quadro da próxima semana

Critérios de aceite:
- Erros da semana refeitos
- Descanso no resto do dia',
        'Media', 'Revisão semanal', 'Revisão', NULL, '2026-12-06 08:00:00',
        120, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-32
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[CIS-32] Seg 07/12 — ANCHORs de recaída + drag-and-drop', '📅 Seg 07/12 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "ANCHORs de recaída + drag-and-drop", para acertar as questões de todos os domínios (100% da prova).

O que fazer:
- Reler o material do tema
- Refazer as questões que errei nele

Critérios de aceite:
- Tema revisado

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Reta final', 'Revisão', NULL, '2026-12-07 07:00:00',
        121, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SIM-12
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SIM-12] Seg 07/12 — CIS-DF — Mini-simulado 30 questões', '📅 Seg 07/12 · ⏰ 09:00

Como candidato ao CIS-DF, quero volume de questões em condição de prova na reta final.

O que fazer:
- 30 questões cronometradas (45 min)
- Revisão dos erros

Critérios de aceite:
- Nota anotada; meta > 80%

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Simulado', 'Simulado', NULL, '2026-12-07 09:00:00',
        122, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- PRA-38
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[PRA-38] Seg 07/12 — CAD — 20 questões D5/D6', '📅 Seg 07/12 · ⏰ 11:00

Como candidato ao CAD, quero não esfriar o CAD durante a reta final do CIS-DF.

O que fazer:
- 20 questões
- Erros → anotação

Critérios de aceite:
- Nota anotada

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Media', 'CAD · Prática', 'Prática', NULL, '2026-12-07 11:00:00',
        123, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-33
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[CIS-33] Ter 08/12 — Último ajuste — os 2 domínios mais fracos (remarcar só até 08/12 11h)', '📅 Ter 08/12 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Último ajuste — os 2 domínios mais fracos (remarcar só até 08/12 11h)", para acertar as questões de todos os domínios (100% da prova).

O que fazer:
- Reler o material do tema
- Refazer as questões que errei nele

Critérios de aceite:
- Tema revisado

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Reta final', 'Revisão', NULL, '2026-12-08 07:00:00',
        124, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- SIM-13
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[SIM-13] Ter 08/12 — CIS-DF — Mini-simulado 30 questões', '📅 Ter 08/12 · ⏰ 09:00

Como candidato ao CIS-DF, quero volume de questões em condição de prova na reta final.

O que fazer:
- 30 questões cronometradas (45 min)
- Revisão dos erros

Critérios de aceite:
- Nota anotada; meta > 80%

🔁 Sempre: 10 min de CIS-DF-DRAG.html. Em toda questão: traduzir o enunciado primeiro (palavras-sinal: but · before · after · still · only · combination), depois o OBJETO, depois o verbo. Conferir gabarito na doc local.',
        'Urgente', 'CIS-DF · Simulado', 'Simulado', NULL, '2026-12-08 09:00:00',
        125, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- PRA-39
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[PRA-39] Ter 08/12 — CAD — 20 questões mistas', '📅 Ter 08/12 · ⏰ 11:00

Como candidato ao CAD, quero não esfriar o CAD durante a reta final do CIS-DF.

O que fazer:
- 20 questões
- Erros → anotação

Critérios de aceite:
- Nota anotada

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Media', 'CAD · Prática', 'Prática', NULL, '2026-12-08 11:00:00',
        126, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CIS-34
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[CIS-34] Qua 09/12 — Véspera leve — áudio, cards, logística', '📅 Qua 09/12 · ⏰ 07:00

Como candidato ao CIS-DF, quero dominar "Véspera leve — áudio, cards, logística", para acertar as questões de todos os domínios (100% da prova).

O que fazer:
- 16 min: CIS-DF-AUDIO.mp3
- Folhear CIS-DF-CARDS.pdf
- Separar documento, conferir endereço e horário (chegar 10h45)
- Dormir cedo

Critérios de aceite:
- Nenhuma matéria nova',
        'Urgente', 'CIS-DF · Reta final', 'Revisão', NULL, '2026-12-09 07:00:00',
        127, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- PROVA-01
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[PROVA-01] Qui 10/12 — 🏁 PROVA CIS-DF — 11h, UniCIT Brasília', '📅 Qui 10/12 · ⏰ 11:00

Como candidato ao CIS-DF, quero fazer a prova descansado e com método, para passar no retake.

O que fazer:
- De manhã só o CIS-DF-AUDIO.mp3
- Chegar até 10h45 com documento original com foto
- Pedir o quadro branco; drag-and-drop não pode comer o tempo das outras

Critérios de aceite:
- Prova feita e resultado anotado no CIS-DF-HANDOFF.md',
        'Urgente', 'CIS-DF · Prova', 'Prova', 'Pedido Pearson 0081-1476-5876. Endereço: SHN Quadra 02 N 87 Bloco F, salas 1620-1623 (perto do Brasília Shopping).', '2026-12-10 11:00:00',
        128, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- CAD-28
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[CAD-28] Sex 11/12 — CAD — revisão D1, D2 e D3 (60% da prova)', '📅 Sex 11/12 · ⏰ 07:00

Como candidato ao CAD, quero dominar "a revisão final", para acertar as questões de todos os domínios (100% da prova).

O que fazer:
- Reler as anotações dos domínios 1, 2 e 3
- 30 questões desses domínios

Critérios de aceite:
- Acima de 80% nos 3 domínios

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · Reta final', 'Revisão', NULL, '2026-12-11 07:00:00',
        129, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CAD-29
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[CAD-29] Sex 11/12 — CAD — revisão D4, D5 e D6', '📅 Sex 11/12 · ⏰ 09:00

Como candidato ao CAD, quero dominar "a revisão final", para acertar as questões de D4, D5 e D6 (40% da prova).

O que fazer:
- Reler anotações de D4, D5 e D6
- 30 questões desses domínios

Critérios de aceite:
- Acima de 80%

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · Reta final', 'Revisão', NULL, '2026-12-11 09:00:00',
        130, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SIM-14
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SIM-14] Sáb 12/12 — 🎯 Simulado CAD: Lucky X Exam 6, parte 1 (questões 1-62)', '📅 Sáb 12/12 · ⏰ 07:00

Como candidato ao CAD, quero medir onde estou em condição de prova, para saber onde atacar na semana.

O que fazer:
- Simulado completo, 90 min, sem consultar, celular longe
- Registrar a nota por domínio

Critérios de aceite:
- Nota anotada e comparada com a anterior',
        'Urgente', 'CAD · Simulado', 'Simulado', 'Lucky X Exam 6 tem 124 questões: hoje 1-62, cronometrado (~90 min).', '2026-12-12 07:00:00',
        131, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- REV-15
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[REV-15] Sáb 12/12 — Revisão do simulado CAD — cada erro vira card', '📅 Sáb 12/12 · ⏰ 09:00

Como candidato ao CAD, quero entender cada erro, para não repetir na prova.

O que fazer:
- Cada erro: traduzir o enunciado → por que errei (inglês? objeto? conceito?) → doc → card/anotação
- Se o gabarito estiver errado, anotar (terceiros já erraram 7 vezes)

Critérios de aceite:
- Nenhum erro sem card',
        'Alta', 'CAD · Simulado', 'Revisão', NULL, '2026-12-12 09:00:00',
        132, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SIM-15
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SIM-15] Sáb 12/12 — Refazer só as questões que errei nos Exams 1-5', '📅 Sáb 12/12 · ⏰ 11:00

Como candidato ao CAD, quero mais um volume de questões antes da prova.

O que fazer:
- 30 questões cronometradas
- Erros → anotação

Critérios de aceite:
- Nota anotada',
        'Alta', 'CAD · Simulado', 'Simulado', 'Abrir as anotações de erro e refazer só as erradas. Se errar de novo, voltar na doc/PDI.', '2026-12-12 11:00:00',
        133, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- SIM-16
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[SIM-16] Dom 13/12 — 🎯 Simulado CAD final: Lucky X Exam 6, parte 2 (questões 63-124) + revisão', '📅 Dom 13/12 · ⏰ 07:00

Como candidato ao CAD, quero um último simulado completo, para entrar na prova sabendo o meu nível.

O que fazer:
- Simulado 90 min
- Revisão de todos os erros

Critérios de aceite:
- Nota acima do simulado de 12/12',
        'Urgente', 'CAD · Simulado', 'Simulado', 'Lucky X Exam 6, questões 63-124. Se a empresa comprar o MeasureUp oficial, trocar por ele em Certification Mode.', '2026-12-13 07:00:00',
        134, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- CAD-30
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[CAD-30] Seg 14/12 — Véspera leve do CAD — reler anotações de erro', '📅 Seg 14/12 · ⏰ 07:00

Como candidato ao CAD, quero dominar "a revisão final", para acertar as questões de todos os domínios (100% da prova).

O que fazer:
- Reler todas as anotações de erro
- Conferir data, hora e local da prova

Critérios de aceite:
- Nenhuma matéria nova estudada

🔁 Sempre: praticar na PDI (nunca demo5/demo4/chaintech). Cada erro vira uma linha: o que confundi → regra certa. Conferir gabarito da Udemy na doc local.',
        'Alta', 'CAD · Reta final', 'Revisão', NULL, '2026-12-14 07:00:00',
        135, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- PROVA-02
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint9, @fila, '[PROVA-02] Ter 15/12 — 🏁 PROVA CAD (data a confirmar no agendamento)', '📅 Ter 15/12 · ⏰ 09:00

Como candidato ao CAD, quero fazer a prova com a matéria fechada, para entregar a certificação que a empresa pede.

O que fazer:
- Chegar 15 min antes, documento original com foto
- Múltipla seleção: o enunciado diz quantas — sem crédito parcial

Critérios de aceite:
- Prova feita e resultado anotado',
        'Urgente', 'CAD · Prova', 'Prova', 'Ajustar a data/hora deste card quando o CAD for agendado (14 ou 15/12).', '2026-12-15 09:00:00',
        136, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);

COMMIT;
SELECT @board AS board_criado;
