#!/usr/bin/env python3
"""Gera integracoes-servicenow-tasks.sql a partir de integracoes-servicenow-tasks.json.

Mesmo padrao do portfolio-claudia-tasks.json -> .sql: o JSON e a fonte da verdade,
o SQL e artefato gerado. Diferencas: tipos de tarefa proprios (Estudo, Pratica, Setup,
Projeto), tags por tema, scheduled_at = dia/hora do bloco e responsavel = usuario 1.

Uso: python integracoes-servicenow-gerar-sql.py
"""
import json
import pathlib

AQUI = pathlib.Path(__file__).parent
JSON = AQUI / "integracoes-servicenow-tasks.json"
SQL = AQUI / "integracoes-servicenow-tasks.sql"
RESPONSAVEL = 1  # Fernando Morais

STATUSES = [
    ("Em Fila", "#6B6B70"),
    ("Em Andamento", "#0284C7"),
    ("Em Revisao", "#D97706"),
    ("Concluida", "#059669"),
]
PRIORITIES = [
    ("Baixa", "#059669"),
    ("Media", "#0284C7"),
    ("Alta", "#EA580C"),
    ("Urgente", "#DC2626"),
]


def q(texto):
    """Literal SQL de string, escapando aspas simples e barras invertidas."""
    if texto is None:
        return "NULL"
    return "'" + str(texto).replace("\\", "\\\\").replace("'", "''") + "'"


def main():
    dados = json.loads(JSON.read_text(encoding="utf-8"))
    board, sprints, tasks = dados["board"], dados["sprints"], dados["tasks"]

    L = []
    a = L.append
    a("-- ============================================================")
    a("-- Integracoes ServiceNow - board + sprints + cards")
    a("-- Gerado por integracoes-servicenow-gerar-sql.py a partir de")
    a("-- integracoes-servicenow-tasks.json. NAO edite este arquivo na mao.")
    a("-- ATENCAO: nao e idempotente. Rodar duas vezes duplica as linhas.")
    a("-- ============================================================")
    a("SET NAMES utf8mb4;")
    a("START TRANSACTION;")
    a("")
    a("INSERT INTO boards (name, created_at, updated_at)")
    a(f"VALUES ({q(board['name'])}, NOW(), NOW());")
    a("SET @board := LAST_INSERT_ID();")
    a("")
    for i, (nome, cor) in enumerate(STATUSES):
        a("INSERT INTO statuses (board_id, area, name, color, `order`, created_at, updated_at)")
        a(f"VALUES (@board, 'programming', {q(nome)}, {q(cor)}, {i}, NOW(), NOW());")
    for i, (nome, cor) in enumerate(PRIORITIES):
        a("INSERT INTO priorities (board_id, area, name, color, `order`, created_at, updated_at)")
        a(f"VALUES (@board, 'programming', {q(nome)}, {q(cor)}, {i}, NOW(), NOW());")
    for i, (nome, cor) in enumerate(dados["task_types"]):
        a("INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)")
        a(f"VALUES (@board, 'programming', {q(nome)}, {q(cor)}, {i}, NOW(), NOW());")
    for i, (nome, cor) in enumerate(dados["tags"], start=1):
        a(f"INSERT INTO tags (board_id, name, color, created_at, updated_at) VALUES (@board, {q(nome)}, {q(cor)}, NOW(), NOW());")
        a(f"SET @tag{i} := LAST_INSERT_ID();")
    tag_var = {nome: f"@tag{i}" for i, (nome, _) in enumerate(dados["tags"], start=1)}
    a("SET @fila := (SELECT id FROM statuses WHERE board_id = @board AND name = 'Em Fila' LIMIT 1);")
    a("")
    for i, s in enumerate(sprints, start=1):
        a("INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)")
        a(f"VALUES (@board, {q(s['name'])}, {q(s['start_date'])}, {q(s['end_date'])}, {i}, NOW(), NOW());")
        a(f"SET @sprint{i} := LAST_INSERT_ID();")
    a("")
    for i, t in enumerate(tasks, start=1):
        a(f"-- {t['codigo']}")
        a("INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description, priority, epic, type,")
        a("                   notes, scheduled_at, sort_order, created_at, updated_at)")
        a(f"VALUES (@board, 'programming', @sprint{t['sprint']}, @fila, {q(t['titulo'])}, {q(t['description'])},")
        a(f"        {q(t['priority'])}, {q(t['epic'])}, {q(t['type'])}, {q(t['notes'] or None)}, {q(t['scheduled_at'])},")
        a(f"        {i}, NOW(), NOW());")
        a("SET @t := LAST_INSERT_ID();")
        a(f"INSERT INTO task_user (task_id, user_id, created_at, updated_at) VALUES (@t, {RESPONSAVEL}, NOW(), NOW());")
        for tag in t["tags"]:
            a(f"INSERT INTO task_tag (task_id, tag_id) VALUES (@t, {tag_var[tag]});")
    a("")
    a("COMMIT;")
    a("SELECT @board AS board_criado;")
    a("")
    SQL.write_text("\n".join(L), encoding="utf-8")
    print(f"OK: {SQL.name} gerado com {len(sprints)} sprints e {len(tasks)} cards.")


if __name__ == "__main__":
    main()
