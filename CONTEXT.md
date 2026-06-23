# 🧠 CONTEXT.md — Projeto Avante

> ⚠️ Mantenha este arquivo atualizado a cada mudança estrutural do projeto.
> Ele serve como memória viva para desenvolvedores e IAs entenderem o projeto rapidamente.
> Última atualização: 23/06/2026 — Fix environments Angular (API URL produção).

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
| Backend      | Laravel 13 (PHP 8.4)                         |
| Frontend     | Angular 21 + Tailwind CSS + Angular Material |
| Banco        | MySQL                                        |
| Autenticação | Laravel Sanctum (tokens)                     |
| Servidor     | Hostinger CloudLinux (shared hosting)        |
| Dev local    | Laravel Herd (Windows)                       |

---

## 🗂️ Estrutura de pastas

gestao-tarefas/

├── backend/

│ ├── app/

│ │ ├── Http/Controllers/

│ │ ├── Models/

│ │ └── Http/Middleware/

│ ├── database/migrations/

│ ├── routes/api.php

│ ├── public-static/ ← arquivos fixos copiados pelo ng build

│ │ ├── index.php ← Laravel entry point (protegido do clean build)

│ │ └── .htaccess ← roteamento Laravel (protegido do clean build)

│ └── public/ ← document root (Laravel + Angular build)

├── frontend/

│ ├── src/

│ │ ├── app/

│ │ │ ├── components/task-list/ ← página principal

│ │ │ ├── services/api.ts ← todos endpoints HTTP

│ │ │ └── guards/

│ │ └── environments/

│ │ ├── environment.ts ← dev: http://gestao-tarefas.test

│ │ └── environment.prod.ts ← prod: https://avante.devmorais.com.br

│ ├── public-static/ ← fonte dos arquivos estáticos do Laravel

│ │ ├── index.php

│ │ └── .htaccess

│ └── angular.json ← outputPath + fileReplacements + assets

└── CONTEXT.md

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
}
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

> ⚠️ **PENDENTE:** Criar os arquivos de environment e atualizar o api.ts, buildar e fazer deploy.

---

## 🗄️ Banco de dados

### Tabelas principais

| Tabela    | Descrição                                                           |
| --------- | ------------------------------------------------------------------- |
| users     | name, email, password, role, bio, position, avatar_url, soft delete |
| boards    | soft delete                                                         |
| tasks     | description, priority, sprint_id, status_id, board_id, soft delete  |
| sprints   | name, start_date, end_date, finished_at, board_id, soft delete      |
| statuses  | name, color, order, board_id, soft delete                           |
| task_user | pivot — múltiplos usuários por tarefa                               |
| comments  | comentários em tarefas                                              |

### Migrations em ordem

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

2026_06_21_160951 add_soft_deletes_to_boards_tasks_sprints_statuses

2026_06_21_182959 add_role_and_soft_deletes_to_users_table

2026_06_21_203314 create_task_user_table

2026_06_21_213358 create_comments_table

2026_06_22_033101 add_profile_fields_to_users_table

2026_06_23_034204 add_finished_at_to_sprints_table

---

## 🔌 API — Endpoints

| Método | Rota                     | Descrição                                                                             |
| ------ | ------------------------ | ------------------------------------------------------------------------------------- |
| POST   | /api/login               | Login                                                                                 |
| POST   | /api/logout              | Logout                                                                                |
| GET    | /api/profile             | Perfil autenticado                                                                    |
| PUT    | /api/profile             | Atualizar perfil                                                                      |
| POST   | /api/profile/avatar      | Upload avatar                                                                         |
| GET    | /api/boards              | Lista quadros                                                                         |
| POST   | /api/boards              | Criar quadro                                                                          |
| PUT    | /api/boards/{id}         | Atualizar quadro                                                                      |
| DELETE | /api/boards/{id}         | Deletar quadro                                                                        |
| GET    | /api/tasks               | Lista tarefas (filtros: board_id, page, search, status_ids, priorities, assignee_ids) |
| POST   | /api/tasks               | Criar tarefa                                                                          |
| PUT    | /api/tasks/{id}          | Atualizar tarefa                                                                      |
| DELETE | /api/tasks/{id}          | Deletar tarefa                                                                        |
| GET    | /api/sprints             | Lista sprints por board_id                                                            |
| POST   | /api/sprints             | Criar sprint                                                                          |
| PUT    | /api/sprints/{id}        | Atualizar sprint                                                                      |
| DELETE | /api/sprints/{id}        | Deletar sprint                                                                        |
| POST   | /api/sprints/{id}/finish | Finalizar sprint (transborda tarefas)                                                 |
| GET    | /api/users               | Lista usuários                                                                        |
| POST   | /api/users               | Criar usuário                                                                         |
| PUT    | /api/users/{id}          | Atualizar usuário                                                                     |
| DELETE | /api/users/{id}          | Deletar usuário                                                                       |
| GET    | /api/statuses            | Lista status por board_id                                                             |
| POST   | /api/statuses            | Criar status                                                                          |
| PUT    | /api/statuses/{id}       | Atualizar status                                                                      |
| DELETE | /api/statuses/{id}       | Deletar status                                                                        |
| GET    | /api/tasks/{id}/comments | Lista comentários                                                                     |
| POST   | /api/tasks/{id}/comments | Criar comentário                                                                      |
| DELETE | /api/comments/{id}       | Deletar comentário                                                                    |

---

## 🎨 Frontend — Componentes principais

### task-list (página principal)

- Agrupamento por sprint ordenado por `start_date`
- Cabeçalho por grupo: nome, contagem, datas, barra de progresso, badge "Vencida/Finalizada", botão "Finalizar Sprint"
- Seleção individual e por grupo com indeterminate
- Barra flutuante de ações em lote
- Mover tarefas entre sprints via modal
- Finalizar sprint transborda tarefas não concluídas para próxima sprint
- Avatares com foto ou iniciais coloridas
- Paginação 25/página, filtros, ordenação local

### Avatar (`app-avatar`)

- `[name]` → iniciais coloridas
- `[photoUrl]` → foto
- `[size]` → sm/md/lg
- Fallback automático

---

## 🔑 Avatar — accessor no Model

```php
public function getAvatarUrlAttribute($value): ?string {
    if (!$value) return null;
    if (str_starts_with($value, 'http')) return $value;
    return url($value);
}
```

---

## 🏁 Finalizar Sprint

- `POST /api/sprints/{id}/finish` com body `{ concluded_status_id: number | null }`
- Tarefas não concluídas → movidas para próxima sprint
- `finished_at` preenchido com `now()`
- Botão ativo só quando sprint vencida OU 100% concluída

---

## 🚫 Limitações do servidor (shared hosting Hostinger)

| Recurso                    | Situação                                             |
| -------------------------- | ---------------------------------------------------- |
| `exec()` no PHP            | ❌ Bloqueado                                         |
| `php artisan storage:link` | ❌ Usar `ln -s ../storage/app/public public/storage` |
| Queues em background       | ❌ Não disponível                                    |
| Cron jobs                  | ✅ hPanel                                            |
| SSH                        | ✅ Porta 65002                                       |

---

## 📦 O que NÃO vai pro Git

backend/.env

backend/vendor/

frontend/node_modules/

frontend/.angular/

DEPLOY.md

---

## 🤖 Como usar com IA

Cole este arquivo completo no início da conversa e diga:

> "Me ajude com: [SUA DÚVIDA AQUI]"

---

## 📝 Histórico de decisões técnicas

| Data       | Decisão                                                     | Motivo                                                      |
| ---------- | ----------------------------------------------------------- | ----------------------------------------------------------- |
| 23/06/2026 | Build Angular → `backend/public/`                           | Shared hosting sem virtual hosts                            |
| 23/06/2026 | Sanctum para autenticação                                   | API stateless com tokens                                    |
| 23/06/2026 | SESSION/QUEUE/CACHE → database                              | Shared hosting sem Redis/supervisord                        |
| 23/06/2026 | accessor `getAvatarUrlAttribute`                            | URL absoluta em todos endpoints                             |
| 23/06/2026 | `public-static/` como fonte de assets fixos                 | Evitar que ng build apague index.php e .htaccess do Laravel |
| 23/06/2026 | environments Angular (environment.ts / environment.prod.ts) | API URL correta por ambiente sem hardcode                   |
| 23/06/2026 | Finalizar sprint transborda tarefas                         | Nada se perde ao encerrar um ciclo                          |
| 23/06/2026 | Barra de progresso colorida por status                      | Visibilidade rápida do andamento                            |
