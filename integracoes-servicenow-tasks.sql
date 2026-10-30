-- ============================================================
-- Integracoes ServiceNow - board + sprints + cards
-- Gerado por integracoes-servicenow-gerar-sql.py a partir de
-- integracoes-servicenow-tasks.json. NAO edite este arquivo na mao.
-- ATENCAO: nao e idempotente. Rodar duas vezes duplica as linhas.
-- ============================================================
SET NAMES utf8mb4;
START TRANSACTION;

INSERT INTO boards (name, created_at, updated_at)
VALUES ('Integrações ServiceNow — Central Omnichannel na PDI', NOW(), NOW());
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
VALUES (@board, 'programming', 'Setup', '#D97706', 2, NOW(), NOW());
INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Projeto', '#7C3AED', 3, NOW(), NOW());
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Fundamentos', '#6B6B70', NOW(), NOW());
SET @tag1 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Inbound', '#0284C7', NOW(), NOW());
SET @tag2 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Outbound', '#0891B2', NOW(), NOW());
SET @tag3 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Segurança', '#DC2626', NOW(), NOW());
SET @tag4 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Dados', '#D97706', NOW(), NOW());
SET @tag5 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'IntegrationHub', '#7C3AED', NOW(), NOW());
SET @tag6 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'WhatsApp', '#16A34A', NOW(), NOW());
SET @tag7 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Teams', '#4F46E5', NOW(), NOW());
SET @tag8 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Instagram', '#DB2777', NOW(), NOW());
SET @tag9 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Telegram', '#0EA5E9', NOW(), NOW());
SET @tag10 := LAST_INSERT_ID();
INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, 'Projeto', '#EA580C', NOW(), NOW());
SET @tag11 := LAST_INSERT_ID();
SET @fila := (SELECT id FROM statuses WHERE board_id = @board AND name = 'Em Fila' LIMIT 1);

INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Fase 1 — Fundamentos (HTTP, Table API)', '2026-10-26', '2026-11-01', 1, NOW(), NOW());
SET @sprint1 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Fase 2 — Inbound: Scripted REST e segurança', '2026-11-02', '2026-11-08', 2, NOW(), NOW());
SET @sprint2 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Fase 3 — Outbound: REST Message e credenciais', '2026-11-09', '2026-11-15', 3, NOW(), NOW());
SET @sprint3 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Fase 4 — Dados, MID Server e webhooks', '2026-11-16', '2026-11-22', 4, NOW(), NOW());
SET @sprint4 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Fase 5 — IntegrationHub e Flow', '2026-11-23', '2026-11-29', 5, NOW(), NOW());
SET @sprint5 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Fase 6 — Canais: WhatsApp, Teams, Instagram, Telegram', '2026-11-30', '2026-12-06', 6, NOW(), NOW());
SET @sprint6 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Fase 7 — Projeto Central Omnichannel (parte 1)', '2026-12-16', '2026-12-23', 7, NOW(), NOW());
SET @sprint7 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Fase 8 — Projeto: robustez, testes e demo', '2026-12-28', '2026-12-30', 8, NOW(), NOW());
SET @sprint8 := LAST_INSERT_ID();

-- INT-01
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[INT-01] Seg 26/10 — Mapa das integrações da ServiceNow', '📅 Seg 26/10 · ⏰ 19:00

Como dev ServiceNow, quero entender todas as formas de entrar e sair dado da plataforma.

O que fazer:
- Ler inbound × outbound web services
- Listar os caminhos: Table API, Scripted REST, Import Set, REST Message, SOAP, IntegrationHub/spokes, MID Server, e-mail, eventos
- Fazer um mapa (papel ou draw.io): para cada caminho, quando usar

Critérios de aceite:
- Mapa feito e você explica quando usar cada caminho

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Fundamentos', 'Estudo', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\web-services\\inbound-web-services.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\web-services\\outbound-web-services.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\exploring-integration-hub.md', '2026-10-26 19:00:00',
        1, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- INT-02
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[INT-02] Qua 28/10 — HTTP, JSON e Postman do zero', '📅 Qua 28/10 · ⏰ 19:00

Como dev ServiceNow, quero falar a língua de qualquer API.

O que fazer:
- Verbos (GET/POST/PUT/PATCH/DELETE), status codes (200, 201, 400, 401, 403, 404, 429, 500), headers, body JSON
- Tipos de autenticação: Basic, Bearer token, API Key, OAuth 2.0
- Instalar o Postman e chamar uma API pública (ex.: https://brasilapi.com.br/api/cep/v1/01001000)

Critérios de aceite:
- Você lê uma resposta HTTP e diz o que aconteceu só pelo status e headers

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Fundamentos', 'Estudo', NULL, '2026-10-28 19:00:00',
        2, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- INT-03
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[INT-03] Sex 30/10 — Table API — CRUD na PDI pelo Postman', '📅 Sex 30/10 · ⏰ 19:00

Como dev ServiceNow, quero manipular qualquer tabela da ServiceNow de fora.

O que fazer:
- GET incident com sysparm_query, sysparm_fields, sysparm_limit, sysparm_display_value
- POST, PATCH e DELETE de um registro
- Testar com usuário SEM role e ver o 403 (ACL vale na API)

Critérios de aceite:
- Coleção do Postman ''ServiceNow PDI'' com as 4 operações funcionando

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Inbound', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-apis\\c_TableAPI.md', '2026-10-30 19:00:00',
        3, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- INT-04
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint1, @fila, '[INT-04] Dom 01/11 — REST API Explorer, Import Set API e Attachment API', '📅 Dom 01/11 · ⏰ 14:00

Como dev ServiceNow, quero conhecer as APIs prontas além da Table API.

O que fazer:
- Usar o REST API Explorer para gerar a chamada
- Import Set API: inserir em uma staging table
- Attachment API: subir um arquivo num incident

Critérios de aceite:
- 3 chamadas novas na coleção do Postman

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Media', 'Inbound', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-api-explorer\\use-REST-API-Explorer.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-apis\\c_ImportSetAPI.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-apis\\c_AttachmentAPI.md', '2026-11-01 14:00:00',
        4, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- INT-05
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[INT-05] Seg 02/11 — Scripted REST API — sua primeira API', '📅 Seg 02/11 · ⏰ 19:00

Como dev ServiceNow, quero criar endpoints próprios quando a Table API não serve.

O que fazer:
- Criar o serviço e 2 resources (GET /status e POST /mensagem)
- request.body.data, response.setStatus, response.setBody
- Chamar pelo Postman

Critérios de aceite:
- Endpoint próprio respondendo GET e POST

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Inbound', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-api-explorer\\t_CreateAScriptedRESTService.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-api-explorer\\t_CreateAScriptedRESTAPIResource.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-api-explorer\\r_ScriptedRESTServiceScriptExamples.md', '2026-11-02 19:00:00',
        5, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- INT-06
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[INT-06] Qua 04/11 — Scripted REST — versão, parâmetros e boas práticas', '📅 Qua 04/11 · ⏰ 19:00

Como dev ServiceNow, quero desenhar API como profissional.

O que fazer:
- Versionamento (v1/v2), path params e query params
- Response headers e schema
- Ler as boas práticas e aplicar no endpoint de ontem

Critérios de aceite:
- Endpoint com versão, path param e erros tratados (400/404)

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Inbound', 'Estudo', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-api-explorer\\scripted-rest-good-practices.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-api-explorer\\define-scripted-rest-api-schema.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-api-explorer\\define-scripted-api-response-header.md', '2026-11-04 19:00:00',
        6, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- INT-07
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[INT-07] Sex 06/11 — Segurança na entrada — usuário de integração, ACL por path, API Key', '📅 Sex 06/11 · ⏰ 19:00

Como dev ServiceNow, quero abrir API sem abrir a instância.

O que fazer:
- Usuário de integração com ''Web service access only''
- ACL por path no Scripted REST
- Autenticação por API Key / HMAC

Critérios de aceite:
- Endpoint aceita API Key e recusa sem ela (401)

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Inbound', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-api-explorer\\add-a-path-based-acl-for-a-scripted-rest-api.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\platform-security\\authentication\\api-key-and-hmac-rest-apis.md', '2026-11-06 19:00:00',
        7, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- INT-08
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint2, @fila, '[INT-08] Dom 08/11 — OAuth 2.0 na entrada (client credentials)', '📅 Dom 08/11 · ⏰ 14:00

Como dev ServiceNow, quero entregar a um sistema externo um acesso com token, não com senha.

O que fazer:
- Criar o OAuth Application Registry na PDI
- Pegar o token pelo Postman e chamar a Table API com Bearer
- Ver expiração e refresh

Critérios de aceite:
- Chamada com Bearer token funcionando

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Inbound', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\platform-security\\authentication\\client-credentials-grant.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-api-explorer\\t_EnableOAuthWithREST.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\rest-api-explorer\\r_RESTOAuthExample.md', '2026-11-08 14:00:00',
        8, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- INT-09
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[INT-09] Seg 09/11 — REST Message — chamar uma API externa', '📅 Seg 09/11 · ⏰ 19:00

Como dev ServiceNow, quero fazer a ServiceNow buscar e enviar dados para fora.

O que fazer:
- Criar REST Message para a BrasilAPI (CEP)
- HTTP Method com variável ${cep}
- Testar pelo botão Test

Critérios de aceite:
- REST Message retornando 200 com o JSON

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Outbound', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\web-services\\c_OutboundRESTWebService.md', '2026-11-09 19:00:00',
        9, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- INT-10
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[INT-10] Qua 11/11 — RESTMessageV2 em script — síncrono, assíncrono e erros', '📅 Qua 11/11 · ⏰ 19:00

Como dev ServiceNow, quero chamar API dentro de Business Rule / Script Include sem travar a tela.

O que fazer:
- sn_ws.RESTMessageV2: execute × executeAsync + waitForResponse
- getStatusCode, getBody, getErrorMessage, try/catch
- Business Rule que preenche cidade a partir do CEP

Critérios de aceite:
- Registro preenchido automaticamente pela API

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Outbound', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\web-services\\c_ScriptingOutboundREST.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\web-services\\r_DirectRESTMessageV2Example.md', '2026-11-11 19:00:00',
        10, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- INT-11
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[INT-11] Sex 13/11 — Autenticação de saída — Basic, OAuth 2.0 e Connection & Credential Alias', '📅 Sex 13/11 · ⏰ 19:00

Como dev ServiceNow, quero guardar credencial do jeito certo.

O que fazer:
- Basic auth profile × OAuth 2.0 profile
- Connection & Credential Alias (o padrão para spokes e flows)
- Por que token nunca vai em script

Critérios de aceite:
- Um alias criado e usado por uma chamada

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Outbound', 'Estudo', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\web-services\\c_OutboundRESTAuth.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\managing-connections-integration-hub.md', '2026-11-13 19:00:00',
        11, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- INT-12
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint3, @fila, '[INT-12] Dom 15/11 — Debug de integração — Outbound HTTP log', '📅 Dom 15/11 · ⏰ 14:00

Como dev ServiceNow, quero descobrir por que uma integração falhou.

O que fazer:
- Ligar o log de requisições de saída e ler um request/response
- Forçar erros (URL errada, 401, timeout) e ver no log

Critérios de aceite:
- Você acha a causa de 3 erros forçados só pelo log

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Media', 'Outbound', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\web-services\\outbound-request-logging.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\web-services\\outbound-logging-properties.md', '2026-11-15 14:00:00',
        12, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- INT-13
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[INT-13] Seg 16/11 — Import Set, Data Source e Transform Map (com coalesce)', '📅 Seg 16/11 · ⏰ 19:00

Como dev ServiceNow, quero carregar dados em massa sem duplicar.

O que fazer:
- Data Source de arquivo (CSV/Excel)
- Transform map com coalesce e transform script
- Rodar 2 vezes e ver que não duplica

Critérios de aceite:
- Importação idempotente

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Media', 'Dados', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\system-import-sets\\', '2026-11-16 19:00:00',
        13, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- INT-14
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[INT-14] Qua 18/11 — Data Source REST + importação agendada', '📅 Qua 18/11 · ⏰ 19:00

Como dev ServiceNow, quero puxar dados de uma API de tempos em tempos.

O que fazer:
- Data Source do tipo REST (ou script) chamando uma API pública
- Scheduled Data Import

Critérios de aceite:
- Importação rodando sozinha

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Media', 'Dados', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\system-import-sets\\', '2026-11-18 19:00:00',
        14, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- INT-15
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[INT-15] Sex 20/11 — MID Server e ECC Queue', '📅 Sex 20/11 · ⏰ 19:00

Como dev ServiceNow, quero saber quando a integração precisa entrar na rede interna do cliente.

O que fazer:
- O que é o MID Server e quando é obrigatório
- ECC Queue: como a mensagem viaja
- REST via MID

Critérios de aceite:
- Você explica a um cliente por que ele precisa (ou não) de MID

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Media', 'Fundamentos', 'Estudo', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\servicenow-platform\\mid-server\\ecc-queue-mid-server.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\web-services\\c_OutboundRESTMIDServerSupport.md', '2026-11-20 19:00:00',
        15, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag1);
-- INT-16
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint4, @fila, '[INT-16] Dom 22/11 — Webhook de entrada + processamento assíncrono (evento)', '📅 Dom 22/11 · ⏰ 14:00

Como dev ServiceNow, quero receber webhook rápido e processar depois.

O que fazer:
- Scripted REST recebe o webhook e responde 200 na hora
- gs.eventQueue() + Script Action processa o payload
- Testar com webhook.site / Postman

Critérios de aceite:
- Webhook responde em < 1s e o processamento acontece no evento

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Inbound', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\build-workflows\\system-events\\', '2026-11-22 14:00:00',
        16, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- INT-17
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[INT-17] Seg 23/11 — IntegrationHub — spokes, plugins e o que a PDI tem', '📅 Seg 23/11 · ⏰ 19:00

Como dev ServiceNow, quero saber quando usar spoke pronto e quando construir.

O que fazer:
- O que é spoke, action, connection
- Ver quais plugins de IntegrationHub a sua PDI tem (ativar pelo developer site se precisar)
- Anotar: WhatsApp/Teams nativos exigem licença

Critérios de aceite:
- Lista do que a PDI tem e do que não tem

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'IntegrationHub', 'Estudo', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\ih-plugins.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\configuring-integration-hub.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\application-development\\activating_a_pdi_plugin_from_the_developer_site.md', '2026-11-23 19:00:00',
        17, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- INT-18
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[INT-18] Qua 25/11 — Action Designer — passo REST numa action própria', '📅 Qua 25/11 · ⏰ 19:00

Como dev ServiceNow, quero criar uma action reutilizável em qualquer flow.

O que fazer:
- Action com inputs, REST step, script de parse e outputs
- Usar a action num flow

Critérios de aceite:
- Action própria chamando API e devolvendo outputs

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'IntegrationHub', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\rest-request-action-designer.md', '2026-11-25 19:00:00',
        18, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- INT-19
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[INT-19] Sex 27/11 — Data Stream (paginação) e tratamento de erro em flow', '📅 Sex 27/11 · ⏰ 19:00

Como dev ServiceNow, quero integrar listas grandes sem estourar limite.

O que fazer:
- Data Stream action com paginação
- Error handling no flow (try/catch, status)

Critérios de aceite:
- Flow lendo várias páginas e tratando falha

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Media', 'IntegrationHub', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\data-stream-actions.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\data-stream-design.md', '2026-11-27 19:00:00',
        19, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- INT-20
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint5, @fila, '[INT-20] Dom 29/11 — REST Trigger — flow disparado por chamada externa', '📅 Dom 29/11 · ⏰ 14:00

Como dev ServiceNow, quero deixar sistema externo disparar um flow direto.

O que fazer:
- Criar flow com REST trigger
- Chamar pelo Postman

Critérios de aceite:
- Flow disparado de fora

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Media', 'IntegrationHub', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\rest-trigger.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\set-up-external-webhook-endpoints.md', '2026-11-29 14:00:00',
        20, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- INT-21
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[INT-21] Seg 30/11 — WhatsApp Cloud API — conta Meta for Developers e número de teste', '📅 Seg 30/11 · ⏰ 19:00

Como dev ServiceNow, quero ter o WhatsApp pronto para conectar na PDI.

O que fazer:
- Criar conta em developers.facebook.com e um app do tipo Business
- Ativar WhatsApp, pegar o número de teste e cadastrar o seu celular
- Mandar mensagem pelo Postman (Graph API /messages)

Critérios de aceite:
- Mensagem do Postman chegou no seu WhatsApp

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'WhatsApp', 'Setup', '📚 Documentação:
- Doc oficial Meta: developers.facebook.com/docs/whatsapp/cloud-api
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\conversational-interfaces\\virtual-agent\\configure-whatsapp-cloud-api-provider-properties.md (como o produto nativo faz, para comparar)', '2026-11-30 19:00:00',
        21, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag7);
-- INT-22
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[INT-22] Qua 02/12 — Microsoft Teams — webhook de canal', '📅 Qua 02/12 · ⏰ 19:00

Como dev ServiceNow, quero ter o Teams pronto para receber alertas da PDI.

O que fazer:
- Criar um canal num Teams PESSOAL (nunca o da Chaintech)
- Criar o webhook pelo app Workflows (''post to a channel when a webhook request is received'')
- Mandar um card pelo Postman

Critérios de aceite:
- Mensagem do Postman apareceu no canal

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Teams', 'Setup', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\microsoft-teams-spoke.md
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\setup-webhook-ms-teams-graph.md
- ⚠️ Palpite: conta Teams gratuita pode não ter Workflows — se não tiver, usar Slack (slack-spoke.md) no lugar', '2026-12-02 19:00:00',
        22, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag8);
-- INT-23
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[INT-23] Sex 04/12 — Instagram — conta profissional e Messaging API', '📅 Sex 04/12 · ⏰ 19:00

Como dev ServiceNow, quero ter o Instagram pronto para receber e responder DM.

O que fazer:
- Converter um Instagram de teste para conta profissional e ligar a uma página do Facebook
- No app Meta, adicionar Instagram e testar no Graph API Explorer

Critérios de aceite:
- Token de teste funcionando no Graph API Explorer

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Media', 'Instagram', 'Setup', '📚 Documentação:
- Doc oficial Meta: developers.facebook.com/docs/instagram-platform
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\facebook-spoke.md
- ⚠️ App em modo desenvolvimento só fala com contas cadastradas como testers', '2026-12-04 19:00:00',
        23, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag9);
-- INT-24
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint6, @fila, '[INT-24] Dom 06/12 — Telegram bot + desenho da arquitetura do sistema', '📅 Dom 06/12 · ⏰ 14:00

Como dev ServiceNow, quero ter um canal fácil de testar e o desenho do sistema antes de construir.

O que fazer:
- Criar bot no @BotFather e testar sendMessage pelo Postman
- Desenhar a Central Omnichannel: canais → webhook (Scripted REST) → evento → tabelas → Teams; e a volta: UI Action → Script Include → REST Message

Critérios de aceite:
- Diagrama pronto

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Media', 'Telegram', 'Setup', '📚 Documentação:
- core.telegram.org/bots/api', '2026-12-06 14:00:00',
        24, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag10);
-- INT-25
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-25] Qua 16/12 — Criar o app scoped ''Central Omnichannel'' e ligar ao GitHub desde o dia 1', '📅 Qua 16/12 · ⏰ 07:00

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- App scoped na PDI
- Tabelas: Contato, Conversa, Mensagem (canal, direção, status, payload)
- Linkar o app ao Git (backup: a PDI pode ser recolhida se ficar parada)

Critérios de aceite:
- App criado com as 3 tabelas e 1º commit no GitHub

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Projeto', 'Setup', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\application-development\\', '2026-12-16 07:00:00',
        25, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag11);
-- INT-26
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-26] Qua 16/12 — Credenciais e propriedades por canal', '📅 Qua 16/12 · ⏰ 08:45

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Connection & Credential Alias para WhatsApp, Telegram, Instagram e Teams
- System properties do app (ex.: verify token, ids)

Critérios de aceite:
- Nenhum token em script

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Projeto', 'Projeto', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\managing-connections-integration-hub.md', '2026-12-16 08:45:00',
        26, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag11);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- INT-27
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-27] Qua 16/12 — Script Include OmniSender — uma porta de saída para todos os canais', '📅 Qua 16/12 · ⏰ 10:30

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Método enviar(conversa, texto) que escolhe o canal
- Grava a Mensagem de saída com status

Critérios de aceite:
- Interface única pronta (canais entram nos próximos dias)

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Projeto', 'Projeto', NULL, '2026-12-16 10:30:00',
        27, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag11);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- INT-28
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-28] Qui 17/12 — WhatsApp — saída (texto e template)', '📅 Qui 17/12 · ⏰ 07:00

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- REST Message para a Graph API /messages
- OmniSender.whatsapp()

Critérios de aceite:
- Mensagem enviada da PDI chega no celular

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'WhatsApp', 'Projeto', NULL, '2026-12-17 07:00:00',
        28, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag7);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- INT-29
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-29] Qui 17/12 — WhatsApp — entrada: webhook na PDI', '📅 Qui 17/12 · ⏰ 08:45

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Scripted REST: GET de verificação (hub.challenge) e POST de mensagens
- Cadastrar a URL da PDI no app Meta

Critérios de aceite:
- Mensagem do celular vira registro na PDI

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'WhatsApp', 'Projeto', NULL, '2026-12-17 08:45:00',
        29, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag7);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- INT-30
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-30] Qui 17/12 — WhatsApp ida e volta + leitura do Outbound HTTP log', '📅 Qui 17/12 · ⏰ 10:30

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Conversa completa
- Ler o log de saída e o de entrada

Critérios de aceite:
- Conversa de 5 mensagens registrada certinha

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'WhatsApp', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\api-reference\\web-services\\outbound-request-logging.md', '2026-12-17 10:30:00',
        30, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag7);
-- INT-31
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-31] Sex 18/12 — Validar a assinatura do webhook (X-Hub-Signature-256)', '📅 Sex 18/12 · ⏰ 07:00

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Calcular HMAC SHA-256 do corpo com o app secret e comparar
- Recusar com 401 se não bater

Critérios de aceite:
- Chamada falsa pelo Postman é recusada

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Segurança', 'Projeto', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\platform-security\\authentication\\api-key-and-hmac-rest-apis.md', '2026-12-18 07:00:00',
        31, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- INT-32
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-32] Sex 18/12 — Processamento assíncrono — evento + Script Action', '📅 Sex 18/12 · ⏰ 08:45

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Webhook só grava o payload e dispara evento
- Script Action cria Contato/Conversa/Mensagem

Critérios de aceite:
- Webhook responde rápido mesmo com processamento pesado

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Inbound', 'Projeto', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\build-workflows\\system-events\\', '2026-12-18 08:45:00',
        32, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- INT-33
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-33] Sex 18/12 — Telegram — entrada e saída reaproveitando o padrão', '📅 Sex 18/12 · ⏰ 10:30

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- setWebhook apontando para a PDI
- OmniSender.telegram()

Critérios de aceite:
- Telegram funcionando igual ao WhatsApp

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Telegram', 'Projeto', NULL, '2026-12-18 10:30:00',
        33, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag10);
-- INT-34
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-34] Seg 21/12 — Teams — alerta de mensagem nova', '📅 Seg 21/12 · ⏰ 07:00

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Flow: Mensagem de entrada criada → action própria (REST) → card no canal

Critérios de aceite:
- Alerta chega no Teams com link do registro

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Teams', 'Projeto', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\integration-hub\\rest-request-action-designer.md', '2026-12-21 07:00:00',
        34, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag8);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- INT-35
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-35] Seg 21/12 — Teams — card com dados da conversa e botão para abrir na PDI', '📅 Seg 21/12 · ⏰ 08:45

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Adaptive Card com canal, contato e última mensagem

Critérios de aceite:
- Card bonito e clicável

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Teams', 'Projeto', NULL, '2026-12-21 08:45:00',
        35, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag8);
-- INT-36
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-36] Seg 21/12 — Regra de ''sem resposta em 15 min'' → Teams', '📅 Seg 21/12 · ⏰ 10:30

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Flow agendado ou SLA simples
- Alerta no Teams

Critérios de aceite:
- Alerta disparando na hora certa

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'IntegrationHub', 'Projeto', NULL, '2026-12-21 10:30:00',
        36, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag6);
-- INT-37
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-37] Ter 22/12 — Instagram — entrada pelo mesmo webhook (roteado por ''object'')', '📅 Ter 22/12 · ⏰ 07:00

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Assinar o webhook de mensagens do Instagram no app Meta
- Rotear no Scripted REST: whatsapp_business_account × instagram

Critérios de aceite:
- DM do Instagram vira registro

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Instagram', 'Projeto', NULL, '2026-12-22 07:00:00',
        37, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag9);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag2);
-- INT-38
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-38] Ter 22/12 — Instagram — resposta pela PDI', '📅 Ter 22/12 · ⏰ 08:45

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- OmniSender.instagram()

Critérios de aceite:
- Resposta chega na DM

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Instagram', 'Projeto', NULL, '2026-12-22 08:45:00',
        38, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag9);
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- INT-39
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-39] Ter 22/12 — Tela do atendente — UI Action ''Responder''', '📅 Ter 22/12 · ⏰ 10:30

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- UI Action na Conversa abre campo e chama OmniSender
- Lista de conversas abertas por canal

Critérios de aceite:
- Atendente responde qualquer canal da mesma tela

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Projeto', 'Projeto', NULL, '2026-12-22 10:30:00',
        39, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag11);
-- INT-40
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-40] Qua 23/12 — Widget de timeline da conversa no Service Portal', '📅 Qua 23/12 · ⏰ 07:00

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Widget mostrando as mensagens em balões por direção

Critérios de aceite:
- Timeline funcionando

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Projeto', 'Projeto', NULL, '2026-12-23 07:00:00',
        40, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag11);
-- INT-41
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-41] Qua 23/12 — Importar contatos de planilha', '📅 Qua 23/12 · ⏰ 08:45

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Import Set + transform + coalesce pelo telefone

Critérios de aceite:
- Contatos importados sem duplicar

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Dados', 'Projeto', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\integrate-applications\\system-import-sets\\', '2026-12-23 08:45:00',
        41, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag5);
-- INT-42
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint7, @fila, '[INT-42] Qua 23/12 — Enriquecer contato com API pública (CEP → endereço)', '📅 Qua 23/12 · ⏰ 10:30

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Action de IntegrationHub reaproveitada

Critérios de aceite:
- Contato enriquecido automaticamente

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Outbound', 'Projeto', NULL, '2026-12-23 10:30:00',
        42, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag3);
-- INT-43
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[INT-43] Seg 28/12 — Falha e reenvio — status da mensagem + scheduled job de retry', '📅 Seg 28/12 · ⏰ 07:00

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Status: enviada / falhou / reenviada
- Scheduled job reenvia falhas com limite de tentativas

Critérios de aceite:
- Falha forçada é reenviada sozinha

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Projeto', 'Projeto', NULL, '2026-12-28 07:00:00',
        43, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag11);
-- INT-44
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[INT-44] Seg 28/12 — Observabilidade — log do app', '📅 Seg 28/12 · ⏰ 08:45

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Tabela de log ou gs.error com prefixo do app
- Painel simples de mensagens por canal/status

Critérios de aceite:
- Você acha qualquer erro em 1 minuto

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Projeto', 'Projeto', NULL, '2026-12-28 08:45:00',
        44, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag11);
-- INT-45
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[INT-45] Seg 28/12 — Roles e ACLs do app (atendente × admin)', '📅 Seg 28/12 · ⏰ 10:30

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Role atendente: lê e responde
- Role admin: vê credenciais/propriedades

Critérios de aceite:
- Atendente não vê configuração

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Segurança', 'Projeto', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\platform-security\\access-control\\', '2026-12-28 10:30:00',
        45, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag4);
-- INT-46
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[INT-46] Ter 29/12 — Testes automatizados (ATF) dos fluxos principais', '📅 Ter 29/12 · ⏰ 07:00

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- ATF: criar mensagem de entrada e verificar conversa
- ATF: UI Action responder

Critérios de aceite:
- Suite ATF passando

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Projeto', 'Prática', '📚 Documentação:
- Desktop\\ServiceNow - Doc\\ServiceNowDocs\\ServiceNowDocs\\markdown\\application-development\\automated-test-framework-atf\\', '2026-12-29 07:00:00',
        46, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag11);
-- INT-47
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[INT-47] Ter 29/12 — Commit final no Git + documentação do app (README)', '📅 Ter 29/12 · ⏰ 08:45

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- README: arquitetura, como configurar cada canal, como testar

Critérios de aceite:
- Repositório com README completo

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Projeto', 'Projeto', NULL, '2026-12-29 08:45:00',
        47, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag11);
-- INT-48
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[INT-48] Ter 29/12 — Revisão de segurança final', '📅 Ter 29/12 · ⏰ 10:30

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Procurar token em script/nota/commit
- Rodar com usuário sem role

Critérios de aceite:
- Nenhum segredo exposto

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Projeto', 'Projeto', NULL, '2026-12-29 10:30:00',
        48, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag11);
-- INT-49
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[INT-49] Qua 30/12 — 🏁 Demo ponta a ponta', '📅 Qua 30/12 · ⏰ 07:00

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- WhatsApp → PDI → Teams → atendente responde → chega no WhatsApp
- Repetir com Instagram e Telegram

Critérios de aceite:
- Os 3 canais funcionando de ponta a ponta

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Projeto', 'Projeto', NULL, '2026-12-30 07:00:00',
        49, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag11);
-- INT-50
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[INT-50] Qua 30/12 — Retrospectiva — o que domino × o que falta', '📅 Qua 30/12 · ⏰ 08:45

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Para cada card do quadro: domino / mais ou menos / não
- Plano de janeiro (SOAP, MID na prática, spokes licenciados)

Critérios de aceite:
- Plano de janeiro escrito

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Projeto', 'Estudo', NULL, '2026-12-30 08:45:00',
        50, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag11);
-- INT-51
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,
                   notes, scheduled_at, sort_order, created_at, updated_at)
VALUES (@board, 'programming', @sprint8, @fila, '[INT-51] Qua 30/12 — (Opcional) Gravar vídeo em PT para o canal', '📅 Qua 30/12 · ⏰ 10:30

Como dev ServiceNow, quero evoluir a Central Omnichannel na PDI.

O que fazer:
- Só PDI e contas pessoais; esconder tokens e números

Critérios de aceite:
- Vídeo gravado sem nenhum dado sensível

🔒 Regras: tudo na sua PDI e em contas pessoais — nunca demo5/demo4/chaintech nem o Teams da Chaintech. Token/senha NUNCA em script, nota ou print: só em Credentials / Connection & Credential Alias.',
        'Alta', 'Projeto', 'Projeto', NULL, '2026-12-30 10:30:00',
        51, NOW(), NOW());
SET @t := LAST_INSERT_ID();
INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, 1, NOW(), NOW());
INSERT INTO task_tag (task_id, tag_id) VALUES (@t, @tag11);

COMMIT;
SELECT @board AS board_criado;
