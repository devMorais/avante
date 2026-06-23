# 🧠 CONTEXT.md — Projeto Avante

> ⚠️ Mantenha este arquivo atualizado a cada mudança estrutural do projeto.
> Ele serve como memória viva para desenvolvedores e IAs entenderem o projeto rapidamente.
> Última atualização: 23/06/2026 — Deploy inicial em produção.

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
├── backend/                    ← Laravel 13
│   ├── app/
│   │   ├── Http/Controllers/   ← controllers da API
│   │   ├── Models/             ← modelos Eloquent
│   │   └── Http/Middleware/    ← middlewares
│   ├── database/
│   │   └── migrations/         ← histórico do banco
│   ├── routes/
│   │   └── api.php             ← todas as rotas são API (sem web.php relevante)
│   ├── public/                 ← document root do servidor
│   │   ├── index.php           ← Laravel entry point (NÃO apagar)
│   │   ├── .htaccess           ← roteamento interno Laravel (NÃO apagar)
│   │   └── [build Angular]     ← index.html + *.js + *.css gerados pelo ng build
│   └── .env                    ← NÃO versionado
├── frontend/                   ← Angular 21
│   ├── src/
│   │   ├── app/
│   │   │   ├── components/     ← componentes reutilizáveis
│   │   │   ├── pages/          ← páginas/rotas
│   │   │   ├── services/       ← serviços HTTP
│   │   │   └── guards/         ← proteção de rotas
│   │   └── environments/       ← config de ambiente
│   └── angular.json            ← outputPath aponta para ../backend/public
├── .htaccess                   ← roteamento raiz (ver seção abaixo)
├── index.php                   ← ponte que chama backend/public/index.php
└── CONTEXT.md                  ← este arquivo
```

---

## 🔀 Como funciona o roteamento em produção

O projeto roda num **shared hosting** sem virtual hosts configuráveis, então o roteamento é feito via `.htaccess` em camadas:

### `.htaccess` da raiz

```apache
<IfModule mod_rewrite.c>
    RewriteEngine On
    # 1. Arquivos estáticos (JS, CSS, imagens) → serve direto de backend/public/
    RewriteCond %{DOCUMENT_ROOT}/backend/public%{REQUEST_URI} -f
    RewriteRule ^(.*)$ backend/public/$1 [L]
    # 2. Rotas de API → Laravel
    RewriteCond %{REQUEST_URI} ^/api [NC]
    RewriteRule ^ backend/public/index.php [L,QSA]
    # 3. Tudo mais → Angular SPA
    RewriteRule ^ backend/public/index.html [L]
</IfModule>
```

### `backend/public/.htaccess`

Padrão Laravel — roteia requisições PHP internas para o `index.php`.

### `index.php` da raiz

Ponte simples que chama o `backend/public/index.php` do Laravel.

---

## 🗄️ Banco de dados

### Tabelas principais

| Tabela                  | Descrição                                          |
| ----------------------- | -------------------------------------------------- |
| users                   | Usuários com roles (admin/membro) e soft delete    |
| boards                  | Quadros de tarefas com soft delete                 |
| tasks                   | Tarefas com assignee, sprint, status e soft delete |
| sprints                 | Sprints vinculados a boards                        |
| statuses                | Status personalizados por board                    |
| task_user               | Pivot — múltiplos usuários por tarefa              |
| comments                | Comentários em tarefas                             |
| personal_access_tokens  | Sanctum tokens                                     |
| sessions / cache / jobs | Infraestrutura Laravel                             |

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
```

---

## ⚙️ Configurações importantes

### Angular — angular.json

O build vai direto para `backend/public/` sem subpasta:

```json
"outputPath": {
  "base": "../backend/public",
  "browser": ""
}
```

> ⚠️ O `ng build` pode apagar `backend/public/index.php` e `backend/public/.htaccess`.
> Sempre verificar após o build!

### Budgets de build (angular.json)

Aumentados para comportar o bundle atual:

```json
{ "type": "initial", "maximumWarning": "2MB", "maximumError": "5MB" },
{ "type": "anyComponentStyle", "maximumWarning": "50kB", "maximumError": "100kB" }
```

### Dependências Angular extras instaladas

```
@angular/animations@21.2.17  ← necessário, não vinha por padrão
```

---

## 🚫 Limitações do servidor (shared hosting)

| Recurso                            | Situação                              |
| ---------------------------------- | ------------------------------------- |
| `exec()` no PHP                    | ❌ Bloqueado                          |
| `php artisan storage:link`         | ❌ Não funciona — usar `ln -s` manual |
| Supervisord / queues em background | ❌ Não disponível                     |
| Symlinks via artisan               | ❌ Não funciona                       |
| Cron jobs                          | ✅ Configurar via hPanel              |
| SSH                                | ✅ Porta 65002                        |

---

## 📦 O que NÃO vai pro Git

```
backend/.env          ← criado manualmente no servidor
backend/vendor/       ← gerado pelo composer install
frontend/node_modules/
frontend/dist/        ← não usado (build vai para backend/public/)
frontend/.angular/
DEPLOY.md             ← roteiro pessoal de deploy (só do owner)
```

---

## 🤖 Prompt para IAs

Cole o conteúdo deste arquivo no início de qualquer conversa com uma IA seguido de:

> "Me ajude com: [SUA DÚVIDA AQUI]"

---

## 📝 Histórico de decisões técnicas

| Data       | Decisão                                         | Motivo                                                                 |
| ---------- | ----------------------------------------------- | ---------------------------------------------------------------------- |
| 23/06/2026 | Build Angular vai para `backend/public/`        | Shared hosting sem virtual hosts — precisava de um único document root |
| 23/06/2026 | `.htaccess` em camadas (raiz + backend/public/) | Separar roteamento de assets, API e SPA                                |
| 23/06/2026 | Sanctum para autenticação                       | API stateless com tokens para o Angular consumir                       |
| 23/06/2026 | SESSION_DRIVER=database                         | Shared hosting sem Redis                                               |
| 23/06/2026 | QUEUE_CONNECTION=database                       | Shared hosting sem supervisord                                         |
