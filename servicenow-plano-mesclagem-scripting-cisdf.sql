-- ============================================================
-- Mesclagem: adiciona 1 tarefa de Scripting prático em cada sprint
-- CIS-DF (8-14) e 1 tarefa de reforço CIS-DF em cada sprint de
-- Scripting (15-19). Não apaga nada — só adiciona, para não perder
-- progresso já feito nas tasks existentes.
-- ============================================================

-- Sprint 8 — Now Create Methodology: scripting de Update Sets na prática
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 8 — Now Create Methodology'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 8: Now Create Methodology
📚 TAREFA: [SCRIPTING] JavaScript básico revisado na prática (variáveis, tipos, operadores)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy "Scripting and Advanced Development in ServiceNow" — aulas 4-5 (JS Basics, Operators)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de JS para ServiceNow, sou Fernando, intercalando com o estudo de CIS-DF.
PASSO 1: REVISÃO RÁPIDA
Revise comigo var/let/const (por que ServiceNow ainda usa var em Business Rules por compatibilidade de engine), operadores de comparação (== vs ===) e tipos primitivos. (ESPERE)
PASSO 2: EXERCÍCIO NA DEV INSTANCE
Abra o Scripts - Background da sua instância dev e peça para eu rodar um gs.info() imprimindo tipo de 3 valores diferentes (string, number, undefined de um campo vazio). (ESPERE eu confirmar que rodei)
PASSO 3: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Média', 'Server-Side', 'Tarefa', 3, NOW(), NOW();

-- Sprint 9 — Platform Implementation: scripting de Update Set na prática (GlideRecord básico)
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 9 — Platform Implementation'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 9: Platform Implementation
📚 TAREFA: [SCRIPTING] Primeiro GlideRecord — Read básico na dev instance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aula 47 (GlideRecord Create and Read Operations)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor server-side, sou Fernando, conectando com o que vi hoje de Update Sets.
PASSO 1: EXPLICAÇÃO
Explique a estrutura mínima de um GlideRecord: new GlideRecord(tabela), addQuery, query(), next(). Por que query() sem addQuery traz TODOS os registros (cuidado de performance)? (ESPERE)
PASSO 2: EXERCÍCIO NA DEV INSTANCE
Peça para eu abrir Scripts - Background e escrever um script que lista os 5 últimos Update Sets criados (nome + data), usando setLimit(5) e orderByDesc. (ESPERE eu rodar e colar o resultado)
PASSO 3: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Média', 'Server-Side', 'Tarefa', 3, NOW(), NOW();

-- Sprint 10 — CMDB Architecture: scripting aplicado a CMDB
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 10 — CMDB Architecture'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 10: CMDB Architecture
📚 TAREFA: [SCRIPTING] Script Include que consulta cmdb_ci e cmdb_rel_ci
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aula 76 (Script Includes) aplicada ao conteúdo de CMDB desta sprint
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de scripting aplicado a CMDB, sou Fernando.
PASSO 1: ESTRUTURA
Revise a estrutura básica de um Script Include (Class.prototype, initialize, type). (ESPERE)
PASSO 2: EXERCÍCIO NA DEV INSTANCE
Me guie a criar um Script Include "CmdbUtils" com um método getRelatedCIs(sys_id) que faz um GlideRecord em cmdb_rel_ci e retorna um array com os CIs relacionados. Teste no Scripts - Background com um CI real da sua instância. (ESPERE eu confirmar o resultado)
PASSO 3: FECHAMENTO
Corrija e feche — isso te dá uma base prática de código para citar na prova e em entrevista.
--------------------------------------------------------------',
  'Alta', 'CMDB', 'Tarefa', 3, NOW(), NOW();

-- Sprint 11 — CMDB Health & IRE: business rule aplicada a CI
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 11 — CMDB Health & IRE'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 11: CMDB Health & IRE
📚 TAREFA: [SCRIPTING] Business Rule que valida completeness de um CI antes de salvar
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 53-54 (Business Rules Parte 1-2) aplicada ao pilar Completeness visto nesta sprint
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de Business Rules aplicado a CMDB Health, sou Fernando.
PASSO 1: CONCEITO
Relembre before vs after Business Rule e o objeto current. (ESPERE)
PASSO 2: EXERCÍCIO NA DEV INSTANCE
Me guie a criar uma before Business Rule numa tabela de CI (ex: cmdb_ci_computer) que bloqueia o salvamento se o campo "serial_number" estiver vazio — simulando uma regra de Completeness. Teste criando um CI sem o campo. (ESPERE eu confirmar o bloqueio)
PASSO 3: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'CMDB', 'Tarefa', 3, NOW(), NOW();

-- Sprint 12 — CSDM Framework Layers: client script + UI policy aplicados a service
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 12 — CSDM Framework Layers'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 12: CSDM Framework Layers
📚 TAREFA: [SCRIPTING] UI Policy num Business Service (torna campo obrigatório por tipo)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 23-24 (UI Policy) aplicada à tabela de Business Service vista nesta sprint
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de UI Policy aplicado a CSDM, sou Fernando.
PASSO 1: RELEMBRAR
Relembre a estrutura de uma UI Policy (condition + UI Policy Action) sem código. (ESPERE)
PASSO 2: EXERCÍCIO NA DEV INSTANCE
Me guie a criar uma UI Policy na tabela Business Service que torna o campo "owned_by" obrigatório quando o Service Classification for "Business Service". Teste mudando a classificação num registro. (ESPERE eu confirmar)
PASSO 3: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Alta', 'CSDM', 'Tarefa', 3, NOW(), NOW();

-- Sprint 13 — Simulados de Fixação: GlideAjax aplicado
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 13 — Simulados de Fixação'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 13: Simulados de Fixação
📚 TAREFA: [SCRIPTING] GlideAjax simples: buscar dado do servidor sem recarregar
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎬 REFERÊNCIA: Udemy aulas 34-35 (GlideAjax)
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor de GlideAjax, sou Fernando, fazendo uma pausa prática entre simulados.
PASSO 1: FLUXO
Relembre o fluxo Client Script → GlideAjax → Script Include (client callable) → callback. (ESPERE)
PASSO 2: EXERCÍCIO NA DEV INSTANCE
Me guie a criar um Script Include client callable com um método getCiCount() que retorna quantos CIs existem em cmdb_ci, chamado via GlideAjax num Client Script onLoad que exibe o total num alert. (ESPERE eu confirmar que funcionou)
PASSO 3: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Média', 'Client-Side', 'Tarefa', 3, NOW(), NOW();

-- Sprint 14 — Prova: SEM scripting novo (foco total em revisão final, mantém como está)

-- ============================================================
-- Reforço CIS-DF dentro das sprints de Scripting (15-19)
-- ============================================================

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 15 — Scripting: JS Essencial p/ ServiceNow'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 15: Scripting — JS Essencial
📚 TAREFA: [REFORÇO CIS-DF] Revisão de erros dos 3 simulados (pós-prova)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Consultor CIS-DF, sou Fernando, já fiz a prova. Quero consolidar o que ficou fraco.
PASSO 1: LEVANTAMENTO
Peça para eu listar os temas que mais errei nos 3 simulados (Sprint 13) e no resultado real da prova, se já sei o resultado. (ESPERE)
PASSO 2: APROFUNDAMENTO
Escolha os 2 temas mais fracos e me explique em profundidade, com 1 cenário complexo cada. (ESPERE minhas respostas)
PASSO 3: FECHAMENTO
Registre isso como conhecimento consolidado — vai ser útil em entrevista e no dia a dia.
--------------------------------------------------------------',
  'Média', 'CIS-DF', 'Tarefa', 4, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 16 — Client-Side (Client Scripts, UI Policy, GlideForm)'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 16: Client-Side
📚 TAREFA: [REFORÇO CIS-DF] CMDB + Client Scripts: validação de campos técnicos de CI no formulário
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor cruzando CMDB com Client-Side, sou Fernando.
PASSO 1: CENÁRIO
Explique como Client Scripts podem ajudar a manter a qualidade de dados de CI (ex: alertar se IP address estiver em formato inválido antes de salvar). (ESPERE)
PASSO 2: EXERCÍCIO
Peça para eu escrever um onChange que valida formato de IP num campo customizado de CI e mostra addErrorMessage se inválido. (ESPERE meu código)
PASSO 3: FECHAMENTO
Corrija e feche — conecta Client-Side com Data Quality do CIS-DF.
--------------------------------------------------------------',
  'Média', 'CMDB', 'Tarefa', 4, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 17 — Server-Side (GlideRecord, GlideAjax, Script Includes)'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 17: Server-Side
📚 TAREFA: [REFORÇO CIS-DF] Script para auditar Completeness/Correctness em massa
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor cruzando GlideAggregate com CMDB Health, sou Fernando.
PASSO 1: CENÁRIO
Explique como um GlideAggregate pode ser usado para gerar um relatório de quantos CIs de uma classe estão com campos obrigatórios vazios (violação de Completeness). (ESPERE)
PASSO 2: EXERCÍCIO
Peça para eu escrever esse script de auditoria numa classe de CI à sua escolha. (ESPERE meu código)
PASSO 3: FECHAMENTO
Corrija e feche — isso é literalmente o tipo de script que um CIS-DF certificado entrega no trabalho real.
--------------------------------------------------------------',
  'Média', 'CMDB', 'Tarefa', 4, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 18 — Business Rules & Automação'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 18: Business Rules & Automação
📚 TAREFA: [REFORÇO CIS-DF] Business Rule que aplica Identification Rule customizada
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor cruzando Business Rules com IRE, sou Fernando.
PASSO 1: CENÁRIO
Relembre como o IRE usa Identification Rules para decidir se um CI é novo ou uma atualização de existente. (ESPERE)
PASSO 2: EXERCÍCIO
Peça para eu descrever (não precisa configurar de verdade, é caro mexer no IRE em produção) os critérios que eu usaria numa Identification Rule para uma classe de CI customizada "Impressora" (ex: combinação de IP + número de série). (ESPERE)
PASSO 3: FECHAMENTO
Corrija e feche.
--------------------------------------------------------------',
  'Média', 'CMDB', 'Tarefa', 4, NOW(), NOW();

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT 4,
  (SELECT id FROM sprints WHERE board_id=4 AND name = 'Sprint 19 — ACLs, UI Actions & Flow Designer'),
  13,
  '👤 RESPONSÁVEL: Fernando Morais
📌 QUADRO: ServiceNow
🏃 SPRINT 19: ACLs, UI Actions & Flow Designer
📚 TAREFA: [REFORÇO CIS-DF] ACL protegendo edição de CIs críticos da CMDB
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 INSTRUÇÃO DE ESTUDO INTERATIVO
Copie e cole na sua IA:

--------------------------------------------------------------
Instrutor cruzando ACL com governança de CMDB, sou Fernando.
PASSO 1: CENÁRIO
Explique por que CIs de produção crítica geralmente têm ACL de write mais restrita que CIs de dev/teste. (ESPERE)
PASSO 2: EXERCÍCIO NA DEV INSTANCE
Me guie a criar uma ACL de write na tabela de CI que só libera edição para o grupo "Chain-SSN-SA-Arquitetos" quando o campo "environment" for "Production". (ESPERE eu confirmar)
PASSO 3: FECHAMENTO
Corrija e feche — fecha o ciclo entre CIS-DF (governança de dados) e Scripting (implementação real).
--------------------------------------------------------------',
  'Média', 'CMDB', 'Tarefa', 4, NOW(), NOW();
