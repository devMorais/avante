-- ============================================================
-- Board 4 "ServiceNow - Entrevista Técnica Fernando Estudar"
-- Plano completo pós-entrevista: Onboarding SPM (Chaintech) +
-- Certificação CIS-DF (prova real: 10/09/2026, 15h, Pearson VUE,
-- UNICIT Brasília — já agendada, número do pedido 0080-1000-3539)
-- + Scripting Avançado (pós-prova, curso Udemy 91 aulas/77h,
-- cortado ao essencial).
-- Sprints numeradas a partir da 7 (Dias 1-6 já existentes = entrevista,
-- já realizada e concluída).
-- ============================================================

-- ============================================================
-- PARTE 1 — SPRINTS (14 sprints CIS-DF/onboard + 6 sprints scripting)
-- ============================================================
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 7 — Onboard SPM & Kickoff CIS-DF', '2026-07-29', '2026-08-03', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 8 — Now Create Methodology', '2026-08-04', '2026-08-08', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 9 — Platform Implementation', '2026-08-09', '2026-08-13', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 10 — CMDB Architecture', '2026-08-14', '2026-08-19', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 11 — CMDB Health & IRE', '2026-08-20', '2026-08-25', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 12 — CSDM Framework Layers', '2026-08-26', '2026-08-31', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 13 — Simulados de Fixação', '2026-09-01', '2026-09-06', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 14 — Prova CIS-DF (10/09)', '2026-09-07', '2026-09-10', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 15 — Scripting: JS Essencial p/ ServiceNow', '2026-09-11', '2026-09-17', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 16 — Client-Side (Client Scripts, UI Policy, GlideForm)', '2026-09-18', '2026-09-24', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 17 — Server-Side (GlideRecord, GlideAjax, Script Includes)', '2026-09-25', '2026-10-01', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 18 — Business Rules & Automação', '2026-10-02', '2026-10-08', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 19 — ACLs, UI Actions & Flow Designer', '2026-10-09', '2026-10-15', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 20 — Projeto Prático Final', '2026-10-16', '2026-10-22', NOW(), NOW() FROM boards WHERE id = 4;

-- ============================================================
-- PARTE 2 — TAGS NOVAS (as existentes eram do Dia 1, específicas de GlideRecord)
-- ============================================================
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'CIS-DF', '#7C3AED', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'CMDB', '#0284C7', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'CSDM', '#059669', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'Onboarding Chaintech', '#D97706', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'Simulado', '#DC2626', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'Client-Side', '#0891B2', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'Server-Side', '#DB2777', NOW(), NOW() FROM boards WHERE id = 4;
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'Flow Designer', '#4F46E5', NOW(), NOW() FROM boards WHERE id = 4;

-- ============================================================
-- PARTE 3 — META (contexto vivo do plano, fixado na Sprint 7)
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, notes, priority, epic, type, sort_order, created_at, updated_at)
SELECT
  4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 7 — Onboard SPM & Kickoff CIS-DF'),
  13,
  '[META] Contexto do plano — de zero a fera em ServiceNow

🎯 OBJETIVO: dominar ServiceNow na prática (não só passar em prova), construindo base sólida antes de pegar demandas reais na Chaintech.

📅 CRONOGRAMA (hoje: 29/07/2026)
1) Sprints 7-14 (29/07 → 10/09): Certificação CIS-DF. PRIORIDADE MÁXIMA — prova real agendada, Pearson VUE, quinta 10/09/2026 às 15h, UNICIT Educação Corporativa (SHN Quadra 2, Bloco F, Brasília), pedido 0080-1000-3539. Chegar 15 min antes, levar documento oficial com foto.
2) Dentro da Sprint 7: concluir também o SPM Fundamentals (ServiceNow University) pendente do onboarding Chaintech — curso curto (~9h), cabe em paralelo sem atrapalhar o CIS-DF.
3) Sprints 15-20 (11/09 → 22/10): Scripting Avançado. Só depois da prova, sem pressa. Baseado no curso Udemy "Scripting and Advanced Development in the ServiceNow" (91 aulas/77h) — cortado ao essencial de verdade para dev pleno: NÃO vamos assistir o curso inteiro aula por aula, e sim os tópicos que geram valor real (client/server architecture, GlideRecord, Business Rules, Script Includes, ACLs, Flow Designer). Partes de menor retorno (UI Macros aprofundado, Import Sets extensos, Catalog Items em 5 partes) ficam resumidas em 1 sessão prática cada, não em aula-a-aula.

📖 MÉTODO (igual ao que já funcionou nos Dias 1-6 da entrevista)
Cada tarefa é um prompt para colar numa IA agindo como instrutor — ela pergunta, você responde, ela corrige. Sempre termine confirmando o fechamento da tarefa aqui no Avante.

🏆 META FINAL: não é só passar no CIS-DF — é sair desse plano sabendo resolver cenário real de client script + business rule + script include + ACL sem precisar consultar nada, para chegar em qualquer demanda da Chaintech com base sólida.',
  'Ver descrição da tarefa correspondente para o prompt de estudo de cada sprint. Regra geral: 1 sessão de estudo = 1 tarefa fechada aqui.',
  'Urgente',
  'Meta: Documentação Viva',
  'Tarefa',
  0,
  NOW(), NOW();

-- ============================================================
-- PARTE 4 — SPRINT 7: Onboard SPM & Kickoff CIS-DF
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 7 — Onboard SPM & Kickoff CIS-DF'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 7: Onboard SPM & Kickoff CIS-DF
📚 TAREFA: Concluir SPM Fundamentals On Demand (Zurich) — Onboarding Chaintech
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Aja como meu instrutor de Strategic Portfolio Management (SPM). Sou o Fernando, terminando o onboarding da Chaintech.
PASSO 1: ACESSO
Diga: "Acesse learning.servicenow.com, curso SPM Fundamentals On Demand (Zurich), e continue de onde parou." Pergunte se estou pronto. (ESPERE)
PASSO 2: REVISÃO POR MÓDULO
Vá módulo por módulo (Introduction to SPM, Innovation and Demand Management, Project Management, Resource Management, Portfolio Management). Depois de cada um, faça 1 pergunta prática sobre o que foi coberto (ex: diferença entre Demand e Project, papel do Resource Management Workspace). (ESPERE cada resposta)
PASSO 3: FECHAMENTO
Corrija minhas respostas e confirme que posso marcar "SPM Fundamentals" como concluído no onboarding do Portal Labs (chainlabs?id=onboarding) e nesta task do Avante.
--------------------------------------------------------------',
  'Alta', 'Onboarding Chaintech', 'Tarefa', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 7 — Onboard SPM & Kickoff CIS-DF'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 7: Onboard SPM & Kickoff CIS-DF
📚 TAREFA: Arquitetura, Listas e Formulários (Revisão CIS-DF)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Aja como meu instrutor oficial ServiceNow, focado em CIS-DF. Sou o Fernando.
PASSO 1: ACESSO
Diga: "Acesse a ServiceNow Learning e abra o módulo Welcome to ServiceNow / Platform Basics." Pergunte se estou pronto. (ESPERE)
PASSO 2: REVISÃO
Após eu confirmar, explique a arquitetura multi-instância, a diferença entre tabela base e tabela estendida, e faça 2 perguntas nível CIS-DF sobre sys_user e herança de tabelas. (ESPERE)
PASSO 3: CONCLUSÃO
Corrija-me e peça para fechar a tarefa no Avante.
--------------------------------------------------------------',
  'Alta', 'CIS-DF', 'Tarefa', 2, NOW(), NOW();

-- ============================================================
-- PARTE 5 — SPRINT 8: Now Create Methodology
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 8 — Now Create Methodology'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 8: Now Create Methodology
📚 TAREFA: As 6 Fases da Implementação
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Aja como arquiteto ServiceNow. Sou o Fernando.
PASSO 1: ACESSO
Diga: "Abra o curso Now Create Methodology na ServiceNow Learning." Pergunte se comecei. (ESPERE)
PASSO 2: FASES
Explique as 6 fases em ordem (Prepare, Envision, Architect, Build, Test, Deploy). Peça para eu listar o que acontece na fase "Envision" e qual artefato ela produz. (ESPERE)
PASSO 3: FEEDBACK
Avalie minha resposta e finalize a aula.
--------------------------------------------------------------',
  'Alta', 'CIS-DF', 'Tarefa', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 8 — Now Create Methodology'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 8: Now Create Methodology
📚 TAREFA: Papéis e Governança do Projeto
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Aja como PM de implementação ServiceNow. Sou o Fernando.
PASSO 1: PAPÉIS
Explique os papéis-chave (Business Process Owner, Solution Architect, Technical Consultant) e quem aprova o quê em cada fase. (ESPERE)
PASSO 2: CENÁRIO
Me dê um cenário de projeto atrasado na fase Build e peça para eu identificar qual papel deveria ter escalado o risco antes. (ESPERE)
PASSO 3: FECHAMENTO
Corrija e feche a aula.
--------------------------------------------------------------',
  'Média', 'CIS-DF', 'Tarefa', 2, NOW(), NOW();

-- ============================================================
-- PARTE 6 — SPRINT 9: Platform Implementation
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 9 — Platform Implementation'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 9: Platform Implementation
📚 TAREFA: Update Sets e Ambientes
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Professor, vamos falar de Platform Implementation. Sou Fernando.
PASSO 1: ACESSO
Curso Platform Implementation na ServiceNow Learning. Pergunte se estou logado. (ESPERE)
PASSO 2: UPDATE SETS
Explique o que um Update Set captura e o que ele NÃO captura (dados de tabela). Faça uma pergunta pegadinha sobre mover registros de incidentes via Update Set. (ESPERE)
PASSO 3: CONCLUSÃO
Valide minha resposta e feche a aula.
--------------------------------------------------------------',
  'Média', 'CIS-DF', 'Tarefa', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 9 — Platform Implementation'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 9: Platform Implementation
📚 TAREFA: Domain Separation e Application Scope
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Professor de plataforma, sou Fernando.
PASSO 1: CONCEITOS
Explique Domain Separation (para que serve, quando usar) e Application Scope (global vs scoped app, por que scoped é boa prática). (ESPERE)
PASSO 2: CENÁRIO
Dê um cenário de duas empresas na mesma instância e peça para eu explicar como Domain Separation resolveria isso. (ESPERE)
PASSO 3: CONCLUSÃO
Corrija e feche.
--------------------------------------------------------------',
  'Média', 'CIS-DF', 'Tarefa', 2, NOW(), NOW();

-- ============================================================
-- PARTE 7 — SPRINT 10: CMDB Architecture
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 10 — CMDB Architecture'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 10: CMDB Architecture
📚 TAREFA: Classes e Relacionamentos
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Professor, entramos na CMDB. Sou Fernando.
PASSO 1: ACESSO
Acessar CMDB Fundamentals na ServiceNow Learning. Pergunte se iniciei. (ESPERE)
PASSO 2: CIs
Explique a tabela base cmdb_ci e como a hierarquia de classes funciona. Peça para eu explicar a diferença entre a tabela de CI e a de relacionamentos (cmdb_rel_ci). (ESPERE)
PASSO 3: CONCLUSÃO
Corrija e finalize.
--------------------------------------------------------------',
  'Urgente', 'CMDB', 'Tarefa', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 10 — CMDB Architecture'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 10: CMDB Architecture
📚 TAREFA: CI Class Manager e CMDB Baselines
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Professor de CMDB, sou Fernando.
PASSO 1: CLASS MANAGER
Explique para que serve o CI Class Manager e como criar uma nova classe de CI estendendo cmdb_ci. (ESPERE)
PASSO 2: BASELINE
Explique o que é uma CMDB Baseline e quando usá-la para detectar mudanças não autorizadas. (ESPERE)
PASSO 3: FECHAMENTO
Corrija e feche a aula.
--------------------------------------------------------------',
  'Urgente', 'CMDB', 'Tarefa', 2, NOW(), NOW();

-- ============================================================
-- PARTE 8 — SPRINT 11: CMDB Health & IRE
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 11 — CMDB Health & IRE'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 11: CMDB Health & IRE
📚 TAREFA: Os 3 Pilares e Motor de Identificação
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Mestre em CMDB, me guie. Fernando aqui.
PASSO 1: ACESSO
Curso: CMDB Health na ServiceNow Learning. (ESPERE)
PASSO 2: PILARES E IRE
Ensine Completeness, Compliance e Correctness. Depois explique a diferença entre Identification Rules e Reconciliation Rules no IRE. Me dê um cenário de IP duplicado para eu resolver. (ESPERE)
PASSO 3: CONCLUSÃO
Feche a aula e mande atualizar o Avante.
--------------------------------------------------------------',
  'Urgente', 'CMDB', 'Tarefa', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 11 — CMDB Health & IRE'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 11: CMDB Health & IRE
📚 TAREFA: Reconciliation e Data Sources Precedence
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Professor de CMDB, sou Fernando.
PASSO 1: PRECEDÊNCIA
Explique como funciona a precedência de fontes de dados (Discovery vs import manual vs integração) na reconciliação de um CI. (ESPERE)
PASSO 2: CENÁRIO
Dê um cenário de conflito entre duas fontes de dados sobre o mesmo CI e peça para eu explicar qual vence e por quê. (ESPERE)
PASSO 3: CONCLUSÃO
Corrija e feche.
--------------------------------------------------------------',
  'Urgente', 'CMDB', 'Tarefa', 2, NOW(), NOW();

-- ============================================================
-- PARTE 9 — SPRINT 12: CSDM Framework Layers
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 12 — CSDM Framework Layers'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 12: CSDM Framework Layers
📚 TAREFA: As 4 Camadas do CSDM
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Professor, foco no CSDM. Sou Fernando.
PASSO 1: ACESSO
Curso CSDM Fundamentals na ServiceNow Learning. (ESPERE)
PASSO 2: CAMADAS
Explique as 4 camadas: Foundation, Design, Sell/Consume, Support/Operate. Peça para eu dizer em qual tabela ficam os Technical Services e Business Services. (ESPERE)
PASSO 3: CONCLUSÃO
Avalie e feche a task.
--------------------------------------------------------------',
  'Urgente', 'CSDM', 'Tarefa', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 12 — CSDM Framework Layers'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 12: CSDM Framework Layers
📚 TAREFA: Service Mapping e Application Services
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Professor de CSDM, sou Fernando.
PASSO 1: CONCEITO
Explique o que é um Application Service no CSDM e como o Service Mapping o descobre automaticamente a partir dos CIs técnicos. (ESPERE)
PASSO 2: CENÁRIO
Dê um cenário de uma aplicação de e-commerce e peça para eu montar a cadeia Business Service → Application Service → Technical Service. (ESPERE)
PASSO 3: CONCLUSÃO
Corrija e feche a aula.
--------------------------------------------------------------',
  'Urgente', 'CSDM', 'Tarefa', 2, NOW(), NOW();

-- ============================================================
-- PARTE 10 — SPRINT 13: Simulados de Fixação
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 13 — Simulados de Fixação'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 13: Simulados de Fixação
📚 TAREFA: Udemy CIS-DF — Simulado 1 (75 questões, modo exame)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Tutor de Simulados, sou Fernando.
PASSO 1: EXECUÇÃO
Instrua: "Faça o Simulado 1 do curso Servicenow Data Foundation CIS-DF 2026 (Udemy) em modo exame: 75 questões, 1h30, meta 75%+." Pergunte se terminei. (ESPERE)
PASSO 2: ANÁLISE DE ERROS
Peça para eu colar as perguntas que errei. Explique o porquê da alternativa correta em cada uma, ligando ao conceito CIS-DF correspondente (CMDB, CSDM, IRE, Now Create). (ESPERE)
PASSO 3: FECHAMENTO
Registre minha nota e o que preciso revisar antes do Simulado 2.
--------------------------------------------------------------',
  'Alta', 'Simulado', 'Tarefa', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 13 — Simulados de Fixação'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 13: Simulados de Fixação
📚 TAREFA: Udemy CIS-DF — Simulados 2 e 3 (75 + 55 questões)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Tutor de Simulados, sou Fernando, continuando a fixação.
PASSO 1: EXECUÇÃO
Instrua a fazer o Simulado 2 (75 questões) em modo exame. Depois de eu terminar e corrigir os erros, fazer o Simulado 3 (55 questões). (ESPERE cada um)
PASSO 2: ANÁLISE COMPARATIVA
Compare os erros dos 3 simulados — se algum tema se repete (ex: sempre erro em Reconciliation Rules), aponte como lacuna prioritária. (ESPERE)
PASSO 3: FECHAMENTO
Meta: 80%+ nos dois. Se não bater, monte um plano de revisão relâmpago para os temas fracos antes da Sprint 14.
--------------------------------------------------------------',
  'Alta', 'Simulado', 'Tarefa', 2, NOW(), NOW();

-- ============================================================
-- PARTE 11 — SPRINT 14: Prova CIS-DF (revisão final + checklist)
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 14 — Prova CIS-DF (10/09)'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 14: Prova CIS-DF (10/09)
📚 TAREFA: Sabatina Final Cruzada (CMDB + CSDM + IRE + Now Create)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Consultor ServiceNow, chegamos na reta final. Sou Fernando, prova dia 10/09 às 15h.
PASSO 1: REVISÃO RÁPIDA
Monte comigo um Cheat Sheet de 1 página cruzando os 4 temas: CMDB (classes/relacionamentos), CSDM (4 camadas), IRE (identification vs reconciliation rules), Now Create (6 fases). (ESPERE)
PASSO 2: SABATINA
Faça 6 perguntas complexas em formato cenário, cruzando pelo menos 2 temas por pergunta. (ESPERE cada resposta)
PASSO 3: VIBE POSITIVA
Corrija e me dê um feedback motivacional final.
--------------------------------------------------------------',
  'Urgente', 'CIS-DF', 'Tarefa', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 14 — Prova CIS-DF (10/09)'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 14: Prova CIS-DF (10/09)
📚 TAREFA: 🎯 CHECKLIST DO DIA DA PROVA — Quinta 10/09/2026, 15h
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 Exame: CIS-DF — Fundações de Dados (CMDB e CSDM) — Inglês (ENU)
📍 Local: UNICIT Educação Corporativa, SHN Quadra 2, Bloco F, Edif. Executive Office Tower, salas 1620-1623, Brasília-DF (próximo ao Brasília Shopping, de frente ao hotel Kubitschek)
🆔 Pedido: 0080-1000-3539 | Registro: 538913620
⏱️ Duração: 90 minutos

✅ ANTES DE SAIR
[ ] Documento oficial com foto, válido, mesmo nome do cadastro (sem fotocópia)
[ ] Chegar 15 min antes (14h45) — atraso >15min pode perder a vaga e a taxa
[ ] Sem objetos pessoais na sala: celular, bolsa, relógio, carteira ficam fora
[ ] Revisar o Cheat Sheet da tarefa anterior 30 min antes, sem estudar conteúdo novo

🤖 Se quiser, cole isto na IA para uma última simulação cronometrada de 10 perguntas, 2 min cada, antes de sair de casa.',
  'Urgente', 'CIS-DF', 'Tarefa', 2, NOW(), NOW();

-- ============================================================
-- PARTE 12 — SPRINT 15: Scripting — JS Essencial p/ ServiceNow
-- (Curso Udemy: aulas 4-12, cortado ao essencial — pula sintaxe JS genérica já dominada)
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 15 — Scripting: JS Essencial p/ ServiceNow'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 15: Scripting — JS Essencial
📚 TAREFA: Objetos, Arrays e Strings no contexto ServiceNow
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy "Scripting and Advanced Development in ServiceNow" — aulas 6, 7, 8 (String/Array/Object Methods). Pule aulas 4-5 (JS básico/operadores) se já domina variáveis, operadores e tipos — vá direto ao ponto.
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Aja como instrutor de JavaScript aplicado a ServiceNow. Sou o Fernando, já sei a base de JS, quero o essencial usado em scripts reais.
PASSO 1: MÉTODOS-CHAVE
Explique os métodos de String (substring, indexOf, split), Array (map, filter, forEach, indexOf) e Object (Object.keys, hasOwnProperty) mais usados dentro de Business Rules e Script Includes. (ESPERE)
PASSO 2: EXERCÍCIO PRÁTICO
Me dê um array de objetos simulando registros de incidente (sys_id, short_description, priority) e peça para eu filtrar só os de prioridade alta usando .filter(). (ESPERE minha resposta)
PASSO 3: CORREÇÃO
Corrija meu código e feche a tarefa.
--------------------------------------------------------------',
  'Alta', 'Server-Side', 'Tarefa', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 15 — Scripting: JS Essencial p/ ServiceNow'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 15: Scripting — JS Essencial
📚 TAREFA: Condicionais, Loops e Funções — padrões usados em scripts
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 9, 10, 11 (Conditions, Loops, Functions) + aula 12 (Intro to APIs)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de JS para ServiceNow, sou Fernando.
PASSO 1: PADRÕES
Explique quando usar for vs while vs for...of/for...in em scripts ServiceNow (ex: iterar um GlideRecord não usa for tradicional). Explique funções nomeadas vs anônimas vs arrow functions — e por que Business Rules evitam arrow function em alguns contextos (escopo do "this"). (ESPERE)
PASSO 2: EXERCÍCIO
Peça para eu escrever uma função que recebe um array de prioridades e retorna quantos são "1 - Critical". (ESPERE)
PASSO 3: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'Server-Side', 'Tarefa', 2, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 15 — Scripting: JS Essencial p/ ServiceNow'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 15: Scripting — JS Essencial
📚 TAREFA: Arquitetura ServiceNow — Tabelas, Dictionary, Views
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 13-22 (Architecture, Table Creation, Dictionary Properties, Process Flow, Child Tables, Data Lookup, Table Filters) — resumidas numa sessão prática só, sem assistir aula-a-aula.
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Aja como arquiteto ServiceNow revisando fundamentos de dados. Sou o Fernando.
PASSO 1: CONCEITOS RÁPIDOS
Explique em bloco: extensão de tabela (Child Tables), Dictionary Entry (o que controla), Data Lookup Rules (para que servem) e como Views mudam a apresentação sem duplicar dados. (ESPERE)
PASSO 2: EXERCÍCIO PRÁTICO NA MINHA INSTÂNCIA DEV
Me guie a criar uma tabela customizada simples estendendo Task, com 2 campos novos, e configurar uma Dictionary Override em um deles. (ESPERE eu confirmar que fiz)
PASSO 3: FECHAMENTO
Valide o resultado e feche a tarefa.
--------------------------------------------------------------',
  'Alta', 'Server-Side', 'Tarefa', 3, NOW(), NOW();

-- ============================================================
-- PARTE 13 — SPRINT 16: Client-Side
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 16 — Client-Side (Client Scripts, UI Policy, GlideForm)'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 16: Client-Side
📚 TAREFA: UI Policy vs Client Script — quando usar cada um
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 23-25 (UI Policy, UI Policy Continuation, Data Policy)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de UI ServiceNow, sou Fernando.
PASSO 1: DIFERENÇA
Explique a diferença entre UI Policy (declarativo) e Client Script (código) para mostrar/ocultar/tornar obrigatório um campo — e por que UI Policy é preferível quando possível (performance, manutenção). Explique também Data Policy (validação server-side equivalente). (ESPERE)
PASSO 2: CENÁRIO
Dê um cenário: "tornar campo Y obrigatório só se campo X = Urgente" — peça para eu decidir se resolve com UI Policy simples ou Script. (ESPERE)
PASSO 3: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'Client-Side', 'Tarefa', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 16 — Client-Side (Client Scripts, UI Policy, GlideForm)'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 16: Client-Side
📚 TAREFA: Os 4 Tipos de Client Script + GlideForm API
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 27-32 (Client & Server, GlideForm, Client Scripts, OnLoad, OnChange)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de Client Scripts, sou Fernando.
PASSO 1: OS 4 TIPOS
Explique onLoad, onChange, onSubmit e onCellEdit — quando cada um dispara e um caso de uso real para cada. Explique os métodos principais de g_form (setValue, getValue, setMandatory, setVisible, addInfoMessage). (ESPERE)
PASSO 2: EXERCÍCIO
Peça para eu escrever um onChange que, quando o campo "categoria" mudar para "Hardware", torne o campo "modelo_equipamento" visível e obrigatório. (ESPERE meu código)
PASSO 3: CORREÇÃO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'Client-Side', 'Tarefa', 2, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 16 — Client-Side (Client Scripts, UI Policy, GlideForm)'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 16: Client-Side
📚 TAREFA: GlideAjax — chamando servidor sem recarregar a página
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 34-35 (GlideAjax & On Change Use Cases, Continuation)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de GlideAjax, sou Fernando.
PASSO 1: CONCEITO
Explique o fluxo completo: Client Script chama GlideAjax → Script Include (client callable = true) → método retorna valor → callback no client. Por que isso é melhor que um GlideRecord direto no client script (que é bloqueado/depreciado)? (ESPERE)
PASSO 2: EXERCÍCIO
Peça para eu montar (em pseudo-código) um Script Include que recebe um sys_id de usuário e retorna o nome do gestor dele, chamado via GlideAjax num onChange. (ESPERE)
PASSO 3: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'Client-Side', 'Tarefa', 3, NOW(), NOW();

-- ============================================================
-- PARTE 14 — SPRINT 17: Server-Side
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 17 — Server-Side (GlideRecord, GlideAjax, Script Includes)'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 17: Server-Side
📚 TAREFA: GlideRecord — CRUD completo e GlideRecordSecure
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 33, 47, 48 (CRUD operations, Create/Read, Update/Delete & GlideRecordSecure)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor server-side, sou Fernando.
PASSO 1: CRUD
Revise rapidamente insert/update/deleteRecord/query/next comigo, focando nos erros comuns (esquecer .next() no while, usar addQuery errado). Explique a diferença entre GlideRecord e GlideRecordSecure (respeita ACLs). (ESPERE)
PASSO 2: EXERCÍCIO
Peça para eu escrever um script que busca todos os incidentes "Em Andamento" há mais de 5 dias e adiciona um work note automático. (ESPERE meu código)
PASSO 3: CORREÇÃO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'Server-Side', 'Tarefa', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 17 — Server-Side (GlideRecord, GlideAjax, Script Includes)'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 17: Server-Side
📚 TAREFA: GlideAggregate, GlideSystem e GlideDateTime
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 49-52 (GlideAggregate, GlideSystem, GlideDateTime, GlideSchedule/GlideDuration)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de APIs server-side, sou Fernando.
PASSO 1: REVISÃO
Revise GlideAggregate (COUNT/SUM/AVG sem carregar registros completos), gs.log/gs.addErrorMessage, e cálculo de prazos com GlideDateTime + GlideSchedule (considerando calendário de trabalho). (ESPERE)
PASSO 2: EXERCÍCIO
Peça para eu escrever um GlideAggregate que conta quantos incidentes cada responsável tem em aberto, agrupado por assigned_to. (ESPERE)
PASSO 3: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'Server-Side', 'Tarefa', 2, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 17 — Server-Side (GlideRecord, GlideAjax, Script Includes)'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 17: Server-Side
📚 TAREFA: Script Includes — arquitetura reutilizável
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aula 76 (Script Includes)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de arquitetura ServiceNow, sou Fernando.
PASSO 1: PADRÃO
Explique a estrutura de um Script Include orientado a objeto (Class.prototype = {...}, initialize, type: "NomeDaClasse"), e a diferença entre client callable e não-callable. (ESPERE)
PASSO 2: EXERCÍCIO
Peça para eu criar um Script Include "IncidentUtils" com um método getOpenCountByAssignee(sys_id) reutilizável tanto em Business Rule quanto via GlideAjax. (ESPERE meu código)
PASSO 3: CORREÇÃO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'Server-Side', 'Tarefa', 3, NOW(), NOW();

-- ============================================================
-- PARTE 15 — SPRINT 18: Business Rules & Automação
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 18 — Business Rules & Automação'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 18: Business Rules & Automação
📚 TAREFA: Os 3 Objetos Especiais e Ordem de Execução
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 53-57 (Business Rules Parte 1-4, Display Business Rules)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de Business Rules, sou Fernando.
PASSO 1: OBJETOS ESPECIAIS
Explique current, previous e g_scratchpad — quando cada um está disponível (before/after/async/display) e um erro comum de cada. Explique quando usar before vs after vs async. (ESPERE)
PASSO 2: DISPLAY BR
Explique como uma Display Business Rule passa dados calculados do servidor para o formulário via g_scratchpad ANTES de renderizar. (ESPERE eu explicar de volta com minhas palavras)
PASSO 3: EXERCÍCIO
Peça para eu escrever uma before Business Rule que impede salvar um incidente sem categoria se a prioridade for Crítica. (ESPERE)
PASSO 4: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'Server-Side', 'Tarefa', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 18 — Business Rules & Automação'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 18: Business Rules & Automação
📚 TAREFA: Scheduled Jobs, Email Notifications e Events
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 58-64 (Scheduled Jobs, Email Notifications, Events, Email Scripts, Inbound Actions)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de automação ServiceNow, sou Fernando.
PASSO 1: SCHEDULED JOBS
Explique como criar um Scheduled Job (sysauto_script) e um caso de uso real (ex: fechar automaticamente tarefas resolvidas há 7 dias). (ESPERE)
PASSO 2: EVENTS + EMAIL
Explique o fluxo: gs.eventQueue() dispara um evento → Notification escuta o evento → Email Script personaliza o corpo. Por que usar Events em vez de disparar notificação direto na Business Rule? (ESPERE)
PASSO 3: EXERCÍCIO
Peça para eu desenhar (em texto) o fluxo completo de notificar o gestor quando um incidente crítico fica sem atribuição por 1 hora. (ESPERE)
PASSO 4: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'Server-Side', 'Tarefa', 2, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 18 — Business Rules & Automação'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 18: Business Rules & Automação
📚 TAREFA: SLA, Metric Definitions e Reference Qualifiers Avançados
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 67-70 (SLA, Metric Definitions, Advanced Reference Qualifiers, Related Lists)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de SLA e qualificadores, sou Fernando.
PASSO 1: SLA
Explique a estrutura de um SLA Definition (start/pause/stop conditions) e a diferença para uma Metric Definition simples. (ESPERE)
PASSO 2: REFERENCE QUALIFIER
Explique os 3 tipos de reference qualifier (simple, dynamic, script) e quando usar cada um. (ESPERE)
PASSO 3: EXERCÍCIO
Peça para eu escrever um script reference qualifier que só mostra usuários do mesmo grupo do solicitante no campo "aprovador". (ESPERE)
PASSO 4: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Média', 'Server-Side', 'Tarefa', 3, NOW(), NOW();

-- ============================================================
-- PARTE 16 — SPRINT 19: ACLs, UI Actions & Flow Designer
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 19 — ACLs, UI Actions & Flow Designer'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 19: ACLs, UI Actions & Flow Designer
📚 TAREFA: ACLs — Ordem de Avaliação (o ponto mais cobrado)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aula 77 (Access Controls)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de segurança ServiceNow, sou Fernando.
PASSO 1: ORDEM DE AVALIAÇÃO
Explique a ordem: table.field mais específico → table (*) → tipo de operação (read/write/create/delete), e como roles + script/condition dentro de uma ACL interagem (AND, não OR). (ESPERE)
PASSO 2: CENÁRIO
Dê um cenário onde uma ACL de campo específico bloqueia mesmo o usuário tendo acesso à ACL da tabela toda — peça para eu explicar por quê. (ESPERE)
PASSO 3: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'Server-Side', 'Tarefa', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 19 — ACLs, UI Actions & Flow Designer'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 19: ACLs, UI Actions & Flow Designer
📚 TAREFA: UI Actions — Botões, Links e Condições
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 40-43 (UI Actions Parte 1-3)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de UI Actions, sou Fernando.
PASSO 1: TIPOS
Explique as diferenças entre botão de form, link de lista, e context menu — e os campos-chave (Condition, Form button, Client, OnClick vs Action name). (ESPERE)
PASSO 2: EXERCÍCIO
Peça para eu criar (em pseudo-código) uma UI Action "Escalar" que só aparece se priority for Crítica e o usuário tiver role itil_admin, e que muda o assignment_group ao clicar. (ESPERE)
PASSO 3: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'Client-Side', 'Tarefa', 2, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 19 — ACLs, UI Actions & Flow Designer'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 19: ACLs, UI Actions & Flow Designer
📚 TAREFA: Flow Designer — Triggers, Actions e Custom Actions
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 87-91 (Flow Designer Parte 1-5)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de Flow Designer, sou Fernando.
PASSO 1: CONCEITOS
Explique trigger (record created/updated, schedule), a diferença entre Flow, Subflow e Action, e quando criar uma Custom Action em vez de usar as prontas. (ESPERE)
PASSO 2: ERRO COMUM
Explique o erro clássico fd_data (dados não disponíveis entre steps) e como resolver mapeando corretamente inputs/outputs entre actions. (ESPERE eu confirmar entendimento)
PASSO 3: EXERCÍCIO
Peça para eu desenhar (em texto) um flow que, ao criar um incidente com prioridade Crítica, cria uma tarefa de aprovação e notifica o gestor se não aprovada em 1h. (ESPERE)
PASSO 4: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'Flow Designer', 'Tarefa', 3, NOW(), NOW();

-- ============================================================
-- PARTE 17 — SPRINT 20: Projeto Prático Final
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 20 — Projeto Prático Final'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 20: Projeto Prático Final
📚 TAREFA: Construir uma aplicação scoped completa, do zero, na instância Dev
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 DESAFIO (sem instrução de IA — é para você provar que sabe sozinho, IA só corrige no final)
Construa uma "Gestão de Empréstimo de Equipamentos" do zero:
1. Scoped Application própria (não Global)
2. Tabela "Equipamento" (nome, patrimônio, status: Disponível/Emprestado/Manutenção) e tabela "Empréstimo" (equipamento, solicitante, data_saida, data_prevista_devolucao, data_devolucao)
3. Business Rule: ao criar um Empréstimo, muda o status do Equipamento para "Emprestado"; ao preencher data_devolucao, volta para "Disponível"
4. Client Script: campo data_prevista_devolucao obrigatório só se o equipamento escolhido for da categoria "Notebook" (GlideAjax consultando o Script Include)
5. UI Action: botão "Registrar Devolução" que preenche data_devolucao = hoje só se ainda vazio
6. ACL: só quem está no grupo "Patrimônio" pode deletar um Empréstimo
7. Flow Designer: notifica o solicitante 1 dia antes da data prevista de devolução
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 DEPOIS DE PRONTO, cole isto na IA para revisão:
"Aja como revisor técnico sênior ServiceNow. Vou descrever minha aplicação de Gestão de Empréstimo de Equipamentos (scoped app, tabelas, business rule, client script, UI action, ACL, flow). Aponte falhas de arquitetura, segurança ou performance como faria em um code review real." (cole a descrição do que você construiu)',
  'Urgente', 'Server-Side', 'História', 1, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 20 — Projeto Prático Final'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 20: Projeto Prático Final
📚 TAREFA: Simulado de Entrevista Técnica Nível Pleno (rodada 2)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Aja como entrevistador técnico sênior de ServiceNow contratando um Dev Pleno. Sou o Fernando, já tenho CIS-DF e terminei o projeto prático de Gestão de Equipamentos.
PASSO 1: PERGUNTAS
Faça 10 perguntas técnicas cobrindo: GlideRecord/GlideAjax, Business Rules (ordem de execução), Script Includes, ACLs, Flow Designer, e 1 pergunta de arquitetura ("como você projetaria X"). Cronometre 2 minutos por resposta. (ESPERE cada resposta)
PASSO 2: FEEDBACK NÍVEL SÊNIOR
Para cada resposta, diga se seria nível júnior, pleno ou sênior, e o que faltou para subir de nível.
PASSO 3: VEREDITO FINAL
Dê um veredito geral: pronto para vaga pleno, ou o que falta.
--------------------------------------------------------------',
  'Alta', 'Simulado', 'Tarefa', 2, NOW(), NOW();
