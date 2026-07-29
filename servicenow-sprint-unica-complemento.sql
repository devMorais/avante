-- ============================================================
-- Complemento da Sprint única (id 152) — adiciona só o que FALTA:
-- Onboarding SPM, teoria CIS-DF (Now Create/Platform/CMDB/CSDM),
-- os 2 gaps reais de scripting não cobertos pelas 20 tasks originais
-- (GlideAjax prático + UI Actions na dev instance), simulados,
-- revisão final + checklist da prova, e fechamento pós-prova.
-- Não duplica Business Rules/Script Includes/Client Scripts/ACLs/
-- Flow Designer/Catalog/Email/SLA — isso já está nas 20 tasks originais.
-- ============================================================

INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'CIS-DF', '#7C3AED', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'Onboarding', '#D97706', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'Simulado CIS-DF', '#DC2626', NOW(), NOW() FROM boards WHERE id = 4;

-- 21) Onboarding SPM
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 📚 Concluir SPM Fundamentals (ServiceNow University) — onboarding Chaintech
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 Cole na IA:
--------------------------------------------------------------
Aja como instrutor de SPM. Sou o Fernando. Diga: "Acesse learning.servicenow.com, curso SPM Fundamentals On Demand (Zurich), continue de onde parou." Pergunte se estou pronto. (ESPERE)
Vá módulo por módulo (Introduction, Demand, Project, Resource, Portfolio Management), 1 pergunta prática por módulo. (ESPERE cada resposta)
Corrija e confirme para eu marcar como concluído no onboarding do Portal Labs e aqui.
--------------------------------------------------------------',
'Alta', 'Onboarding', 'Tarefa', 21, NOW(), NOW());

-- 22) Now Create Methodology
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 📚 CIS-DF: Now Create Methodology — as 6 fases
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 Cole na IA:
--------------------------------------------------------------
Arquiteto ServiceNow. Sou Fernando. Explique as 6 fases (Prepare, Envision, Architect, Build, Test, Deploy). Peça que eu liste o que acontece em "Envision". (ESPERE) Corrija e feche.
--------------------------------------------------------------',
'Alta', 'CIS-DF', 'Tarefa', 22, NOW(), NOW());

-- 23) Platform Implementation
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 📚 CIS-DF: Update Sets, Domain Separation e Application Scope
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 Cole na IA:
--------------------------------------------------------------
Professor de plataforma. Sou Fernando. Explique o que um Update Set captura/não captura (dados), Domain Separation e scoped vs global app. Pegadinha sobre mover incidentes via Update Set. (ESPERE) Corrija e feche.
--------------------------------------------------------------',
'Média', 'CIS-DF', 'Tarefa', 23, NOW(), NOW());

-- 24) CMDB Architecture
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 📚 CIS-DF: CMDB — Classes, cmdb_ci, cmdb_rel_ci e CI Class Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 Cole na IA:
--------------------------------------------------------------
Professor de CMDB. Sou Fernando. Explique cmdb_ci, hierarquia de classes, diferença para cmdb_rel_ci (relacionamentos) e como o CI Class Manager cria novas classes. (ESPERE) Corrija e feche.
--------------------------------------------------------------',
'Urgente', 'CIS-DF', 'Tarefa', 24, NOW(), NOW());

-- 25) CMDB Health & IRE
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 📚 CIS-DF: CMDB Health — Completeness, Compliance, Correctness + IRE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 Cole na IA:
--------------------------------------------------------------
Mestre em CMDB. Sou Fernando. Ensine os 3 pilares e a diferença entre Identification Rules e Reconciliation Rules no IRE. Cenário de IP duplicado para eu resolver. (ESPERE) Feche a aula.
--------------------------------------------------------------',
'Urgente', 'CIS-DF', 'Tarefa', 25, NOW(), NOW());

-- 26) CSDM
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 📚 CIS-DF: CSDM — as 4 camadas e Service Mapping
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 Cole na IA:
--------------------------------------------------------------
Professor CSDM. Sou Fernando. Explique as 4 camadas (Foundation, Design, Sell/Consume, Support/Operate) e como o Service Mapping descobre Application Services a partir dos CIs técnicos. Peça para eu montar a cadeia Business Service → Application Service → Technical Service para um e-commerce. (ESPERE) Avalie e feche.
--------------------------------------------------------------',
'Urgente', 'CIS-DF', 'Tarefa', 26, NOW(), NOW());

-- 27) GAP real de scripting #1: GlideAjax prático
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 📚 [PRÁTICA] GlideAjax de ponta a ponta na dev instance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 Complementa a teoria de Script Includes/GlideAjax já estudada (Dia 3) com a mão na massa.
🤖 Cole na IA:
--------------------------------------------------------------
Instrutor GlideAjax. Sou Fernando, já sei a teoria (Script Include classful + AbstractAjaxProcessor). Quero praticar de verdade.
PASSO 1: Me guie a criar um Script Include "CmdbUtils" com getCiCount() que conta registros em cmdb_ci.
PASSO 2: Me guie a criar um Client Script onLoad que chama via GlideAjax e mostra o total num g_form.addInfoMessage.
PASSO 3: Teste na minha dev instance e cole o resultado. (ESPERE) Corrija e feche.
--------------------------------------------------------------',
'Alta', 'CIS-DF', 'Tarefa', 27, NOW(), NOW());

-- 28) GAP real de scripting #2: UI Actions práticas
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 📚 [PRÁTICA] UI Action condicional na dev instance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 Cole na IA:
--------------------------------------------------------------
Instrutor UI Actions. Sou Fernando. Explique Condition, Form button, Client, OnClick vs Action name. Me guie a criar uma UI Action "Escalar" visível só se priority=Crítica e role=itil_admin, que muda o assignment_group ao clicar. Testar na dev instance. (ESPERE confirmação) Corrija e feche.
--------------------------------------------------------------',
'Alta', 'CIS-DF', 'Tarefa', 28, NOW(), NOW());

-- 29) Simulado 1
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 📚 Udemy CIS-DF — Simulado 1 (75 questões, modo exame, meta 75%+)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 Cole na IA:
--------------------------------------------------------------
Tutor de simulados. Sou Fernando. Faça o Simulado 1 (Udemy CIS-DF 2026) em modo exame. (ESPERE eu terminar) Peça os erros colados e explique a alternativa certa de cada um, ligando ao conceito (CMDB/CSDM/IRE/Now Create). Registre a nota.
--------------------------------------------------------------',
'Alta', 'Simulado CIS-DF', 'Tarefa', 29, NOW(), NOW());

-- 30) Simulados 2 e 3
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 📚 Udemy CIS-DF — Simulados 2 e 3 (75 + 55 questões)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 Cole na IA:
--------------------------------------------------------------
Tutor de simulados. Sou Fernando. Simulado 2 em modo exame, corrigir erros, depois Simulado 3. Compare os 3 simulados: algum tema se repete errado? Aponte como lacuna prioritária. Meta 80%+.
--------------------------------------------------------------',
'Alta', 'Simulado CIS-DF', 'Tarefa', 30, NOW(), NOW());

-- 31) Sabatina final cruzada
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 📚 Sabatina final cruzada (CMDB + CSDM + IRE + Now Create)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 Cole na IA:
--------------------------------------------------------------
Consultor ServiceNow, reta final. Sou Fernando, prova dia 10/09 às 15h. Monte um Cheat Sheet de 1 página cruzando CMDB/CSDM/IRE/Now Create. Depois 6 perguntas cenário cruzando 2+ temas cada. (ESPERE cada resposta) Corrija e feche com feedback motivacional.
--------------------------------------------------------------',
'Urgente', 'CIS-DF', 'Tarefa', 31, NOW(), NOW());

-- 32) Checklist do dia da prova
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 🎯 CHECKLIST DO DIA DA PROVA — Quinta 10/09/2026, 15h
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 CIS-DF (CMDB e CSDM) — Inglês | Pedido 0080-1000-3539 | Registro 538913620
📍 UNICIT Educação Corporativa, SHN Quadra 2 Bloco F, salas 1620-1623, Brasília (próx. Brasília Shopping, de frente ao hotel Kubitschek)
⏱️ 90 minutos

[ ] Documento oficial com foto, válido, mesmo nome do cadastro
[ ] Chegar 14h45 (15 min antes) — atraso >15min pode perder a vaga
[ ] Sem celular/bolsa/relógio/carteira na sala
[ ] Revisar o Cheat Sheet 30 min antes, sem estudar conteúdo novo',
'Urgente', 'CIS-DF', 'Tarefa', 32, NOW(), NOW());

-- 33) Projeto prático final (pós-prova)
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 📚 [PROJETO PÓS-PROVA] App scoped completa do zero: Gestão de Empréstimo de Equipamentos
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 Sem prompt de IA — construa sozinho, IA só revisa no final. Objetivo: provar que domina tudo estudado (GlideRecord, BR, Script Include, Client Script, ACL, Flow Designer) num projeto único e real.
1. Scoped app própria
2. Tabelas Equipamento + Empréstimo
3. BR: status muda ao criar/devolver
4. Client Script: campo condicional via GlideAjax
5. UI Action "Registrar Devolução"
6. ACL: só grupo "Patrimônio" deleta
7. Flow Designer: notifica 1 dia antes da devolução

🤖 Ao terminar, cole na IA: "Aja como revisor técnico sênior ServiceNow. Vou descrever minha app (tabelas, BR, client script, UI action, ACL, flow). Aponte falhas de arquitetura/segurança/performance." (cole sua descrição)',
'Urgente', 'CIS-DF', 'História', 33, NOW(), NOW());

-- 34) Simulado de entrevista nível pleno (rodada 2, pós-prova)
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (4, 152, 13,
'👤 Fernando Morais | 📚 Simulado de Entrevista Técnica Nível Pleno (rodada 2, pós-certificação)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 Cole na IA:
--------------------------------------------------------------
Entrevistador técnico sênior contratando Dev Pleno ServiceNow. Sou Fernando, já tenho CIS-DF e terminei o projeto de Gestão de Equipamentos. Faça 10 perguntas (GlideRecord/GlideAjax, BR, Script Includes, ACLs, Flow Designer, 1 de arquitetura). 2 min por resposta. (ESPERE cada uma) Diga nível júnior/pleno/sênior de cada resposta e o que falta. Veredito final: pronto para vaga pleno?
--------------------------------------------------------------',
'Alta', 'Simulado CIS-DF', 'Tarefa', 34, NOW(), NOW());
