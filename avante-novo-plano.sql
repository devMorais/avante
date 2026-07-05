-- ============================================================
-- Avante — reset do backlog de produção (board_id = 8)
-- Gerado em 2026-07-04, formato de demanda no padrão do Educore
-- (contexto + arquivos envolvidos + critérios de aceite + prompt de IA)
--
-- ATENÇÃO: este script é DESTRUTIVO na primeira parte (hard delete
-- das 30 tasks + 5 sprints antigas do board 8) e não é idempotente
-- na segunda parte (rodar de novo duplica sprints/tasks). Rodar UMA VEZ.
--
-- Cascade automático (FK cascadeOnDelete): apagar uma task já apaga
-- sozinho suas linhas em task_user/comments/attachments/task_tag.
-- Board 8 hoje não tem nenhuma dessas linhas mesmo assim (auditoria
-- de 2026-07-04: 0 comentários, 0 anexos, 0 tags aplicadas).
-- ============================================================

-- Passo 0 (conferência): confirme que o board é mesmo este antes de continuar
SELECT id, name FROM boards WHERE id = 8;

-- ============================================================
-- PARTE 1 — LIMPEZA (hard delete, decisão explícita do usuário)
-- ============================================================
DELETE FROM tasks WHERE board_id = 8;
DELETE FROM sprints WHERE board_id = 8;

-- ============================================================
-- PARTE 2 — NOVAS SPRINTS (4), organizadas por severidade da
-- auditoria técnica (Crítico → Alto → Médio → Comercialização)
-- ============================================================
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
VALUES (8, 'Sprint 1 — Segurança & Isolamento (Crítico)', '2026-07-07', '2026-07-18', NOW(), NOW());
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
VALUES (8, 'Sprint 2 — Prontidão de Produção (Alto)', '2026-07-21', '2026-08-01', NOW(), NOW());
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
VALUES (8, 'Sprint 3 — Qualidade & Experiência (Médio)', '2026-08-04', '2026-08-15', NOW(), NOW());
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
VALUES (8, 'Sprint 4 — Comercialização', '2026-08-18', '2026-08-29', NOW(), NOW());

-- ============================================================
-- PARTE 3 — TAREFA META (contexto vivo do projeto para IA,
-- mesmo padrão do board Educore: notes = conteúdo do CLAUDE.md)
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, notes, priority, epic, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 1 — Segurança & Isolamento (Crítico)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[META-01] Contexto do Projeto para IA (CLAUDE.md) + por que este backlog foi zerado

Este board foi auditado em 2026-07-04. Achados: das 30 tarefas antigas, 6 estavam marcadas "Concluída" sem nenhuma linha de código correspondente (due_date, story_points e checklist nunca foram implementados — confirmado por grep no repositório inteiro), e 6 outras funcionalidades já prontas no código (Kanban com drag-and-drop, dark mode, tags, notificações in-app) nunca tiveram o status atualizado no board. Por isso o backlog foi zerado e recriado do zero, ancorado numa auditoria real de código em vez de suposições.

Antes de pegar qualquer demanda [D-XX] deste board: leia o conteúdo completo desta tarefa (campo Caderno / notes) — é o CLAUDE.md inteiro do projeto, colado aqui para que você (pessoa ou IA) tenha o contexto completo sem precisar navegar o repositório primeiro. Cole este conteúdo junto com a descrição da demanda no prompt da sua IA.

Regra obrigatória: nunca assuma, adivinhe ou invente nome de rota, campo de banco, comportamento ou decisão de arquitetura que não esteja explícito na demanda ou neste Caderno. Pare e pergunte antes de continuar caso falte informação.

Todas as demandas deste plano são independentes e full-stack: cada uma cobre backend e frontend da própria funcionalidade, sem depender de outra demanda estar pronta antes (exceto onde explicitamente citado). Isso significa que Fernando e Claudia podem trabalhar em paralelo sem travar um no outro.',
  '# 🧠 CLAUDE.md — Projeto Avante

> ⚠️ Mantenha este arquivo atualizado a cada mudança estrutural do projeto.
> Ele serve como memória viva para desenvolvedores e IAs entenderem o projeto rapidamente.
> Última atualização: 04/07/2026 — Correção de documentação após auditoria técnica completa: visão **Kanban real com drag-and-drop** (`@angular/cdk/drag-drop`, toggle Tabela/Kanban) documentada no task-list (existia no código mas não estava descrita aqui); removida a menção a paginação de 25/página (`GET /api/tasks` não pagina, retorna tudo); Analytics não é mais menu placeholder. Board de produção (id=8) zerado e recriado com plano novo focado em prontidão comercial (multi-tenancy, autorização, segurança, testes, responsividade) — ver task `[META-01]` no board para o histórico completo da auditoria. Antes (02/07/2026): Leva grande: alinhamento fino da tabela + ações em massa (Tipo/Tags, endpoint bulk-update, setas nos popovers); modo claro/escuro em todo o sistema (ThemeService, tokens globais); notificações in-app (sino no sidebar) + foto real nos comentários; anexos de arquivo compartilhados por tarefa (aba "Arquivos", servidor); área de Marketing funcional (calendário de conteúdo, pipeline de leads, banco de ideias, campanhas, desempenho); área de Analytics funcional (distribuição, velocidade, carga por pessoa, burndown, cycle time, export CSV/PDF); infraestrutura de avisos via WhatsApp (opt-in no perfil, gateway plugável, comando agendado). Antes disso: Arquivar/restaurar quadros (archived_at; seção colapsável "Arquivados" na board-list; endpoints PATCH archive/unarchive); Modal só fecha no X; comentários abaixo da descrição; colar imagens (Ctrl+V) na descrição; tipo de tarefa (DB) com faixa colorida; full-width geral; sidebar no perfil.

---

## 📌 Visão geral

**Avante** é um sistema de gestão de tarefas com quadros, sprints, status personalizados e colaboração em equipe.

- **URL produção:** https://avante.devmorais.com.br
- **Repositório:** https://github.com/devMorais/avante.git
- **Ambiente local:** http://gestao-tarefas.test (Laravel Herd no Windows)

---

## 🧱 Stack

| Camada       | Tecnologia                                   |
| ------------ | -------------------------------------------- |
| Backend      | Laravel 13 (PHP 8.3)                         |
| Frontend     | Angular 21 + Tailwind CSS + Angular Material |
| Banco        | MySQL                                        |
| Autenticação | Laravel Sanctum (tokens)                     |
| Servidor     | Hostinger CloudLinux (shared hosting)        |
| Dev local    | Laravel Herd (Windows)                       |

---

## 🗂️ Estrutura de pastas

```
gestao-tarefas/
├── CLAUDE.md
├── .gitignore
├── backend/
│   ├── app/
│   │   ├── Http/
│   │   │   ├── Controllers/
│   │   │   │   ├── AuthController.php
│   │   │   │   ├── BoardController.php
│   │   │   │   ├── CommentController.php
│   │   │   │   ├── ProfileController.php
│   │   │   │   ├── SprintController.php
│   │   │   │   ├── StatusController.php
│   │   │   │   ├── TaskController.php
│   │   │   │   └── UserController.php
│   │   │   └── Middleware/
│   │   ├── Models/
│   │   │   ├── Board.php
│   │   │   ├── Comment.php
│   │   │   ├── Sprint.php
│   │   │   ├── Status.php
│   │   │   ├── Task.php
│   │   │   └── User.php
│   │   └── Providers/
│   ├── database/migrations/
│   ├── routes/api.php
│   ├── public-static/          ← arquivos fixos copiados pelo ng build
│   │   ├── index.php           ← Laravel entry point (protegido do clean build)
│   │   └── .htaccess           ← roteamento Laravel (protegido do clean build)
│   └── public/                 ← document root (Laravel + Angular build)
│
└── frontend/
    ├── src/
    │   ├── app/
    │   │   ├── components/
    │   │   │   ├── analytics/        ← indicadores reais do quadro (seção "analytics" do task-list)
    │   │   │   ├── board-list/       ← lista de quadros (rota /)
    │   │   │   ├── login/            ← tela de login (rota /login)
    │   │   │   ├── marketing/        ← calendário, pipeline, ideias, campanhas, desempenho (seção "marketing")
    │   │   │   ├── profile/          ← perfil do usuário (rota /profile)
    │   │   │   ├── sprint-manager/   ← gestão de sprints
    │   │   │   ├── status-manager/   ← gestão de status
    │   │   │   ├── task-dialog/      ← modal criar/editar tarefa
    │   │   │   ├── task-filters/     ← filtros horizontais
    │   │   │   ├── task-list/        ← página principal (rota /board/:id)
    │   │   │   └── user-manager/     ← gestão de usuários
    │   │   ├── guards/
    │   │   │   └── auth-guard.ts
    │   │   ├── interceptors/
    │   │   │   └── auth-interceptor.ts
    │   │   ├── services/
    │   │   │   ├── api.ts            ← todos endpoints HTTP
    │   │   │   ├── auth.ts           ← estado de autenticação (Signal)
    │   │   │   ├── theme.ts          ← modo claro/escuro (Signal, classe .dark em <html>)
    │   │   │   └── notifications.ts  ← notificações in-app (poll de contagem/lista)
    │   │   ├── shared/ui/
    │   │   │   ├── avatar/           ← iniciais ou foto com fallback
    │   │   │   ├── badge/            ← indicador de status com cor
    │   │   │   ├── button/           ← botão com variantes/estados
    │   │   │   ├── confirm-dialog/   ← modal de confirmação
    │   │   │   ├── modal/            ← container genérico de modal
    │   │   │   ├── pagination/       ← paginação (prev/next/números)
    │   │   │   ├── popover/          ← menu flutuante / dropdown
    │   │   │   └── sidebar/          ← barra lateral com abas
    │   │   ├── app.config.ts
    │   │   ├── app.routes.ts
    │   │   └── app.ts
    │   ├── environments/
    │   │   ├── environment.ts        ← dev: gestao-tarefas.test
    │   │   └── environment.prod.ts   ← prod: avante.devmorais.com.br
    │   └── main.ts
    ├── public-static/          ← fonte dos arquivos estáticos do Laravel
    │   ├── index.php
    │   └── .htaccess
    └── angular.json            ← outputPath + fileReplacements + assets
```

---

## 🔀 Roteamento em produção

`.htaccess` raiz em camadas:

1. Arquivos estáticos → `backend/public/`
2. `/api/*` → Laravel (`backend/public/index.php`)
3. Tudo mais → Angular SPA (`backend/public/index.html`)

```apache
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{DOCUMENT_ROOT}/backend/public%{REQUEST_URI} -f
    RewriteRule ^(.*)$ backend/public/$1 [L]
    RewriteCond %{REQUEST_URI} ^/api [NC]
    RewriteRule ^ backend/public/index.php [L,QSA]
    RewriteRule ^ backend/public/index.html [L]
</IfModule>
```

> ⚠️ `ng build` fazia clean e apagava `index.php` e `.htaccess` do Laravel.
> **Solução:** arquivos ficam em `frontend/public-static/` e são copiados via assets no `angular.json`.

---

## ⚙️ angular.json — configurações críticas

```json
"outputPath": { "base": "../backend/public", "browser": "" },
"assets": [
  { "glob": "**/*", "input": "public" },
  { "glob": "index.php", "input": "public-static", "output": "/" },
  { "glob": ".htaccess", "input": "public-static", "output": "/" }
],
"configurations": {
  "production": {
    "fileReplacements": [
      {
        "replace": "src/environments/environment.ts",
        "with": "src/environments/environment.prod.ts"
      }
    ],
    "budgets": [
      { "type": "initial", "maximumWarning": "2MB", "maximumError": "5MB" },
      { "type": "anyComponentStyle", "maximumWarning": "50kB", "maximumError": "100kB" }
    ],
    "outputHashing": "all"
  }
},
"defaultConfiguration": "production"
```

---

## 🌐 Environments Angular

**`frontend/src/environments/environment.ts`** (dev):

```typescript
export const environment = {
  production: false,
  apiUrl: "http://gestao-tarefas.test/api",
  backendUrl: "http://gestao-tarefas.test",
};
```

**`frontend/src/environments/environment.prod.ts`** (produção):

```typescript
export const environment = {
  production: true,
  apiUrl: "https://avante.devmorais.com.br/api",
  backendUrl: "https://avante.devmorais.com.br",
};
```

**`frontend/src/app/services/api.ts`** — início do arquivo:

```typescript
import { environment } from "../../environments/environment";
const API_URL = environment.apiUrl;
const BACKEND_URL = environment.backendUrl;
```

---

## 🗄️ Banco de dados

### Tabelas principais

| Tabela             | Campos principais                                                                    |
| ------------------ | ------------------------------------------------------------------------------------ |
| users              | name, email, password, role, bio, position, avatar_url, **whatsapp_number**, **whatsapp_opt_in**, soft delete |
| boards             | name, icon_path, **archived_at** (arquivar sem excluir), soft delete                 |
| tasks              | description, priority, epic, release, type, notes (longText), **completed_at** (preenchido ao entrar no status "concluído"), sprint_id, status_id, board_id, sort_order, soft delete |
| sprints            | name, start_date, end_date, finished_at, board_id, soft delete                       |
| statuses           | name, color, order, board_id, soft delete                                            |
| priorities         | name, color, order, board_id, soft delete (CRUD igual status; tasks.priority guarda o nome) |
| task_types         | name, color, order, board_id, soft delete (tipos de tarefa; tasks.type guarda o nome; faixa colorida na linha) |
| tags               | name, color, board_id, soft delete                                                   |
| task_tag           | pivot — tags de uma tarefa                                                            |
| task_user          | pivot — múltiplos usuários por tarefa (unique task_id + user_id)                    |
| comments           | task_id, user_id, content, soft delete                                               |
| notifications      | user_id (destinatário), task_id, from_user_id, type (comment/mention), message, read_at |
| attachments        | task_id, user_id (quem subiu), path, original_name, size, mime_type, soft delete — arquivos compartilhados, baixáveis por todos |
| marketing_posts    | board_id, user_id, title, caption, channel, scheduled_at, status (idea/scheduled/published), image_path, soft delete |
| marketing_leads    | board_id, name, contact, stage (novo/contato/proposta/ganho/perdido), value, notes, soft delete |
| marketing_ideas    | board_id, title, description, votes, tags, soft delete                               |
| marketing_campaigns| board_id, name, channels, budget, start_date, end_date, goal, status, soft delete    |
| marketing_metrics  | board_id, channel, period_date, reach, engagement, conversions                       |

### Migrations em ordem

```
0001_01_01_000000 create_users_table
0001_01_01_000001 create_cache_table
0001_01_01_000002 create_jobs_table
2026_06_21_003014 create_personal_access_tokens_table
2026_06_21_003345 create_boards_table
2026_06_21_003353 create_tasks_table
2026_06_21_041037 create_sprints_table
2026_06_21_041120 add_sprint_and_assignee_to_tasks_table
2026_06_21_042426 create_statuses_table
2026_06_21_042517 replace_status_with_status_id_on_tasks_table
2026_06_21_153916 remove_title_and_tags_from_tasks_table
2026_06_21_160951 add_soft_deletes_to_boards_tasks_sprints_statuses_tables
2026_06_21_182959 add_role_and_soft_deletes_to_users_table
2026_06_21_203314 create_task_user_table
2026_06_21_213358 create_comments_table
2026_06_22_033101 add_profile_fields_to_users_table
2026_06_23_034204 add_finished_to_sprints_table
2026_06_24_200000 add_notes_to_tasks_table
2026_06_26_200001 create_tags_table
2026_06_26_200002 create_task_tag_table
2026_06_26_200003 add_sort_order_to_tasks_table
2026_06_26_210000 add_release_to_tasks_table
2026_06_26_220000 create_priorities_table
2026_06_26_230000 create_task_types_table
2026_06_27_000000 add_archived_at_to_boards_table
2026_07_02_010000 create_notifications_table
2026_07_02_020000 create_attachments_table
2026_07_02_030000 create_marketing_posts_table
2026_07_02_030001 create_marketing_leads_table
2026_07_02_030002 create_marketing_ideas_table
2026_07_02_030003 create_marketing_campaigns_table
2026_07_02_030004 create_marketing_metrics_table
2026_07_02_040000 add_completed_at_to_tasks_table
2026_07_02_050000 add_whatsapp_fields_to_users_table
```

---

## 🔌 API — Endpoints

### Públicas
| Método | Rota        | Descrição |
| ------ | ----------- | --------- |
| POST   | /api/login  | Login     |

### Autenticadas (Bearer token Sanctum)
| Método | Rota                     | Descrição                                                                              |
| ------ | ------------------------ | -------------------------------------------------------------------------------------- |
| POST   | /api/logout              | Logout (deleta token atual)                                                            |
| GET    | /api/user                | Usuário autenticado atual                                                              |
| GET    | /api/profile             | Perfil autenticado                                                                     |
| PUT    | /api/profile             | Atualizar nome/email/bio/position                                                      |
| POST   | /api/profile/password    | Atualizar senha (current_password + password)                                          |
| POST   | /api/profile/avatar      | Upload avatar (jpg/jpeg/png/webp, max 2MB)                                             |
| PUT    | /api/profile             | (também aceita `whatsapp_number` + `whatsapp_opt_in`)                                  |
| GET    | /api/boards              | Lista quadros                                                                          |
| POST   | /api/boards              | Criar quadro (cria 4 status padrão automaticamente)                                    |
| GET    | /api/boards/{id}         | Detalhe do quadro                                                                      |
| PUT    | /api/boards/{id}         | Atualizar quadro                                                                       |
| PATCH  | /api/boards/{id}/archive | Arquivar quadro (preenche archived_at)                                                 |
| PATCH  | /api/boards/{id}/unarchive | Restaurar quadro arquivado (archived_at = null)                                      |
| DELETE | /api/boards/{id}         | Deletar quadro                                                                         |
| GET    | /api/tasks               | Lista tarefas (filtros: board_id, page, search, status_ids, priorities, assignee_ids)  |
| POST   | /api/tasks               | Criar tarefa                                                                           |
| GET    | /api/tasks/{id}          | Detalhe da tarefa                                                                      |
| PUT    | /api/tasks/{id}          | Atualizar tarefa (assignee_ids[] sincroniza via pivot)                                 |
| DELETE | /api/tasks/{id}          | Deletar tarefa                                                                         |
| POST   | /api/tasks/bulk-update    | Atualiza status/prioridade/tipo/sprint (substitui) ou add_tag_id/add_assignee_id (adiciona) de várias tarefas numa só requisição |
| GET    | /api/tasks/{id}/comments | Lista comentários                                                                      |
| POST   | /api/tasks/{id}/comments | Criar comentário (gera notificações para responsáveis, outros comentaristas e menções `@Nome`) |
| DELETE | /api/comments/{id}       | Deletar comentário                                                                     |
| GET    | /api/tasks/{id}/attachments | Lista arquivos anexados à tarefa                                                    |
| POST   | /api/tasks/{id}/attachments | Upload de arquivo (multipart `file`, máx. 10MB, qualquer tipo) — visível a todos    |
| DELETE | /api/attachments/{id}    | Remove um anexo                                                                        |
| GET    | /api/notifications       | Lista notificações recentes do usuário autenticado                                     |
| GET    | /api/notifications/unread-count | Contagem de não lidas                                                          |
| POST   | /api/notifications/{id}/read | Marca uma notificação como lida                                                   |
| POST   | /api/notifications/read-all | Marca todas como lidas                                                             |
| GET    | /api/analytics/board/{boardId} | Agregados: distribuição (status/prioridade/tipo), velocidade por sprint, carga por responsável, burndown da sprint ativa, cycle time médio |
| GET/POST/PUT/DELETE | /api/marketing-posts | CRUD de posts (calendário de conteúdo — compor/agendar, sem publicação automática) |
| GET/POST/PUT/DELETE | /api/marketing-leads | CRUD de leads (pipeline de vendas por estágio)                            |
| GET/POST/PUT/DELETE | /api/marketing-ideas | CRUD de ideias; `POST /marketing-ideas/{id}/upvote` para votar                |
| GET/POST/PUT/DELETE | /api/marketing-campaigns | CRUD de campanhas                                                         |
| GET/POST/DELETE | /api/marketing-metrics | Métricas de desempenho por canal/período (entrada manual)                       |
| GET    | /api/sprints             | Lista sprints por board_id (ordenado por start_date)                                   |
| POST   | /api/sprints             | Criar sprint                                                                           |
| PUT    | /api/sprints/{id}        | Atualizar sprint                                                                       |
| DELETE | /api/sprints/{id}        | Deletar sprint                                                                         |
| POST   | /api/sprints/{id}/finish | Finalizar sprint — body: `{ concluded_status_id: number\\|null }`                      |
| GET    | /api/statuses            | Lista status por board_id (ordenado por order)                                         |
| POST   | /api/statuses            | Criar status                                                                           |
| PUT    | /api/statuses/{id}       | Atualizar status                                                                       |
| DELETE | /api/statuses/{id}       | Deletar status (tasks ficam com status_id = null)                                      |
| GET    | /api/users               | Lista usuários                                                                         |
| POST   | /api/users               | Criar usuário                                                                          |
| PUT    | /api/users/{id}          | Atualizar usuário                                                                      |
| DELETE | /api/users/{id}          | Deletar usuário                                                                        |

---

## 🎨 Frontend — Componentes

### Rotas Angular

| Rota          | Componente       | Guard    |
| ------------- | ---------------- | -------- |
| /login        | Login            | —        |
| /             | BoardList        | authGuard |
| /board/:id    | TaskList         | authGuard |
| /profile      | ProfileComponent | authGuard |

### Componentes principais

**board-list**
- Lista quadros com busca
- Cria/edita/deleta quadros (com ícone)
- Abre sidebar para gerenciar usuários
- Sidebar com menu placeholder: EduCore (badge "Em breve", toast ao clicar) — Analytics já é real (ver `app-analytics`)

**task-list** (página principal)
- Duas visões alternáveis (toggle no header): **Tabela** (agrupada por sprint, ordenado por `start_date`) e **Kanban** (uma coluna por status, incluindo "Sem status") — ambas com drag-and-drop real via `@angular/cdk/drag-drop` (`cdkDropList`/`cdkDrag`), persistindo `sort_order` via `reorderTasks()`
- Cabeçalho por sprint (visão Tabela): nome, contagem, datas, barra de progresso, badge "Vencida/Finalizada", botão "Finalizar Sprint"
- Mudança de status por 3 caminhos: popover no badge (Tabela), drag-and-drop entre colunas (Kanban), ação em massa
- Seleção individual e por sprint com indeterminate
- Barra flutuante de ações em lote (status, prioridade, mover sprint)
- Mover tarefas entre sprints via modal
- Sidebar com abas: Tasks, Sprints, Statuses + menu EduCore (em breve)
- **Sem paginação real ainda**: `GET /api/tasks` retorna todas as tasks do board de uma vez (`TaskController::index` não pagina); filtros e ordenação são locais no frontend
- **Importar JSON em massa**: botão no header, modal com textarea JSON, sprint/status padrão, barra de progresso por tarefa
- **Toast motivacional** ao mover tarefa para status "Concluída" (7 frases aleatórias)
- Responsivo: task-row vira card em mobile (meta de status/prioridade inline)

**task-dialog** — modal criar/editar tarefa
- Campos: description, sprint_id, status_id, priority, epic, assignee_ids[]
- Aba **Caderno** (notas ricas):
  - Textarea grande (fundo amarelo-caderno), salva no backend via `PUT /api/tasks/:id { notes }`
  - Fallback localStorage se backend falhar (`avante-note-{taskId}`)
  - Upload de até 5 imagens/screenshots por tarefa (base64 em localStorage `avante-imgs-{taskId}`)
  - Galeria de miniaturas + visualizador fullscreen
  - Mensagem motivacional ao salvar (5 frases aleatórias)
- **Timer de execução**: inicia ao abrir a tarefa, persiste em localStorage (`avante-started-{taskId}`), exibido no header do dialog
- **Export PDF**: gera janela com descrição, meta, notas e imagens inline, dispara `window.print()`

**task-filters** — filtros horizontais
- Emite: `{ search, status_ids, priorities, assignee_ids }`

**sprint-manager** — gestão de sprints
- Criar/editar sprints (name, start_date, end_date)
- Botão "Finalizar Sprint" (ativo se vencida OU 100% concluída)

**status-manager** — gestão de status
- Criar/editar status (name, color hex, order)

**user-manager** — gestão de usuários
- Listar, criar, editar, deletar usuários (name, email, password, role)

**profile** — perfil do usuário autenticado
- Editar nome/email/bio/position
- Upload de avatar
- Mudar senha

### Componentes de UI compartilhados (shared/ui/)

| Componente     | Seletor           | Descrição                                       |
| -------------- | ----------------- | ----------------------------------------------- |
| Avatar         | `app-avatar`      | `[name]` iniciais, `[photoUrl]` foto, `[size]` sm/md/lg |
| Badge          | `app-badge`       | Indicador de status com cor                     |
| Button         | `app-button`      | Variantes: primary/secondary/danger, estados loading/disabled |
| ConfirmDialog  | `app-confirm-dialog` | Modal de confirmação genérico               |
| Modal          | `app-modal`       | Container genérico para modais                  |
| Pagination     | `app-pagination`  | Controle prev/next/números                      |
| Popover        | `app-popover`     | Menu flutuante / dropdown                       |
| Sidebar        | `app-sidebar`     | Barra lateral com abas                          |
| Tooltip        | `[appTooltip]`    | Diretiva: tooltip flutuante (render no body, flip automático, setinha) — `appTooltip="texto"` + `tooltipPlacement="top\\|bottom\\|left\\|right"` |

---

## 🔧 Services Angular

### api.ts (ApiService)
- Importa `environment.apiUrl` e `environment.backendUrl`
- Métodos: `getBoards`, `createBoard`, `updateBoard`, `deleteBoard`
- Métodos: `getTasks`, `createTask`, `updateTask`, `deleteTask`
- Métodos: `getSprints`, `createSprint`, `updateSprint`, `deleteSprint`, `finishSprint`
- Métodos: `getStatuses`, `createStatus`, `updateStatus`, `deleteStatus`
- Métodos: `getUsers`, `createUser`, `updateUser`, `deleteUser`
- Métodos: `getComments`, `createComment`, `deleteComment`
- Métodos: `getAttachments`, `uploadAttachment`, `deleteAttachment`
- Métodos: `getNotifications`, `getUnreadNotificationCount`, `markNotificationRead`, `markAllNotificationsRead`
- Métodos: `bulkUpdateTasks({ task_ids, status_id?, priority?, type?, sprint_id?, add_tag_id?, add_assignee_id? })`
- Métodos: `get/create/update/deleteMarketingPost|Lead|Idea|Campaign|Metric`, `upvoteMarketingIdea`
- Métodos: `getBoardAnalytics(boardId)`
- Métodos: `login`, `logout`, `getProfile`, `updateProfile`, `updatePassword`, `uploadAvatar`
- Helper: `resolveAvatarUrl(url)` → converte para URL absoluta

### auth.ts (Auth)
- Signal: `currentUser = signal<any>(loadUser())`
- LocalStorage keys: `avante_token`, `avante_user`
- `getToken()`, `isAuthenticated()`, `login()`, `logout()`, `clearSession()`

### theme.ts (Theme)
- Signal: `mode = signal<''light''|''dark''|''system''>(...)`, persistido em `localStorage(''avante_theme'')`
- Aplica/remove classe `.dark` em `document.documentElement` (reage a `prefers-color-scheme` quando `system`)
- `setMode()`, `toggle()`, `isDark()` — toggle exposto no `app-sidebar` (sol/lua) e na aba "Notificações" do perfil
- Tokens globais (`--bg`, `--surface`, `--border`, `--text-primary`, `--text-secondary`, `--accent`, `--accent-hover`, `--radius-*`, `--shadow*`) centralizados em `styles.scss` (`:root` claro / `html.dark` escuro); Angular Material recebe um segundo `mat.theme(theme-type: dark)` dentro de `html.dark`

### notifications.ts (Notifications)
- Signals: `items`, `unreadCount`; poll de `unread-count` a cada 45s (sem websockets — hosting sem processos persistentes)
- Usado pelo sino no `app-sidebar` (popover com lista, marca como lida ao clicar e navega até o board da tarefa)

### auth-interceptor.ts
- Adiciona `Authorization: Bearer {token}` em todas as requisições
- Trata 401: limpa localStorage e navega para `/login`

### auth-guard.ts
- CanActivateFn funcional
- Verifica `auth.isAuthenticated()` → senão redireciona para `/login`

---

## 🔑 Detalhes de implementação importantes

### Avatar — accessor no Model User

```php
public function getAvatarUrlAttribute($value): ?string {
    if (!$value) return null;
    if (str_starts_with($value, ''http'')) return $value;
    return url($value);
}
```

### Criar Board — status padrão automáticos

`BoardController::store` cria automaticamente 4 status:
- "Em Fila" (order 1)
- "Em Andamento" (order 2)
- "Em Revisão" (order 3)
- "Concluída" (order 4)

### Finalizar Sprint

- `POST /api/sprints/{id}/finish` com body `{ concluded_status_id: number | null }`
- Se `concluded_status_id` não vier, busca status por nome: "Concluído", "Concluido", "Done", "Finalizado"
- Encontra próxima sprint aberta do mesmo board
- Move tarefas não concluídas para a próxima sprint
- Preenche `finished_at = now()`
- Retorna: `{ message, overflow_count, next_sprint_id, next_sprint, sprint }`
- Botão ativo só quando sprint vencida OU 100% concluída

### Assignees (múltiplos por tarefa)

- Tabela pivot `task_user` (task_id, user_id — unique)
- Campo legado `assigned_to` ainda existe nas tasks mas é substituído por `assignee_ids[]`
- `TaskController::update` usa `syncWithoutDetaching` ou `sync` para o pivot

### Paginação de tasks

- **Ainda não existe** — `GET /api/tasks` devolve todas as tasks do board numa resposta só (sem `page`/`per_page` reais no backend, embora o tipo do método `getTasks` no `api.ts` já preveja os parâmetros)
- Filtros: `board_id`, `status_ids[]`, `priorities[]`, `assignee_ids[]`, `search`
- Ordenação local no frontend

### Caderno / Notas por tarefa

- Campo `notes` (longText, nullable) na tabela `tasks`
- Salvo via `PUT /api/tasks/:id` com `{ notes: string }`
- Frontend mantém cópia em localStorage (`avante-note-{taskId}`) como rascunho/fallback
- Imagens (base64) também em localStorage apenas (`avante-imgs-{taskId}`), array de `{ id, data, name }`
- Timer de execução em localStorage: `avante-started-{taskId}` = ISO timestamp do primeiro acesso

### JSON Bulk Import

- Formato: `[ { "description": "...", "priority": "Alta", "epic": "...", "sprint_id": null } ]`
- Campos opcionais: `priority` (default "Média"), `epic`, `sprint_id`, `status_id`
- Sprint/status padrão podem ser selecionados no modal (aplicados quando o item não especifica)
- Importação sequencial (uma tarefa por vez via `POST /api/tasks`), barra de progresso em tempo real
- Erros por item são listados mas não interrompem o restante da importação

### Menu placeholder (em breve)

- Sidebars de `board-list` e `task-list` têm o item "EduCore" (Analytics deixou de ser placeholder em 02/07/2026 — ver histórico de decisões)
- Badge âmbar "Em breve" visível quando sidebar expandida
- Clicar exibe toast roxo gradiente "Funcionalidade em evolução. Em breve!"
- Implementar ao integrar com EduCore (leitor de PDFs em `C:\\Users\\UITEC\\Herd\\EduCore`)

---

## 🚫 Limitações do servidor (shared hosting Hostinger)

| Recurso                    | Situação                                             |
| -------------------------- | ---------------------------------------------------- |
| `exec()` no PHP            | ❌ Bloqueado                                         |
| `shell_exec()` no PHP      | ❌ Bloqueado (impede php artisan tinker)             |
| `php artisan storage:link` | ❌ Usar `ln -s ../storage/app/public public/storage` |
| Queues em background       | ❌ Não disponível                                    |
| Cron jobs                  | ✅ hPanel                                            |
| SSH                        | ✅ Porta 65002                                       |
| MySQL via CLI              | ✅ Usar mysql diretamente no SSH                     |

---

## 🔄 Fluxo de deploy

```bash
# LOCAL
cd frontend
ng build
cd ..
git add .
git commit -m "feat: descrição"
git push origin main

# SERVIDOR
ssh -p 65002 u846585591@147.93.39.159
cd ~/domains/devmorais.com.br/public_html/avante
git pull origin main
cd backend
php artisan config:cache && php artisan route:cache
```

> ⚠️ `php artisan tinker` não funciona no servidor (shell_exec bloqueado).
> Para operações no banco, usar MySQL direto via SSH:
> `mysql -u u846585591_gestao_tarefas -p''SENHA'' -h 127.0.0.1 u846585591_gestao_tarefas -e "SQL AQUI;"`

---

## 📦 O que NÃO vai pro Git

```
backend/.env
backend/.env.backup
backend/.env.production
backend/vendor/
backend/public/build/
frontend/node_modules/
frontend/.angular/
/public              (junction local do Herd)
DEPLOY.md
.claude
```

---

## 📦 Dependências principais

### Frontend (Angular 21)
- `@angular/core`, `@angular/router`, `@angular/forms` — ^21.2.17
- `@angular/material`, `@angular/cdk` — ^21.2.14
- `tailwindcss` — ^3.4.0
- `rxjs` — ~7.8.0
- `typescript` — ~5.9.2

### Backend (Laravel 13)
- `laravel/framework` — ^13.8
- `laravel/sanctum` — ^4.0
- `php` — ^8.3

---

## 📝 Histórico de decisões técnicas

| Data       | Decisão                                                       | Motivo                                                      |
| ---------- | ------------------------------------------------------------- | ----------------------------------------------------------- |
| 23/06/2026 | Build Angular → `backend/public/`                             | Shared hosting sem virtual hosts                            |
| 23/06/2026 | Sanctum para autenticação                                     | API stateless com tokens                                    |
| 23/06/2026 | SESSION/QUEUE/CACHE → database                                | Shared hosting sem Redis/supervisord                        |
| 23/06/2026 | accessor `getAvatarUrlAttribute`                              | URL absoluta em todos endpoints                             |
| 23/06/2026 | `public-static/` como fonte de assets fixos                   | Evitar que ng build apague index.php e .htaccess do Laravel |
| 23/06/2026 | environments Angular (environment.ts / environment.prod.ts)   | API URL correta por ambiente sem hardcode                   |
| 23/06/2026 | Finalizar sprint transborda tarefas                           | Nada se perde ao encerrar um ciclo                          |
| 23/06/2026 | Barra de progresso colorida por status                        | Visibilidade rápida do andamento                            |
| 23/06/2026 | MySQL via CLI no SSH para operações no banco                  | php artisan tinker bloqueado por shell_exec() no Hostinger  |
| 23/06/2026 | task_user pivot para múltiplos assignees                      | Uma tarefa pode ter vários responsáveis                     |
| 23/06/2026 | Componentes shared/ui/ reutilizáveis                          | Consistência visual e redução de duplicação                 |
| 24/06/2026 | notes salvo no backend (longText) + fallback localStorage     | Notas disponíveis em qualquer dispositivo; offline degrada graciosamente |
| 24/06/2026 | Imagens do caderno em base64 no localStorage (não no banco)   | Shared hosting bloqueia exec(); banco não tem storage de blobs; IndexedDB seria melhor no futuro |
| 24/06/2026 | Timer de execução em localStorage por tarefa                  | Sem backend para tempo — persiste entre sessões no mesmo browser |
| 24/06/2026 | JSON import sequencial (não paralelo)                         | Evita sobrecarga no shared hosting; barra de progresso dá feedback real |
| 24/06/2026 | Menus Analytics/EduCore como placeholder com badge "Em breve" | Reservar espaço na UI antes de desenvolver; não criar expectativa sem entrega |
| 02/07/2026 | Marketing/Analytics deixaram de ser placeholder (`app-construction`) e viraram componentes reais (`app-marketing`, `app-analytics`) | Board de Marketing (id 14) já em uso real; dados agregados a partir do próprio banco (tasks/sprints/statuses), sem custo de infra novo |
| 02/07/2026 | Marketing é ferramenta interna (calendário/pipeline/ideias/campanhas/desempenho), sem integração real com Graph API do Instagram | Publicação automática exige App Meta for Developers + aprovação, fora do escopo de uma sessão de código; "Publicar no Instagram" vira compor/agendar (status idea/scheduled/published), publicação em si manual |
| 02/07/2026 | `tasks.completed_at` preenchido automaticamente ao entrar no status "concluído" (nome via `Status::concludedIdFor`, mesma lógica do finish de sprint) | Sem isso não existe dado histórico para calcular velocidade/cycle time/burndown no Analytics |
| 02/07/2026 | `POST /api/tasks/bulk-update` único em vez de N requisições PUT em loop | Barra de ações em massa mais rápida e ganha ações novas (Tipo, Tags) sem multiplicar chamadas HTTP |
| 02/07/2026 | Notificações in-app com tabela própria (não o sistema `Notifiable` nativo do Laravel) | Precisa ser lida/listada pelo frontend via API simples; polling a cada 45s no sino do sidebar (sem websockets, hosting sem processo persistente) |
| 02/07/2026 | Anexos de tarefa no servidor (`storage/app/public`, mesmo padrão do avatar) em vez de localStorage | Precisam ser baixáveis por qualquer pessoa do quadro, não só por quem enviou — diferente do "Caderno" (pessoal, local) |
| 02/07/2026 | Dark mode via classe `.dark` em `<html>` + tokens CSS centralizados em `styles.scss` | Componentes já usavam os mesmos nomes de variável duplicados por arquivo; centralizar foi suficiente para o tema propagar sem reescrever cada tela |
| 02/07/2026 | WhatsApp: infraestrutura completa (opt-in no perfil, `WhatsAppGateway` HTTP plugável, comando `app:notify-whatsapp-digest` agendado) sem conectar um provedor real | Sem conta/credenciais de um gateway (Z-API/UltraMsg/Meta Cloud API) ainda; serviço loga em vez de enviar quando `WHATSAPP_API_URL` não está no `.env` — plugar depois é só configurar o `.env` |
| 04/07/2026 | Backlog do board 8 (produção) zerado e recriado do zero, ancorado numa auditoria técnica de código (não em suposições) | O board anterior tinha ~1/3 das tarefas marcadas "Concluída" sem nenhuma linha de código correspondente (due_date/story_points/checklist nunca existiram) e ~1/5 de recursos já prontos (Kanban, dark mode, tags, notificações) sem status nenhum — os dados não eram confiáveis para planejar o próximo passo |
| 04/07/2026 | Demandas do novo plano são independentes e full-stack (sem split backend/frontend por pessoa) | Evita bloqueio de uma pessoa esperando a outra; Fernando e Claudia executam tanto back quanto front, complexidade decide quem pega cada uma |
',
  'Alta',
  'Meta: Documentação Viva',
  0,
  NOW(), NOW()
);

-- ============================================================
-- PARTE 4 — SPRINT 1: Segurança & Isolamento (Crítico)
-- ============================================================

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 1 — Segurança & Isolamento (Crítico)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-01] Isolar dados entre clientes (multi-tenancy real)

📖 CONTEXTO
Hoje a tabela `boards` não tem dono nenhum: `BoardController::index()` faz `Board::orderByDesc("created_at")->get()` e devolve TODOS os boards do banco pra qualquer usuário autenticado, de qualquer empresa. Enquanto o Avante for uso interno isso não incomoda, mas pra vender pra mais de um cliente é um vazamento de dados entre empresas diferentes — inaceitável comercialmente. Esta é a demanda mais importante do plano inteiro: sem isso, nada mais aqui importa, porque não dá pra vender pra um segundo cliente com segurança.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\UITEC\Herd\gestao-tarefas\backend (ajuste o caminho se necessário)
2. Confirme que o ambiente local roda em http://gestao-tarefas.test
3. git checkout main && git pull origin main
4. git checkout -b feature/d-01-multi-tenancy
5. Leia primeiro: `app/Models/Board.php`, `app/Models/User.php`, `app/Http/Controllers/BoardController.php` (método index)

📂 ARQUIVOS ENVOLVIDOS
- database/migrations/XXXX_create_companies_table.php (CRIAR) — tabela companies: id, name, timestamps, soft delete
- database/migrations/XXXX_add_company_id_to_users_and_boards.php (CRIAR) — company_id (foreignId, nullable no primeiro momento pra migrar dados existentes) em users e boards
- app/Models/Company.php (CRIAR) — hasMany(User), hasMany(Board)
- app/Models/User.php (EDITAR) — belongsTo(Company)
- app/Models/Board.php (EDITAR) — belongsTo(Company)
- app/Http/Controllers/BoardController.php (EDITAR) — index() e store() escopados por `auth()->user()->company_id`
- database/seeders (CRIAR seeder ou script one-off) — cria 1 Company para os dados já existentes (Fernando/Claudia + todos os boards atuais) pra não quebrar produção na migração

📋 CRITÉRIOS DE ACEITE
- [ ] Migration cria tabela companies e a coluna company_id em users e boards
- [ ] Script/seeder de migração de dados: cria uma Company para os usuários e boards já existentes em produção, preenchendo company_id neles (nenhum board órfão)
- [ ] BoardController::index() retorna somente boards da company do usuário autenticado
- [ ] BoardController::store() grava automaticamente o company_id do usuário autenticado no novo board (campo não vem do payload do cliente)
- [ ] Tentar acessar (GET/PUT/DELETE) um board de outra company retorna 404, não 200 com dado vazado
- [ ] Novo usuário só pode ser criado dentro da própria company (ver D-02 para a trava de UserController)
- [ ] Teste manual: criar 2 companies de teste, confirmar que usuário da Company A não vê nenhum board da Company B

🤖 PROMPT PARA A IA
"Laravel 13, projeto Avante (gestão de tarefas). Preciso adicionar multi-tenancy por company. Gere: (1) migration create_companies_table (id, name, timestamps, soft deletes); (2) migration adicionando company_id (foreignId nullable, depois tornar not null) em users e boards; (3) Model Company com hasMany para User e Board; (4) relação belongsTo(Company) em User e Board; (5) em BoardController, escopar index() e store() por auth()->user()->company_id, e em show/update/destroy usar findOrFail dentro de Board::where(company_id, ...) em vez de Board::findOrFail direto. Mostre todos os arquivos. Não mude nada relacionado a autorização por role dentro de uma company — isso é outra demanda (D-02)."

🚀 QUANDO TERMINAR
1. Rode a migration em ambiente local e confirme que nenhum board fica orfão
2. git add . && git commit -m "feat(D-01): isolamento multi-tenant por company em boards e users"
3. git push -u origin HEAD e abra PR (base: main) — NÃO faça merge sozinho, avise o responsável do projeto
4. Atualize o CLAUDE.md (seção Banco de dados e Histórico de decisões) com a tabela companies
5. Marque este item como concluído aqui e comente na tarefa [META-01] o que mudou',
  'Urgente',
  'Segurança & Multi-tenant',
  'Melhoria',
  1,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 1 — Segurança & Isolamento (Crítico)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-02] Autorização por recurso em todos os controllers (Policies)

📖 CONTEXTO
Auditoria confirmou que nenhum controller do Avante checa posse do recurso — só existe o middleware auth:sanctum (routes/api.php linha 27), que garante "usuário logado" mas não "usuário autorizado a mexer NESTE board/task/comentário". `TaskController::show/update/destroy`, `BoardController::show/update/destroy`, `SprintController::update/destroy/finish`, `StatusController::update/destroy`, `CommentController::destroy` e o controller de attachments fazem todos apenas findOrFail($id) sem checar nada além de o registro existir. Pior: `UserController::store/update/destroy` deixa qualquer usuário autenticado criar contas, promover qualquer usuário a Administrador ou deletar contas — não existe Policy, Gate nem authorize() em nenhum lugar do projeto. Depende de D-01 estar mergeado (precisa do conceito de company para a Policy saber o que é "dono").

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\UITEC\Herd\gestao-tarefas\backend
2. Confirme que D-01 (company_id) já foi mergeado na main antes de começar
3. git checkout main && git pull origin main
4. git checkout -b feature/d-02-policies-autorizacao

📂 ARQUIVOS ENVOLVIDOS
- app/Policies/BoardPolicy.php (CRIAR)
- app/Policies/TaskPolicy.php (CRIAR)
- app/Policies/SprintPolicy.php (CRIAR)
- app/Policies/StatusPolicy.php (CRIAR)
- app/Policies/CommentPolicy.php (CRIAR)
- app/Policies/AttachmentPolicy.php (CRIAR)
- app/Providers/AppServiceProvider.php (EDITAR) — registrar as Policies
- app/Http/Controllers/BoardController.php, TaskController.php, SprintController.php, StatusController.php, CommentController.php, AttachmentController.php (EDITAR) — chamar $this->authorize() em show/update/destroy
- app/Http/Controllers/UserController.php (EDITAR) — travar store/update/destroy atrás de checagem de role Administrador, e impedir que um usuário mude o próprio role ou o de outro fora da própria company

📋 CRITÉRIOS DE ACEITE
- [ ] Cada Policy checa que o board/task/sprint/status/comentário/anexo pertence à company do usuário autenticado (via company_id do board relacionado)
- [ ] Usuário de uma company tentando editar/apagar recurso de outra company recebe 403
- [ ] CommentPolicy e AttachmentPolicy adicionalmente permitem exclusão só pelo autor do comentário/anexo OU um Administrador da mesma company
- [ ] UserController::store/update/destroy só funciona para quem tem role Administrador
- [ ] Um usuário não-admin não consegue se autopromover a Administrador via PUT /api/users/{id}
- [ ] Teste manual com 2 usuários de companies diferentes confirmando os 403 em cada recurso

🤖 PROMPT PARA A IA
"Laravel 13, projeto Avante. Já existe company_id em users e boards (D-01 mergeado). Gere Policies para Board, Task, Sprint, Status, Comment e Attachment — cada uma com métodos view/update/delete checando que o recurso (diretamente ou via relação até o board) tem o mesmo company_id do usuário autenticado. Registre no AppServiceProvider. Nos controllers correspondentes, adicione $this->authorize(update ou delete, $model) antes de qualquer alteração. Em UserController, adicione um gate ou checagem simples (auth()->user()->role igual a Administrador) em store/update/destroy, e impeça que o campo role seja alterado por quem não é Administrador. Mostre todos os arquivos alterados."

🚀 QUANDO TERMINAR
1. Teste manual com 2 usuários/companies diferentes tentando acessar recursos um do outro
2. git add . && git commit -m "feat(D-02): Policies de autorização por recurso e trava de UserController"
3. git push -u origin HEAD e abra PR (base: main)
4. Atualize o CLAUDE.md se a forma de autorização mudar algo documentado
5. Marque como concluído e comente em [META-01]',
  'Urgente',
  'Segurança & Multi-tenant',
  'Melhoria',
  2,
  NOW(), NOW()
);

-- ============================================================
-- PARTE 5 — SPRINT 2: Prontidão de Produção (Alto)
-- ============================================================

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 2 — Prontidão de Produção (Alto)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-03] Rate limiting no login + recuperação de senha

📖 CONTEXTO
`routes/api.php` registra POST /login sem nenhum throttle — hoje é possível tentar senhas infinitamente sem bloqueio (força bruta). Também não existe fluxo de "esqueci minha senha": nenhuma rota /forgot-password ou /reset-password, nenhum uso do Password facade em todo o projeto. Um cliente pagante esquecendo a senha hoje fica sem alternativa a não ser pedir pra um admin trocar manualmente no banco.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\UITEC\Herd\gestao-tarefas\backend
2. git checkout main && git pull origin main
3. git checkout -b feature/d-03-rate-limit-reset-senha
4. Confirme MAIL_MAILER=log no .env local (não precisa enviar e-mail real em dev)

📂 ARQUIVOS ENVOLVIDOS
- app/Providers/AppServiceProvider.php (EDITAR) — RateLimiter::for("login") e RateLimiter::for("api")
- routes/api.php (EDITAR) — aplicar throttle:login na rota de login; throttle:api no grupo autenticado
- app/Http/Controllers/AuthController.php (EDITAR ou CRIAR os métodos) — forgotPassword() e resetPassword()
- resources/views/emails/reset_password.blade.php (CRIAR) — corpo do e-mail com o link de reset
- frontend/src/app/components/login/ (EDITAR) — link "Esqueci minha senha", tela de solicitar reset e tela de definir nova senha
- frontend/src/app/services/api.ts (EDITAR) — métodos forgotPassword(email) e resetPassword(token, password)
- frontend/src/app/app.routes.ts (EDITAR) — rotas /forgot-password e /reset-password/:token

📋 CRITÉRIOS DE ACEITE
- [ ] Login: máximo de 10 tentativas por minuto por IP; excedendo, retorna HTTP 429 com header Retry-After
- [ ] Rotas autenticadas: throttle geral de 120 requisições por minuto por usuário
- [ ] POST /api/forgot-password recebe email, gera token (usa o mecanismo nativo de password reset do Laravel) e envia e-mail com link
- [ ] POST /api/reset-password recebe token + nova senha, valida o token e atualiza a senha
- [ ] Frontend: tela de login com link "Esqueci minha senha", formulário de e-mail, e tela de definir nova senha a partir do link recebido
- [ ] Token expirado ou inválido mostra mensagem clara ao usuário, não um erro genérico
- [ ] Teste manual: solicitar reset, pegar o link do storage/logs/laravel.log (MAIL_MAILER=log), definir nova senha e logar com ela

🤖 PROMPT PARA A IA
"Laravel 13 + Angular 21 standalone, projeto Avante. Preciso de: (1) RateLimiter::for(login) com 10 tentativas por minuto por IP e RateLimiter::for(api) com 120 por minuto por usuário autenticado, aplicados em routes/api.php; (2) fluxo de recuperação de senha usando o sistema nativo do Laravel (Password::sendResetLink, Password::reset) com dois endpoints: POST /api/forgot-password (email) e POST /api/reset-password (token, email, password, password_confirmation); (3) no Angular, tela de login com link para /forgot-password, formulário simples de e-mail, e tela /reset-password/:token com campo de nova senha, ambas standalone components com Signals. Mostre todos os arquivos back e front."

🚀 QUANDO TERMINAR
1. Teste 11 tentativas de login erradas seguidas — a 11ª deve retornar 429
2. Teste o fluxo completo de reset de senha usando o log de e-mail
3. git add . && git commit -m "feat(D-03): rate limiting na API e fluxo de recuperação de senha"
4. git push -u origin HEAD e abra PR (base: main)
5. Marque como concluído e comente em [META-01]',
  'Alta',
  'Prontidão de Produção',
  'Melhoria',
  3,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 2 — Prontidão de Produção (Alto)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-04] Validar tipo de arquivo nos anexos de tarefa

📖 CONTEXTO
`AttachmentController::store` valida só `required|file|max:10240` — nenhum mime-type ou extensão é checado. Isso significa que qualquer pessoa com acesso a uma tarefa pode subir um .php, .exe ou .html (XSS armazenado), e como o storage é público (servido direto, mesmo padrão do avatar), um .php nessa pasta pode virar execução remota dependendo da configuração do Hostinger. É a única lacuna de segurança de upload no sistema — o avatar e o ícone de board já usam a regra `image` do Laravel, que valida conteúdo de verdade.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\Claudia\Herd\gestao-tarefas\backend
2. git checkout main && git pull origin main
3. git checkout -b feature/d-04-validar-upload-anexos
4. Leia primeiro: app/Http/Controllers/AttachmentController.php e compare com ProfileController::uploadAvatar (que já valida direito)

📂 ARQUIVOS ENVOLVIDOS
- app/Http/Controllers/AttachmentController.php (EDITAR) — método store()
- config/filesystems.php (CONSULTAR, não deve precisar editar)

📋 CRITÉRIOS DE ACEITE
- [ ] Lista de extensões permitidas definida explicitamente (ex.: pdf, doc, docx, xls, xlsx, ppt, pptx, png, jpg, jpeg, webp, gif, txt, csv, zip) — sem executáveis nem scripts
- [ ] Validação usa `mimes:` do Laravel (checa assinatura real do arquivo, não só a extensão do nome)
- [ ] Upload de um arquivo .php ou .exe renomeado com extensão permitida (ex. foto.php.png) é rejeitado
- [ ] Mensagem de erro clara para o usuário quando o tipo não é permitido
- [ ] Anexos já existentes no board não são afetados (validação só vale para novos uploads)
- [ ] Teste manual: tentar subir um .exe e confirmar rejeição; subir um .pdf normal e confirmar sucesso

🤖 PROMPT PARA A IA
"Laravel 13, projeto Avante, AttachmentController::store(). Hoje a validação é só required|file|max:10240. Adicione mimes: com uma lista explícita de extensões seguras (documentos e imagens comuns, sem executáveis/scripts), mantendo max:10240 (10MB). Mostre o método store() completo já corrigido."

🚀 QUANDO TERMINAR
1. Teste subindo um .exe (deve rejeitar) e um .pdf (deve aceitar)
2. git add . && git commit -m "fix(D-04): valida mime/extensão real no upload de anexos de tarefa"
3. git push -u origin HEAD e abra PR (base: main)
4. Marque como concluído e comente em [META-01]',
  'Alta',
  'Prontidão de Produção',
  'Bug',
  4,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 2 — Prontidão de Produção (Alto)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-05] Confirmação antes de excluir comentário ou anexo

📖 CONTEXTO
No task-list, apagar uma tarefa ou um board passa pelo ConfirmDialog compartilhado — mas `onRemoveComment` (task-list.ts, por volta da linha 644) e `onRemoveAttachment` (por volta da linha 677) chamam a exclusão direto no clique, sem confirmação nenhuma. No caso do anexo isso é ainda mais grave: o arquivo enviado por outra pessoa é apagado do storage sem chance de desistir. É uma inconsistência simples de UX que gera perda de dado real.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\Claudia\Herd\gestao-tarefas\frontend
2. git checkout main && git pull origin main
3. git checkout -b feature/d-05-confirmar-exclusao-comentario-anexo
4. npm install && npx ng serve
5. Leia primeiro como askDeleteTask/deleteDialogOpen/confirmDeleteTask já fazem isso pra task, em task-list.ts

📂 ARQUIVOS ENVOLVIDOS
- frontend/src/app/components/task-list/task-list.ts (EDITAR) — onRemoveComment e onRemoveAttachment
- frontend/src/app/components/task-list/task-list.html (EDITAR) — reusar app-confirm-dialog já existente

📋 CRITÉRIOS DE ACEITE
- [ ] Clicar em excluir comentário abre o ConfirmDialog com mensagem específica ("Excluir este comentário?") antes de chamar a API
- [ ] Clicar em excluir anexo abre o ConfirmDialog com mensagem específica ("Excluir o arquivo {nome}? Esta ação não pode ser desfeita.") antes de chamar a API
- [ ] Cancelar no diálogo não exclui nada
- [ ] Confirmar exclui normalmente como já acontecia antes (sem quebrar o fluxo existente)
- [ ] Mesmo padrão visual/estado usado no diálogo de exclusão de task (reaproveitar o componente, não criar um novo)

🤖 PROMPT PARA A IA
"Angular 21 standalone, projeto Avante, task-list component. Hoje onRemoveComment(id) e onRemoveAttachment(id) chamam apiService.deleteComment/deleteAttachment direto no clique. Quero que sigam o mesmo padrão já usado em askDeleteTask/confirmDeleteTask (que usa o app-confirm-dialog compartilhado): ao clicar, guardar o id pendente num signal, abrir o dialog com uma mensagem específica, e só chamar a API de fato no confirm. Mostre as mudanças em task-list.ts e task-list.html reaproveitando o app-confirm-dialog já usado para tasks."

🚀 QUANDO TERMINAR
1. Teste excluir um comentário e um anexo, confirmando que o diálogo aparece nos dois casos
2. git add . && git commit -m "fix(D-05): confirmação antes de excluir comentário e anexo"
3. git push -u origin HEAD e abra PR (base: main)
4. Marque como concluído e comente em [META-01]',
  'Alta',
  'Prontidão de Produção',
  'Bug',
  5,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 2 — Prontidão de Produção (Alto)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-06] Paginação real de tarefas (backend + frontend)

📖 CONTEXTO
`TaskController::index` devolve `$query->get()` sem paginar — o board inteiro é carregado numa resposta só, tanto na visão Tabela quanto na Kanban. Funciona bem com dezenas de tarefas, mas degrada conforme o board cresce (mais clientes, mais tarefas acumuladas). O tipo do método `getTasks` em `api.ts` já prevê `page`/`per_page`, mas nada no código realmente usa isso hoje.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\UITEC\Herd\gestao-tarefas (backend e frontend)
2. git checkout main && git pull origin main
3. git checkout -b feature/d-06-paginacao-real
4. Pense no impacto na visão Kanban: colunas não devem paginar do mesmo jeito que a lista — ver critério específico abaixo

📂 ARQUIVOS ENVOLVIDOS
- backend/app/Http/Controllers/TaskController.php (EDITAR) — método index()
- frontend/src/app/services/api.ts (EDITAR) — getTasks já tem o tipo, confirmar uso real dos parâmetros
- frontend/src/app/components/task-list/task-list.ts (EDITAR) — loadTasks(), estado de página atual
- frontend/src/app/shared/ui/pagination/ (EDITAR) — reaproveitar componente já existente

📋 CRITÉRIOS DE ACEITE
- [ ] GET /api/tasks aceita page e per_page (default per_page=50), retorna meta de paginação (total, current_page, last_page)
- [ ] Visão Tabela do task-list usa a paginação real (troca de página chama a API de novo com os filtros atuais)
- [ ] Visão Kanban continua carregando todas as tarefas do board de uma vez (não faz sentido paginar por coluna) — usar um parâmetro explícito tipo `all=true` nessa chamada específica, documentado no código
- [ ] Filtros (status, prioridade, assignee, busca, tags, épico) continuam funcionando junto com a paginação
- [ ] Ordenação por sort_order preservada dentro de cada página

🤖 PROMPT PARA A IA
"Laravel 13 + Angular 21, projeto Avante. Em TaskController::index, adicionar paginação real: aceitar page e per_page (default 50), usar paginate() do Eloquent mantendo todos os filtros existentes (board_id, status_ids, priorities, assignee_ids, search, tag_ids, epics), retornar {data, meta: {total, current_page, last_page}}. Adicionar um parâmetro all=true que, quando presente, ignora a paginação e devolve tudo (usado pela visão Kanban). No Angular, no task-list, adaptar loadTasks() para a visão Tabela consumir a paginação real com o componente app-pagination já existente, e a visão Kanban continuar pedindo all=true. Mostre as mudanças em ambos os lados."

🚀 QUANDO TERMINAR
1. Teste a visão Tabela com paginação e a visão Kanban carregando tudo, nos dois casos com filtros ativos
2. git add . && git commit -m "feat(D-06): paginação real de tarefas na visão Tabela, mantendo Kanban completo"
3. git push -u origin HEAD e abra PR (base: main)
4. Atualize o CLAUDE.md (seção API e task-list) removendo a nota de "sem paginação"
5. Marque como concluído e comente em [META-01]',
  'Alta',
  'Prontidão de Produção',
  'Melhoria',
  6,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 2 — Prontidão de Produção (Alto)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-07] Testes automatizados: autenticação, autorização e isolamento entre companies

📖 CONTEXTO
`backend/tests` hoje só tem o esqueleto padrão do `laravel new` (ExampleTest.php em Feature e Unit, sem nenhuma asserção de negócio). Depois de D-01 (multi-tenancy) e D-02 (Policies) entrarem, essas são exatamente as áreas mais arriscadas de quebrar silenciosamente em qualquer mudança futura — por isso ficam cobertas primeiro, antes das demais.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\UITEC\Herd\gestao-tarefas\backend
2. Confirme que D-01 e D-02 já estão mergeados na main
3. git checkout main && git pull origin main
4. git checkout -b feature/d-07-testes-auth-autorizacao
5. Crie .env.testing copiando de .env e ajustando DB_CONNECTION=sqlite, DB_DATABASE=:memory:

📂 ARQUIVOS ENVOLVIDOS
- backend/.env.testing (CRIAR)
- backend/tests/Feature/AuthTest.php (CRIAR)
- backend/tests/Feature/MultiTenancyTest.php (CRIAR)
- backend/tests/Feature/AuthorizationTest.php (CRIAR)

📋 CRITÉRIOS DE ACEITE
- [ ] .env.testing configurado com SQLite em memória, RefreshDatabase em todos os testes
- [ ] AuthTest: login com credenciais válidas retorna 200 + token; credenciais inválidas retornam 401; 11 tentativas seguidas de login errado retornam 429 na 11ª (cobre D-03)
- [ ] MultiTenancyTest: cria 2 companies com 1 usuário cada, confirma que usuário da Company A não aparece na listagem de boards da Company B (GET /api/boards)
- [ ] AuthorizationTest: usuário sem role Administrador tentando POST /api/users recebe 403; usuário tentando editar/apagar board de outra company recebe 403 ou 404
- [ ] Mínimo de 15 assertions no total entre os 3 arquivos
- [ ] php artisan test roda tudo com sucesso (barra verde)

🤖 PROMPT PARA A IA
"Laravel 13, projeto Avante. Criar testes Feature com RefreshDatabase e SQLite em memória. AuthTest: POST /api/login válido (200+token), inválido (401), força bruta (11 tentativas seguidas, a 11ª retorna 429). MultiTenancyTest: 2 companies via factory, cada uma com 1 usuário e 1 board, confirmar isolamento em GET /api/boards com actingAs. AuthorizationTest: usuário role Usuario tentando POST /api/users (403), usuário de uma company tentando PUT num board de outra company (403 ou 404). Mostre os 3 arquivos de teste completos."

🚀 QUANDO TERMINAR
1. Rode php artisan test e confirme que tudo passa
2. git add . && git commit -m "test(D-07): cobertura de autenticação, multi-tenancy e autorização"
3. git push -u origin HEAD e abra PR (base: main)
4. Marque como concluído e comente em [META-01]',
  'Alta',
  'Prontidão de Produção',
  'Tarefa',
  7,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 2 — Prontidão de Produção (Alto)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-08] Testes automatizados: CRUD de boards, tasks, sprints e status

📖 CONTEXTO
Complementa D-07: enquanto aquela cobre autenticação/autorização/multi-tenancy, esta cobre o CRUD funcional do dia a dia do sistema — criar board (e confirmar que os 4 status padrão nascem junto), criar/editar/apagar task, finalizar sprint com transbordo de tarefas, apagar status e confirmar que as tasks ficam com status_id nulo. Hoje nada disso tem teste algum.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\Claudia\Herd\gestao-tarefas\backend
2. git checkout main && git pull origin main
3. git checkout -b feature/d-08-testes-crud
4. Confirme .env.testing (criado em D-07) — se D-07 ainda não foi mergeado, crie você mesmo seguindo o mesmo padrão

📂 ARQUIVOS ENVOLVIDOS
- backend/tests/Feature/BoardTest.php (CRIAR)
- backend/tests/Feature/TaskTest.php (CRIAR)
- backend/tests/Feature/SprintTest.php (CRIAR)
- backend/tests/Feature/StatusTest.php (CRIAR)

📋 CRITÉRIOS DE ACEITE
- [ ] BoardTest: criar board autentica, cria automaticamente os 4 status padrão (Em Fila, Em Andamento, Em Revisão, Concluída)
- [ ] TaskTest: CRUD completo (create 201, read 200, update 200, delete 200) como usuário autenticado e dono do board
- [ ] TaskTest: sincronização de assignee_ids via pivot task_user (adicionar e remover responsável)
- [ ] SprintTest: criar sprint, finalizar sprint com tasks não concluídas, confirmar que elas transbordam pra próxima sprint aberta e finished_at é preenchido
- [ ] StatusTest: apagar um status usado por tasks existentes, confirmar que essas tasks ficam com status_id nulo (não quebra, não apaga a task)
- [ ] Mínimo de 20 assertions no total
- [ ] php artisan test roda tudo com sucesso

🤖 PROMPT PARA A IA
"Laravel 13, projeto Avante. Criar testes Feature (RefreshDatabase, SQLite em memória, actingAs com User::factory). BoardTest: POST /api/boards cria board e verifica os 4 status padrão criados junto. TaskTest: CRUD completo de /api/tasks e sincronização de assignee_ids via PUT. SprintTest: criar sprint, popular com tasks não concluídas, chamar POST /api/sprints/{id}/finish e verificar overflow_count e next_sprint_id. StatusTest: DELETE de um status com tasks vinculadas, confirmar status_id nulo nessas tasks depois. Mostre os 4 arquivos de teste completos."

🚀 QUANDO TERMINAR
1. Rode php artisan test e confirme que tudo passa (incluindo os testes de D-07 se já existirem)
2. git add . && git commit -m "test(D-08): cobertura de CRUD de boards, tasks, sprints e status"
3. git push -u origin HEAD e abra PR (base: main)
4. Marque como concluído e comente em [META-01]',
  'Alta',
  'Prontidão de Produção',
  'Tarefa',
  8,
  NOW(), NOW()
);

-- ============================================================
-- PARTE 6 — SPRINT 3: Qualidade & Experiência (Médio)
-- ============================================================

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 3 — Qualidade & Experiência (Médio)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-09] Busca completa: description + notes + comentários

📖 CONTEXTO
A busca hoje (TaskController.php, por volta da linha 42) é um LIKE simples só no campo description — ignora o Caderno (notes) e os comentários, e não tem índice fulltext, então piora conforme o volume de tarefas cresce. Um usuário procurando algo que anotou no Caderno de uma tarefa simplesmente não encontra nada.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\UITEC\Herd\gestao-tarefas\backend
2. git checkout main && git pull origin main
3. git checkout -b feature/d-09-busca-completa

📂 ARQUIVOS ENVOLVIDOS
- backend/app/Http/Controllers/TaskController.php (EDITAR) — método index(), query de busca
- backend/database/migrations/XXXX_add_fulltext_index_to_tasks.php (CRIAR, opcional) — índice fulltext em description e notes se o MySQL do hosting suportar (InnoDB com MySQL 5.6+, deve suportar)

📋 CRITÉRIOS DE ACEITE
- [ ] Busca passa a considerar description E notes (case-insensitive)
- [ ] Busca também encontra tarefas por conteúdo de comentário (join com a tabela comments)
- [ ] Campo calculado match_in retorna onde bateu (description, notes ou comment), pra o frontend eventualmente destacar
- [ ] Sem duplicar a mesma task na resposta quando o termo aparece em mais de um lugar
- [ ] Performance aceitável testada com pelo menos 200 tasks de teste (usar tinker local ou factory)

🤖 PROMPT PARA A IA
"Laravel 13, projeto Avante, TaskController::index(). A busca hoje é where(description, like, %termo%). Expanda para também considerar notes (mesmo campo da tabela tasks) e o conteúdo de comments relacionados, usando orWhereHas para comments. Adicione ao retorno um campo match_in (array com os valores description/notes/comment conforme onde bateu). Garanta distinct() para não duplicar linhas. Mostre o método index() completo já ajustado."

🚀 QUANDO TERMINAR
1. Teste buscando um termo que só existe no Caderno de uma tarefa e confirme que ela aparece
2. git add . && git commit -m "feat(D-09): busca completa em description, notes e comentários"
3. git push -u origin HEAD e abra PR (base: main)
4. Marque como concluído e comente em [META-01]',
  'Média',
  'Qualidade & Experiência',
  'Melhoria',
  9,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 3 — Qualidade & Experiência (Médio)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-10] Filtros que faltam: tipo, sprint, atrasadas e intervalo de datas

📖 CONTEXTO
`task-filters.ts` hoje só tem search, status_ids, priorities, assignee_ids, epics e tag_ids. Faltam filtros óbvios: por tipo de tarefa (o campo existe e é usado na barra de ações em massa, mas não como filtro), por sprint específica, por intervalo de datas de criação, e "atrasadas" (a lógica isSprintOverdue já existe internamente no task-list, por volta da linha 384, mas nunca virou um filtro que o usuário possa aplicar). Vale para as duas visões (Tabela e Kanban).

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\Claudia\Herd\gestao-tarefas\frontend
2. git checkout main && git pull origin main
3. git checkout -b feature/d-10-filtros-faltantes
4. npm install && npx ng serve

📂 ARQUIVOS ENVOLVIDOS
- frontend/src/app/components/task-filters/task-filters.ts (EDITAR) — interface TaskFilterValue, novos signals
- frontend/src/app/components/task-filters/task-filters.html (EDITAR) — novos dropdowns/campos
- frontend/src/app/components/task-list/task-list.ts (EDITAR) — aplicar os novos filtros no groupedBySprint e no kanbanColumns

📋 CRITÉRIOS DE ACEITE
- [ ] Novo filtro "Tipo" (dropdown com os task_types do board)
- [ ] Novo filtro "Sprint" (dropdown com as sprints do board, incluindo "Sem sprint")
- [ ] Novo filtro "Atrasadas" (toggle: mostra só tarefas de sprints vencidas usando a lógica isSprintOverdue já existente)
- [ ] Novo filtro de intervalo de datas de criação (de/até)
- [ ] Todos os novos filtros funcionam nas duas visões (Tabela e Kanban) e são combináveis com os já existentes
- [ ] Chip ativo aparece pra cada filtro novo selecionado, e clearAll() reseta todos

🤖 PROMPT PARA A IA
"Angular 21 standalone, projeto Avante, task-filters component. Adicionar 4 filtros novos na interface TaskFilterValue: type_ids (array), sprint_ids (array, incluindo opção sem sprint), overdue_only (boolean) e created_between ({from, to} ou null). No task-filters.html, adicionar os dropdowns/campos correspondentes seguindo o padrão visual já usado para status/prioridade. No task-list.ts, aplicar esses filtros tanto em groupedBySprint (visão Tabela) quanto em kanbanColumns (visão Kanban), reaproveitando a lógica isSprintOverdue já existente para o filtro de atrasadas. Mostre as mudanças nos 3 arquivos."

🚀 QUANDO TERMINAR
1. Teste cada filtro novo isolado e combinado com os existentes, nas duas visões
2. git add . && git commit -m "feat(D-10): filtros de tipo, sprint, atrasadas e intervalo de datas"
3. git push -u origin HEAD e abra PR (base: main)
4. Marque como concluído e comente em [META-01]',
  'Média',
  'Qualidade & Experiência',
  'Melhoria',
  10,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 3 — Qualidade & Experiência (Médio)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-11] Sistema de breakpoints responsivos compartilhado

📖 CONTEXTO
Auditoria confirmou que não existe nenhum sistema de breakpoints em `styles.scss` — cada componente define seu próprio valor ad hoc (560, 600, 640, 720, 820, 860, 880, 900px, todos diferentes), e 9 dos 18 componentes auditados (task-filters, status-manager, user-manager, e a maioria dos shared/ui: popover, pagination, avatar, badge, button, confirm-dialog) não têm nenhuma regra @media. Isso torna a manutenção difícil e gera telas quebrando em pontos inconsistentes.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\Claudia\Herd\gestao-tarefas\frontend
2. git checkout main && git pull origin main
3. git checkout -b feature/d-11-breakpoints-compartilhados
4. npm install && npx ng serve

📂 ARQUIVOS ENVOLVIDOS
- frontend/src/styles.scss (EDITAR) — definir $breakpoint-mobile (640px), $breakpoint-tablet (900px) e mixins @mixin mobile / @mixin tablet
- frontend/src/app/components/task-filters/task-filters.scss (EDITAR) — adicionar responsividade usando os novos mixins
- frontend/src/app/components/status-manager/status-manager.scss (EDITAR)
- frontend/src/app/components/user-manager/user-manager.scss (EDITAR)
- frontend/src/app/shared/ui/popover/popover.scss, pagination/pagination.scss, avatar/avatar.scss, badge/badge.scss, button/button.scss, confirm-dialog/confirm-dialog.scss (EDITAR) — adicionar tratamento mínimo onde fizer sentido

📋 CRITÉRIOS DE ACEITE
- [ ] styles.scss define os mixins de breakpoint compartilhados, documentados com um comentário de uso
- [ ] Os componentes hoje sem nenhuma regra @media (task-filters, status-manager, user-manager) passam a ter reflow razoável em telas de até 375px de largura
- [ ] Componentes shared/ui pequenos (button, badge, avatar) confirmados legíveis em mobile, sem necessariamente precisar de @media próprio se já forem fluidos
- [ ] Nenhum componente que já tinha @media própria (task-list, board-list, task-dialog etc.) precisa ser tocado nesta demanda — o objetivo é cobrir as lacunas, não padronizar valores já funcionando
- [ ] Teste manual em DevTools simulando 375px, 768px e 1024px nas telas de filtros, gerenciar status e gerenciar usuários

🤖 PROMPT PARA A IA
"Angular 21 standalone, projeto Avante. Em styles.scss, definir dois mixins SCSS reutilizáveis: mobile (max-width: 640px) e tablet (max-width: 900px). Depois, em task-filters.scss, status-manager.scss e user-manager.scss (hoje sem nenhuma regra @media), usar esses mixins para dar reflow razoável em telas pequenas: filtros empilham verticalmente, tabelas de gerenciamento viram cards ou scroll horizontal contido, botões de ação ficam acessíveis por toque. Mostre os arquivos scss alterados."

🚀 QUANDO TERMINAR
1. Teste em DevTools nos 3 tamanhos de tela citados
2. git add . && git commit -m "feat(D-11): sistema de breakpoints compartilhado e responsividade em filtros/gerenciadores"
3. git push -u origin HEAD e abra PR (base: main)
4. Marque como concluído e comente em [META-01]',
  'Média',
  'Qualidade & Experiência',
  'Melhoria',
  11,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 3 — Qualidade & Experiência (Médio)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-12] Responsividade de Marketing e Analytics (tabelas e gráficos)

📖 CONTEXTO
Em marketing.scss e analytics.scss, só o grid de cards colapsa abaixo de 900px. As tabelas de métricas ficam com colunas fixas e sem scroll horizontal: `.mkt-metrics-row` (grid-template-columns com 6 colunas fixas, por volta da linha 506 de marketing.scss), `.mkt-chart-row` (3 colunas fixas, linha 467) e `.an-bar-row` em analytics.scss (3 colunas fixas, linha 182) ficam ilegíveis/espremidas abaixo de ~400px de largura, sem nenhuma regra @media nem overflow-x cobrindo esses elementos especificamente.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\Claudia\Herd\gestao-tarefas\frontend
2. Confirme que D-11 (breakpoints compartilhados) já foi mergeado, para reaproveitar os mixins
3. git checkout main && git pull origin main
4. git checkout -b feature/d-12-responsividade-marketing-analytics

📂 ARQUIVOS ENVOLVIDOS
- frontend/src/app/components/marketing/marketing.scss (EDITAR) — .mkt-metrics-head, .mkt-metrics-row, .mkt-chart-row
- frontend/src/app/components/analytics/analytics.scss (EDITAR) — .an-bar-row

📋 CRITÉRIOS DE ACEITE
- [ ] .mkt-metrics-row e .mkt-metrics-head: abaixo do breakpoint mobile, viram scroll horizontal contido (overflow-x: auto num wrapper próprio) em vez de espremer as 6 colunas
- [ ] .mkt-chart-row e .an-bar-row: recebem tratamento equivalente (scroll horizontal contido ou reflow em coluna única com rótulo acima do valor)
- [ ] Nenhuma tabela ou gráfico dessas telas ultrapassa a largura da viewport (sem scroll horizontal na página toda, só no container específico)
- [ ] Teste manual em 375px de largura nas telas de Marketing (calendário/pipeline/desempenho) e Analytics

🤖 PROMPT PARA A IA
"Angular 21 standalone, projeto Avante. Em marketing.scss, as classes .mkt-metrics-head/.mkt-metrics-row (grid-template-columns: 1.4fr 1fr 1fr 1fr 1fr 32px) e .mkt-chart-row (grid-template-columns: 90px 1fr 60px) não têm nenhuma regra @media nem overflow-x. Em analytics.scss, .an-bar-row (grid-template-columns: 110px 1fr 50px) tem o mesmo problema. Adicione, usando os mixins de breakpoint já existentes em styles.scss, um tratamento responsivo: abaixo do breakpoint mobile, envolva essas grids num container com overflow-x: auto e mantenha uma largura mínima legível nas colunas (não deixe espremer a ponto de ficar ilegível). Mostre os trechos scss alterados."

🚀 QUANDO TERMINAR
1. Teste em DevTools a 375px nas telas de Marketing e Analytics
2. git add . && git commit -m "fix(D-12): responsividade de tabelas e gráficos em Marketing e Analytics"
3. git push -u origin HEAD e abra PR (base: main)
4. Marque como concluído e comente em [META-01]',
  'Média',
  'Qualidade & Experiência',
  'Bug',
  12,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 3 — Qualidade & Experiência (Médio)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-13] Acessibilidade básica (aria, foco em modais, navegação por teclado)

📖 CONTEXTO
Auditoria encontrou zero ocorrências de aria-, role= ou tabindex em task-dialog.html, task-list.html e confirm-dialog.html. Não existe gestão de foco em nenhum modal (Tab escapa do diálogo aberto) nem navegação documentada por teclado. Isso barra clientes com exigência de acessibilidade (setor público, educação, empresas com política de WCAG) e usuários de leitor de tela.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\Claudia\Herd\gestao-tarefas\frontend
2. git checkout main && git pull origin main
3. git checkout -b feature/d-13-acessibilidade-basica
4. Instale a extensão axe DevTools no Chrome pra testar

📂 ARQUIVOS ENVOLVIDOS
- frontend/src/app/shared/ui/modal/modal.ts e modal.html (EDITAR) — role=dialog, aria-modal, aria-labelledby, focus trap genérico (todos os outros modais herdam daqui)
- frontend/src/app/components/task-dialog/task-dialog.html (EDITAR) — aria-labels nos botões de ícone
- frontend/src/app/components/task-list/task-list.html (EDITAR) — aria-labels, tabindex nas task-rows, keydown.enter abre o dialog
- frontend/src/app/shared/ui/confirm-dialog/confirm-dialog.html (EDITAR) — role=alertdialog

📋 CRITÉRIOS DE ACEITE
- [ ] app-modal: role="dialog", aria-modal="true", aria-labelledby apontando pro título; foco vai para o primeiro elemento focável ao abrir; Tab cicla só dentro do modal enquanto aberto (focus trap); Esc fecha
- [ ] Todos os botões que só têm ícone (sem texto visível) recebem aria-label descritivo
- [ ] task-row recebe tabindex="0" e keydown.enter abre o task-dialog daquela tarefa
- [ ] confirm-dialog usa role="alertdialog" (ação que exige atenção imediata)
- [ ] axe DevTools rodado em board-list, task-list (Tabela e Kanban) e task-dialog aberto retorna 0 violações críticas
- [ ] Teste manual: navegar do login até abrir e editar uma tarefa usando só Tab, Enter e Esc

🤖 PROMPT PARA A IA
"Angular 21 standalone, projeto Avante. Melhorias de acessibilidade WCAG 2.1 AA. No app-modal (componente base reusado por todos os modais do sistema): adicionar role=dialog, aria-modal=true, aria-labelledby apontando para o elemento de título recebido via @Input ou content projection, focus trap (ao abrir, focar o primeiro elemento focável dentro do modal; interceptar Tab/Shift+Tab para não deixar o foco escapar enquanto aberto). No task-dialog.html, adicionar aria-label em todos os botões só-ícone. No task-list.html, adicionar tabindex=0 nas linhas de tarefa e handler de keydown.enter para abrir o dialog. No confirm-dialog, role=alertdialog. Mostre as mudanças arquivo por arquivo."

🚀 QUANDO TERMINAR
1. Rode axe DevTools nas telas citadas e corrija violações críticas restantes
2. Teste a navegação completa só de teclado
3. git add . && git commit -m "feat(D-13): acessibilidade básica WCAG 2.1 AA em modais e navegação por teclado"
4. git push -u origin HEAD e abra PR (base: main)
5. Marque como concluído e comente em [META-01]',
  'Média',
  'Qualidade & Experiência',
  'Melhoria',
  13,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 3 — Qualidade & Experiência (Médio)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-14] Completar ações em massa (bulk delete, export, remover tag/assignee)

📖 CONTEXTO
`TaskController@bulkUpdate` (por volta da linha 170) hoje só substitui status_id/priority/type/sprint_id em massa, e só ADICIONA (nunca remove) uma única tag ou um único assignee por chamada via add_tag_id/add_assignee_id. Faltam recursos básicos de qualquer ferramenta de gestão de tarefas séria: apagar várias tarefas de uma vez, exportar a seleção filtrada, remover tag/assignee em massa (só existe "adicionar"), e adicionar múltiplos assignees numa única chamada.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\UITEC\Herd\gestao-tarefas (backend e frontend)
2. Confirme que D-02 (Policies) já foi mergeado — bulk delete precisa checar autorização de cada task
3. git checkout main && git pull origin main
4. git checkout -b feature/d-14-completar-bulk-actions

📂 ARQUIVOS ENVOLVIDOS
- backend/app/Http/Controllers/TaskController.php (EDITAR) — bulkUpdate() ganha remove_tag_id, remove_assignee_id, e um novo endpoint bulkDelete(); método export() reaproveitando os mesmos filtros de index()
- backend/routes/api.php (EDITAR) — POST /api/tasks/bulk-delete, GET /api/tasks/export
- frontend/src/app/services/api.ts (EDITAR) — bulkDeleteTasks(), exportTasks()
- frontend/src/app/components/task-list/task-list.ts e task-list.html (EDITAR) — botões na barra flutuante de ações em massa

📋 CRITÉRIOS DE ACEITE
- [ ] POST /api/tasks/bulk-delete apaga (soft delete) uma lista de task_ids, checando autorização de cada uma
- [ ] bulkUpdate ganha remove_tag_id e remove_assignee_id (detach em vez de sync/attach)
- [ ] bulkUpdate aceita assignee_ids (array) além do add_assignee_id único já existente, sem quebrar quem já usa o formato antigo
- [ ] GET /api/tasks/export?board_id={id}&format=csv gera CSV (UTF-8 com BOM) respeitando os mesmos filtros de index(), incluindo a seleção atual quando vier task_ids explícitos
- [ ] Na barra flutuante de ações em massa do task-list, botões novos: "Excluir selecionadas" (com confirmação), "Exportar selecionadas", e opção de remover tag/assignee em massa
- [ ] Teste manual: selecionar 3 tarefas, remover uma tag em massa, depois excluir as 3 de uma vez

🤖 PROMPT PARA A IA
"Laravel 13 + Angular 21, projeto Avante. Em TaskController, expandir bulkUpdate() para aceitar remove_tag_id e remove_assignee_id (detach) além do que já existe, e aceitar assignee_ids como array para adicionar vários de uma vez. Criar bulkDelete(Request) — recebe task_ids, autoriza cada uma via Policy, soft-deleta. Criar export(Request) reaproveitando os filtros de index(), retornando StreamedResponse CSV UTF-8 com BOM. Registrar as rotas (export ANTES de qualquer rota com {id}). No Angular, no task-list, adicionar à barra de ações em massa: botão excluir selecionadas (com ConfirmDialog), botão exportar selecionadas, e um jeito de remover tag/assignee em massa nos popovers já existentes. Mostre os arquivos back e front alterados."

🚀 QUANDO TERMINAR
1. Teste bulk delete, bulk export e remoção de tag/assignee em massa
2. git add . && git commit -m "feat(D-14): completa ações em massa com bulk delete, export e remoção de tag/assignee"
3. git push -u origin HEAD e abra PR (base: main)
4. Atualize o CLAUDE.md (seção API, endpoint bulk-update)
5. Marque como concluído e comente em [META-01]',
  'Média',
  'Qualidade & Experiência',
  'Melhoria',
  14,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 3 — Qualidade & Experiência (Médio)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-15] Observabilidade: logging estruturado e monitoramento de erro

📖 CONTEXTO
Hoje o projeto usa só o Monolog padrão do Laravel (canal stack/single), sem nenhum serviço de monitoramento de exceção (Sentry, Bugsnag, Flare). Em produção, um erro 500 vira só uma linha no laravel.log do servidor compartilhado — ninguém é avisado, e investigar exige entrar via SSH pra ler o arquivo manualmente. Pra um produto comercial com clientes pagantes, descobrir um erro só quando o cliente reclama é tarde demais.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\Claudia\Herd\gestao-tarefas\backend
2. git checkout main && git pull origin main
3. git checkout -b feature/d-15-observabilidade
4. Verifique se já existe uma conta gratuita de Sentry ou Flare disponível — se não, use o plano free de um dos dois

📂 ARQUIVOS ENVOLVIDOS
- backend/composer.json (EDITAR) — adicionar sentry/sentry-laravel (ou spatie/laravel-flare-driver)
- backend/config/sentry.php (CRIAR, via publish do pacote)
- backend/bootstrap/app.php (EDITAR) — registrar o reporte de exceções no withExceptions()
- backend/.env.example (EDITAR) — adicionar SENTRY_LARAVEL_DSN de exemplo

📋 CRITÉRIOS DE ACEITE
- [ ] Pacote de monitoramento instalado e configurado via variável de ambiente (sem DSN configurado, degrada graciosamente sem quebrar a aplicação — mesmo padrão já usado no WhatsAppGateway)
- [ ] Exceções não tratadas (500) chegam ao serviço de monitoramento em produção, com contexto do usuário autenticado e da rota
- [ ] Logging de eventos importantes (falha de autenticação, falha de webhook/gateway externo) em nível warning/error, não só no log padrão
- [ ] Teste manual: forçar um erro 500 propositalmente em ambiente local com o DSN configurado e confirmar que aparece no painel do serviço escolhido

🤖 PROMPT PARA A IA
"Laravel 13, projeto Avante. Instalar e configurar sentry/sentry-laravel (ou alternativa gratuita equivalente). Publicar a config, registrar o reporte de exceções em bootstrap/app.php via withExceptions(), condicionado a SENTRY_LARAVEL_DSN existir no .env (se não existir, a aplicação funciona normalmente sem monitoramento, sem erro). Adicionar contexto do usuário autenticado (id, email, sem senha) nos eventos reportados. Mostre a configuração e as mudanças em bootstrap/app.php."

🚀 QUANDO TERMINAR
1. Teste forçando um erro em ambiente local com DSN configurado
2. git add . && git commit -m "feat(D-15): monitoramento de exceções em produção com fallback gracioso"
3. git push -u origin HEAD e abra PR (base: main)
4. Configure a variável SENTRY_LARAVEL_DSN no .env de produção via SSH
5. Marque como concluído e comente em [META-01]',
  'Média',
  'Qualidade & Experiência',
  'Melhoria',
  15,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 3 — Qualidade & Experiência (Médio)' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-16] Corrigir chamada síncrona de notificação WhatsApp

📖 CONTEXTO
`TaskController::notifyWhatsAppStatusChange` (por volta da linha 232) faz uma chamada HTTP síncrona (Http::timeout(10)->post()) dentro do próprio ciclo de PUT /api/tasks/{id} — se o gateway de WhatsApp estiver lento ou fora do ar, quem está só mudando o status de uma tarefa fica esperando até 10 segundos pela resposta, sem nenhum worker isolando essa latência (o hosting não tem fila em background, então não dá pra simplesmente fazer dispatch() num Job).

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\Claudia\Herd\gestao-tarefas\backend
2. git checkout main && git pull origin main
3. git checkout -b feature/d-16-whatsapp-nao-bloqueante
4. Leia primeiro TaskController::update e notifyWhatsAppStatusChange, e WhatsAppGateway::send

📂 ARQUIVOS ENVOLVIDOS
- backend/app/Http/Controllers/TaskController.php (EDITAR) — mover a chamada pra fora do fluxo síncrono de resposta
- backend/app/Services/WhatsAppGateway.php (EDITAR) — reduzir timeout e/ou tornar a chamada não-bloqueante

📋 CRITÉRIOS DE ACEITE
- [ ] PUT /api/tasks/{id} responde ao cliente sem esperar o resultado do envio de WhatsApp (a notificação acontece depois de a resposta HTTP já ter sido enviada, usando terminate() do Laravel ou reduzindo drasticamente o timeout com fire-and-forget)
- [ ] Timeout do Http::post reduzido para no máximo 3 segundos, e falha de envio nunca derruba a atualização da tarefa (já é o caso hoje, mas confirmar que continua assim)
- [ ] Teste manual: simular o gateway lento (ex. apontar WHATSAPP_API_URL pra um endpoint que demora) e confirmar que o PUT da tarefa responde rápido mesmo assim

🤖 PROMPT PARA A IA
"Laravel 13, projeto Avante. TaskController::update() chama notifyWhatsAppStatusChange() de forma síncrona, e o WhatsAppGateway::send faz Http::timeout(10)->post() dentro do mesmo ciclo de request, atrasando a resposta ao cliente em até 10s se o gateway estiver lento. Sem fila em background disponível no hosting (shared hosting sem queue worker), use app()->terminate() ou um callback pós-resposta do Laravel para disparar o envio de WhatsApp DEPOIS que a resposta HTTP já foi enviada ao cliente, e reduza o timeout do Http::post para 3 segundos como proteção adicional. Mostre as mudanças em TaskController.php e WhatsAppGateway.php."

🚀 QUANDO TERMINAR
1. Teste com o gateway respondendo lento e confirme que o PUT da tarefa não trava esperando
2. git add . && git commit -m "fix(D-16): notificação WhatsApp não bloqueia mais a resposta de atualizar tarefa"
3. git push -u origin HEAD e abra PR (base: main)
4. Marque como concluído e comente em [META-01]',
  'Média',
  'Qualidade & Experiência',
  'Bug',
  16,
  NOW(), NOW()
);

-- ============================================================
-- PARTE 7 — SPRINT 4: Comercialização
-- ============================================================

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
VALUES (
  8,
  (SELECT id FROM sprints WHERE board_id = 8 AND name = 'Sprint 4 — Comercialização' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 8 AND name = 'Em Fila' LIMIT 1),
  '[D-17] Camada de billing e planos (assinatura)

📖 CONTEXTO
Não existe hoje nenhum traço de cobrança no Avante — sem Stripe, sem plano, sem limite, sem paywall. Pra virar produto vendável de verdade (o objetivo final deste plano inteiro), precisa existir uma camada mínima de assinatura por company: um plano (free/trial ou pago), um limite razoável (ex. número de usuários ou de boards ativos por plano), e integração com um provedor de pagamento. Depende de D-01 (multi-tenancy) estar pronto, porque o plano é por Company, não por usuário individual.

🛠️ ANTES DE COMEÇAR
1. Acesse: C:\Users\UITEC\Herd\gestao-tarefas\backend
2. Confirme que D-01 (company_id) já está mergeado — este é um pré-requisito direto
3. git checkout main && git pull origin main
4. git checkout -b feature/d-17-billing-assinatura
5. Crie uma conta de teste no Stripe (modo sandbox) se ainda não tiver

📂 ARQUIVOS ENVOLVIDOS
- backend/composer.json (EDITAR) — adicionar stripe/stripe-php
- backend/database/migrations/XXXX_add_billing_fields_to_companies_table.php (CRIAR) — plan (string, default trial), trial_ends_at, stripe_customer_id, stripe_subscription_id
- backend/app/Models/Company.php (EDITAR) — helpers isOnTrial(), isActive(), limiteDeUsuarios()
- backend/app/Http/Controllers/BillingController.php (CRIAR) — checkout, webhook do Stripe, status da assinatura
- backend/routes/api.php (EDITAR) — rotas de billing
- backend/app/Http/Middleware/EnsureCompanyIsActive.php (CRIAR) — bloqueia ações de escrita se o trial expirou e não há assinatura ativa
- frontend/src/app/components/profile/ (EDITAR ou CRIAR aba própria) — tela de plano atual, botão de assinar/cancelar

📋 CRITÉRIOS DE ACEITE
- [ ] Company nasce com plan = trial e trial_ends_at = 14 dias a partir da criação
- [ ] Endpoint de checkout gera uma sessão do Stripe Checkout para o plano pago
- [ ] Webhook do Stripe atualiza plan e stripe_subscription_id na Company quando o pagamento é confirmado ou cancelado
- [ ] Middleware EnsureCompanyIsActive bloqueia criar novo board/usuário quando o trial expirou sem assinatura ativa (mas continua permitindo visualizar o que já existe)
- [ ] Tela de perfil mostra o plano atual, dias restantes de trial (se aplicável), e botão para assinar
- [ ] Teste manual: completar um checkout em modo sandbox do Stripe e confirmar que o plano muda automaticamente via webhook

🤖 PROMPT PARA A IA
"Laravel 13 + Angular 21, projeto Avante, multi-tenant por Company (já existe company_id). Adicionar billing básico com Stripe: (1) migration adicionando plan, trial_ends_at, stripe_customer_id, stripe_subscription_id em companies; (2) BillingController com checkout() (cria Stripe Checkout Session), webhook() (escuta checkout.session.completed e customer.subscription.deleted, atualiza a Company), e status() (retorna plano atual e dias restantes); (3) Middleware EnsureCompanyIsActive que bloqueia métodos de escrita (store) quando trial expirou e não há assinatura ativa, aplicado nas rotas de criar board/task/usuário; (4) no Angular, uma seção nova na tela de perfil mostrando plano atual e botão de assinar (redireciona pra URL do Stripe Checkout). Mostre todos os arquivos, incluindo a rota do webhook (fora do grupo auth:sanctum, com verificação de assinatura do Stripe)."

🚀 QUANDO TERMINAR
1. Teste um checkout completo em modo sandbox do Stripe e confirme a atualização via webhook
2. git add . && git commit -m "feat(D-17): billing e planos por company com Stripe Checkout"
3. git push -u origin HEAD e abra PR (base: main)
4. Configure as chaves do Stripe (produção) no .env do servidor via SSH
5. Atualize o CLAUDE.md (seção Banco de dados e Histórico de decisões) com os novos campos de billing
6. Marque como concluído e comente em [META-01] — esta é a última demanda do plano, parabéns pelo ciclo!',
  'Alta',
  'Comercialização',
  'História',
  17,
  NOW(), NOW()
);

-- ============================================================
-- PARTE 8 — RESPONSÁVEIS (task_user)
-- Fernando Morais = user id 1 (demandas mais complexas/arquiteturais)
-- Claudia Marques = user id 2 (demandas full-stack menores/contidas)
-- Demandas são independentes: cada responsável cobre back e front
-- da própria demanda, sem depender do outro pra terminar
-- ============================================================

INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 1, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-01]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 1, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-02]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 1, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-03]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 2, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-04]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 2, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-05]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 1, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-06]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 1, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-07]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 2, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-08]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 1, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-09]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 2, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-10]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 2, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-11]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 2, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-12]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 2, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-13]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 1, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-14]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 2, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-15]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 2, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-16]%';
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 1, NOW(), NOW() FROM tasks t WHERE t.board_id = 8 AND t.description LIKE '[D-17]%';

-- ============================================================
-- PARTE 9 — Conferência final
-- ============================================================
SELECT s.name AS sprint, COUNT(t.id) AS qtd_tasks
FROM sprints s LEFT JOIN tasks t ON t.sprint_id = s.id
WHERE s.board_id = 8 GROUP BY s.id, s.name, s.start_date ORDER BY s.start_date;

SELECT u.name AS responsavel, COUNT(tu.task_id) AS qtd_demandas
FROM task_user tu
JOIN users u ON u.id = tu.user_id
JOIN tasks t ON t.id = tu.task_id
WHERE t.board_id = 8
GROUP BY u.name;
