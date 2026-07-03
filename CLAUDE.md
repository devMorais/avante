# 🧠 CLAUDE.md — Projeto Avante

> ⚠️ Mantenha este arquivo atualizado a cada mudança estrutural do projeto.
> Ele serve como memória viva para desenvolvedores e IAs entenderem o projeto rapidamente.
> Última atualização: 02/07/2026 — Leva grande: alinhamento fino da tabela + ações em massa (Tipo/Tags, endpoint bulk-update, setas nos popovers); modo claro/escuro em todo o sistema (ThemeService, tokens globais); notificações in-app (sino no sidebar) + foto real nos comentários; anexos de arquivo compartilhados por tarefa (aba "Arquivos", servidor); área de Marketing funcional (calendário de conteúdo, pipeline de leads, banco de ideias, campanhas, desempenho); área de Analytics funcional (distribuição, velocidade, carga por pessoa, burndown, cycle time, export CSV/PDF); infraestrutura de avisos via WhatsApp (opt-in no perfil, gateway plugável, comando agendado). Antes: Arquivar/restaurar quadros (archived_at; seção colapsável "Arquivados" na board-list; endpoints PATCH archive/unarchive); Modal só fecha no X; comentários abaixo da descrição; colar imagens (Ctrl+V) na descrição; tipo de tarefa (DB) com faixa colorida; full-width geral; sidebar no perfil.

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
| POST   | /api/sprints/{id}/finish | Finalizar sprint — body: `{ concluded_status_id: number\|null }`                      |
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
- Sidebar com menus placeholder: Analytics e EduCore (badge "Em breve", toast ao clicar)

**task-list** (página principal)
- Agrupamento por sprint ordenado por `start_date`
- Cabeçalho por sprint: nome, contagem, datas, barra de progresso, badge "Vencida/Finalizada", botão "Finalizar Sprint"
- Seleção individual e por sprint com indeterminate
- Barra flutuante de ações em lote (status, prioridade, mover sprint)
- Mover tarefas entre sprints via modal
- Sidebar com abas: Tasks, Sprints, Statuses + menus Analytics e EduCore (em breve)
- Paginação 25/página, filtros, ordenação local
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
| Tooltip        | `[appTooltip]`    | Diretiva: tooltip flutuante (render no body, flip automático, setinha) — `appTooltip="texto"` + `tooltipPlacement="top\|bottom\|left\|right"` |

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
- Signal: `mode = signal<'light'|'dark'|'system'>(...)`, persistido em `localStorage('avante_theme')`
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
    if (str_starts_with($value, 'http')) return $value;
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

- 25 itens por página
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

### Menus placeholder (em breve)

- Sidebars de `board-list` e `task-list` têm itens "Analytics" e "EduCore"
- Badge âmbar "Em breve" visível quando sidebar expandida
- Clicar exibe toast roxo gradiente "Funcionalidade em evolução. Em breve!"
- Implementar ao integrar com EduCore (leitor de PDFs em `C:\Users\UITEC\Herd\EduCore`)

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
> `mysql -u u846585591_gestao_tarefas -p'SENHA' -h 127.0.0.1 u846585591_gestao_tarefas -e "SQL AQUI;"`

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
