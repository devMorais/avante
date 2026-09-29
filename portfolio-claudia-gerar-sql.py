#!/usr/bin/env python3
"""Gera portfolio-claudia-tasks.sql a partir de portfolio-claudia-tasks.json.

Mesmo padrao do vitrine-empresa-tasks.json -> .sql: o JSON e a fonte da verdade,
o SQL e artefato gerado. Se precisar mudar um card, mude o JSON e rode isto de novo.

Uso: python portfolio-claudia-gerar-sql.py
"""
import json
import pathlib

AQUI = pathlib.Path(__file__).parent
JSON = AQUI / "portfolio-claudia-tasks.json"
SQL = AQUI / "portfolio-claudia-tasks.sql"

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
TASK_TYPES = [
    ("Tarefa", "#6B6B70"),
    ("Historia", "#7C3AED"),
    ("Bug", "#DC2626"),
    ("Melhoria", "#0284C7"),
]
# Nomes com acento usados nas cards do JSON -> nome real criado no board
NOMES_REAIS = {"Em Revisão": "Em Revisao", "Concluída": "Concluida",
               "Média": "Media", "História": "Historia"}


def q(texto):
    """Literal SQL de string, escapando aspas simples e barras invertidas."""
    if texto is None:
        return "NULL"
    return "'" + str(texto).replace("\\", "\\\\").replace("'", "''") + "'"


def main():
    dados = json.loads(JSON.read_text(encoding="utf-8"))
    board = dados["board"]
    sprints = dados["sprints"]
    tasks = dados["tasks"]

    L = []
    a = L.append
    a("-- ============================================================")
    a("-- Portfolio Claudia - board + sprints + cards")
    a("-- Gerado por portfolio-claudia-gerar-sql.py a partir de")
    a("-- portfolio-claudia-tasks.json. NAO edite este arquivo na mao.")
    a("--")
    a("-- Rodar no banco do Avante (gestao_tarefas) de PRODUCAO.")
    a("-- ATENCAO: nao e idempotente. Rodar duas vezes duplica as linhas.")
    a("-- Confira antes:  SELECT id, name FROM boards ORDER BY id DESC LIMIT 5;")
    a("-- ============================================================")
    a("")
    a("START TRANSACTION;")
    a("")
    a("-- Passo 1: criar o board")
    a("INSERT INTO boards (name, created_at, updated_at)")
    a(f"VALUES ({q(board['name'])}, NOW(), NOW());")
    a("SET @board := LAST_INSERT_ID();")
    a("")
    a("-- Passo 2: status, prioridades e tipos padrao (iguais aos que o")
    a("-- BoardController cria quando o board nasce pela interface)")
    for i, (nome, cor) in enumerate(STATUSES):
        a("INSERT INTO statuses (board_id, area, name, color, `order`, created_at, updated_at)")
        a(f"VALUES (@board, 'programming', {q(nome)}, {q(cor)}, {i}, NOW(), NOW());")
    a("")
    for i, (nome, cor) in enumerate(PRIORITIES):
        a("INSERT INTO priorities (board_id, area, name, color, `order`, created_at, updated_at)")
        a(f"VALUES (@board, 'programming', {q(nome)}, {q(cor)}, {i}, NOW(), NOW());")
    a("")
    for i, (nome, cor) in enumerate(TASK_TYPES):
        a("INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)")
        a(f"VALUES (@board, 'programming', {q(nome)}, {q(cor)}, {i}, NOW(), NOW());")
    a("")
    a("SET @fila := (SELECT id FROM statuses WHERE board_id = @board AND name = 'Em Fila' LIMIT 1);")
    a("")
    a(f"-- Passo 3: as {len(sprints)} sprints")
    for i, s in enumerate(sprints, start=1):
        a("INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)")
        a(f"VALUES (@board, {q(s['name'])}, {q(s['start_date'])}, {q(s['end_date'])}, {i}, NOW(), NOW());")
        a(f"SET @sprint{i} := LAST_INSERT_ID();")
    a("")
    a(f"-- Passo 4: as {len(tasks)} cards, todas em 'Em Fila'")
    for i, t in enumerate(tasks, start=1):
        tipo = NOMES_REAIS.get(t["type"], t["type"])
        prio = NOMES_REAIS.get(t["priority"], t["priority"])
        a(f"-- {t['codigo']}")
        a("INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,")
        a("                   priority, epic, type, notes, sort_order, created_at, updated_at)")
        a("VALUES (")
        a("  @board, 'programming',")
        a(f"  @sprint{t['sprint']},")
        a("  @fila,")
        a(f"  {q(t['titulo'])},")
        a(f"  {q(t['description'])},")
        a(f"  {q(prio)},")
        a(f"  {q(t['epic'])},")
        a(f"  {q(tipo)},")
        a(f"  {q(t['notes'])},")
        a(f"  {i},")
        a("  NOW(), NOW()")
        a(");")
        a("")
    a("COMMIT;")
    a("")
    a("-- Conferencia depois de rodar:")
    a("-- SELECT id, name FROM boards WHERE id = @board;")
    a("-- SELECT s.name, COUNT(t.id) FROM sprints s")
    a("--   LEFT JOIN tasks t ON t.sprint_id = s.id")
    a("--   WHERE s.board_id = @board GROUP BY s.id ORDER BY s.sort_order;")
    a("")

    SQL.write_text("\n".join(L), encoding="utf-8")
    print(f"OK: {SQL.name} gerado com {len(sprints)} sprints e {len(tasks)} cards.")


if __name__ == "__main__":
    main()
