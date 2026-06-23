# 🧠 CONTEXT.md — Projeto Avante

> ⚠️ Mantenha este arquivo atualizado a cada mudança estrutural do projeto.
> Ele serve como memória viva para desenvolvedores e IAs entenderem o projeto rapidamente.
> Última atualização: 23/06/2026 — Sprint header rico + seleção de tarefas + finalizar sprint.

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

```
gestao-tarefas/
├── backend/
│   ├── app/
│   │   ├── Http/Controllers/
│   │   ├── Models/
│   │   └── Http/Middleware/
│   ├── database/
│   │   └── migrations/
│   ├── routes/
│   │   └── api.php
│   └── public/              ← document root (Laravel + Angular build)
├── frontend/
│   └── src/app/
│       ├── components/
│       ├── pages/
│       │   └── task-list/   ← task-list.ts/.html/.scss  ← ARQUIVO PRINCIPAL
│       └── services/
│           └── api.ts       ← todos os endpoints HTTP
└── CONTEXT.md
```

---

## 🔀 Roteamento em produção

`.htaccess` da raiz em camadas:
1. Arquivos estáticos → `backend/public/`
2. `/api/*` → Laravel (`backend/public/index.php`)
3. Tudo mais → Angular SPA (`backend/public/index.html`)

> ⚠️ `ng build` pode apagar `backend/public/index.php` e `.htaccess`. Verificar sempre após build!

---

## 🗄️ Banco de dados

### Tabelas principais

| Tabela     | Descrição                                          |
| ---------- | -------------------------------------------------- |
| users      | name, email, password, role, bio, position, avatar_url, soft delete |
| boards     | soft delete                                        |
| tasks      | description, priority, sprint_id, status_id, board_id, soft delete |
| sprints    | name, start_date, end_date, **finished_at**, board_id, soft delete |
| statuses   | name, color, order, board_id, soft delete          |
| task_user  | pivot — múltiplos usuários por tarefa              |
| comments   | conteúdo de comentários em tarefas                 |

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
2026_06_21_160951 add_soft_deletes_to_boards_tasks_sprints_statuses
2026_06_21_182959 add_role_and_soft_deletes_to_users_table
2026_06_21_203314 create_task_user_table
2026_06_21_213358 create_comments_table
2026_06_22_033101 add_profile_fields_to_users_table
2026_06_23_034204 add_finished_to_sprints_table        ← NOVO: campo finished_at
```

---

## 🔌 API — Endpoints relevantes

| Método | Rota                        | Controller            | Descrição                          |
| ------ | --------------------------- | --------------------- | ---------------------------------- |
| GET    | /api/tasks                  | TaskController@index  | Lista paginada com filtros         |
| POST   | /api/tasks                  | TaskController@store  | Cria tarefa                        |
| PUT    | /api/tasks/{id}             | TaskController@update | Atualiza (inclui sprint_id, assignee_ids) |
| DELETE | /api/tasks/{id}             | TaskController@destroy| Soft delete                        |
| GET    | /api/sprints                | SprintController@index| Lista sprints por board_id         |
| POST   | /api/sprints/{id}/finish    | SprintController@finish| **NOVO** — Finaliza sprint e transborda tarefas |
| GET    | /api/users                  | UserController@index  | Lista usuários (inclui avatar_url) |
| POST   | /api/profile/avatar         | ProfileController     | Upload de avatar                   |
| GET    | /api/profile                | ProfileController     | Perfil do usuário autenticado      |

---

## 🎨 Frontend — Componentes principais

### task-list (página principal do quadro)

**Funcionalidades implementadas:**
- Agrupamento de tarefas por sprint (ordenadas por `start_date`)
- Cabeçalho por grupo com: nome, contagem, datas, barra de progresso colorida por status, badge "Vencida"/"Finalizada", botão "Finalizar Sprint"
- Cabeçalho de colunas discreto **dentro de cada grupo** (não fixo no topo)
- Ordenação local por: Atividade, Status, Prioridade, Responsável
- Seleção de tarefas: individual, por grupo (com indeterminate), barra flutuante
- Mover tarefas selecionadas entre sprints via modal
- Finalizar sprint: transborda tarefas não concluídas para próxima sprint
- Toast de feedback após finalizar sprint
- Avatares de responsáveis com foto (photoUrl) ou iniciais coloridas
- Paginação (25 por página padrão)
- Filtros: busca, status, prioridade, responsável

**Grid de colunas:** `40px 1fr 140px 120px 70px 36px`
(checkbox | título | status | prioridade | resp. | ações)

### Avatar (`app-avatar`)
- `[name]` → iniciais coloridas como fallback
- `[photoUrl]` → foto do usuário
- `[size]` → sm (28px) / md (34px) / lg (48px)
- Fallback automático se imagem falhar

### Sidebar (`app-sidebar`)
- Colapsável
- Avatar do usuário logado com foto
- Navegação: Tarefas / Sprints / Status

---

## 🔑 Avatar — Normalização de URL

O `avatar_url` é salvo no banco como `/storage/avatars/foto.jpg` (relativo).

**Solução:** accessor no `User` model que converte para URL absoluta em todo lugar:
```php
public function getAvatarUrlAttribute($value): ?string {
    if (!$value) return null;
    if (str_starts_with($value, 'http')) return $value;
    return url($value);
}
```

---

## 🏁 Finalizar Sprint — Lógica

- Endpoint: `POST /api/sprints/{id}/finish`
- Body: `{ concluded_status_id: number | null }`
- O backend detecta o status "concluído" pelo `concluded_status_id` ou pelo nome (fallback: busca por "concluído/concluido/done/finalizado")
- Tarefas **não concluídas** são movidas para a próxima sprint (por `start_date`)
- `finished_at` é preenchido com `now()`
- Frontend: botão ativo somente quando sprint está vencida OU 100% concluída
- Toast exibe quantas tarefas foram transbordadas

---

## ⚙️ Configurações importantes

### angular.json — outputPath
```json
"outputPath": { "base": "../backend/public", "browser": "" }
```

### Budgets de build
```json
{ "type": "initial", "maximumWarning": "2MB", "maximumError": "5MB" },
{ "type": "anyComponentStyle", "maximumWarning": "50kB", "maximumError": "100kB" }
```

### Dependências Angular extras
```
@angular/animations@21.2.17
```

---

## 🚫 Limitações do servidor (shared hosting Hostinger)

| Recurso                    | Situação                              |
| -------------------------- | ------------------------------------- |
| `exec()` no PHP            | ❌ Bloqueado                          |
| `php artisan storage:link` | ❌ Usar `ln -s` manual via SSH        |
| Queues em background       | ❌ Não disponível                     |
| Cron jobs                  | ✅ Configurar via hPanel              |
| SSH                        | ✅ Porta 65002                        |

---

## 📦 O que NÃO vai pro Git

```
backend/.env
backend/vendor/
frontend/node_modules/
frontend/.angular/
DEPLOY.md
```

---

## 🤖 Prompt para IAs

Cole o conteúdo deste arquivo no início de qualquer conversa com uma IA seguido de:
> "Me ajude com: [SUA DÚVIDA AQUI]"

---

## 📝 Histórico de decisões técnicas

| Data       | Decisão                                                    | Motivo                                                    |
| ---------- | ---------------------------------------------------------- | --------------------------------------------------------- |
| 23/06/2026 | Build Angular vai para `backend/public/`                   | Shared hosting sem virtual hosts                          |
| 23/06/2026 | Sanctum para autenticação                                  | API stateless com tokens                                  |
| 23/06/2026 | SESSION_DRIVER=database / QUEUE_CONNECTION=database        | Shared hosting sem Redis/supervisord                      |
| 23/06/2026 | accessor `getAvatarUrlAttribute` no User model             | Garante URL absoluta em todos os endpoints de uma vez     |
| 23/06/2026 | `assignees:id,name,email,avatar_url` no TaskController     | Forçar seleção do campo avatar_url no relacionamento      |
| 23/06/2026 | Header de colunas dentro de cada grupo (não fixo no topo)  | Evita duplicação visual e melhora UX por sprint           |
| 23/06/2026 | Finalizar sprint transborda tarefas para próxima sprint    | UX motivacional — nada se perde ao encerrar um ciclo      |
| 23/06/2026 | Barra de progresso colorida por status no header da sprint | Visibilidade rápida do andamento sem abrir o grupo        |