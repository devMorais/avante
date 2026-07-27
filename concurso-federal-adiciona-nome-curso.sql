-- ============================================================
-- Adiciona o nome do curso na linha 📺 de cada demanda do board
-- "Concurso Federal - Informática", pra facilitar achar a aula
-- certa quando são vários cursos abertos ao mesmo tempo.
-- Rodar UMA VEZ (idempotente: usa a ausência de "📺 Curso:" como
-- condição, então rodar de novo não duplica o prefixo).
-- ============================================================

SET @board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');

-- BLOCO 1 — D-01 a D-10 — [SerTop] Algoritmos e Lógica - I
UPDATE tasks
SET description = REPLACE(description, '📺 Aula', '📺 Curso: [SerTop] Algoritmos e Lógica - I\n📺 Aula')
WHERE board_id = @board_id
  AND description NOT LIKE '%📺 Curso:%'
  AND (description LIKE '[D-01]%' OR description LIKE '[D-02]%' OR description LIKE '[D-03]%' OR description LIKE '[D-04]%' OR description LIKE '[D-05]%'
       OR description LIKE '[D-06]%' OR description LIKE '[D-07]%' OR description LIKE '[D-08]%' OR description LIKE '[D-09]%' OR description LIKE '[D-10]%');

-- BLOCO 2 — D-11 a D-40 — Java COMPLETO Programação Orientada a Objetos (Nelio Alves)
UPDATE tasks
SET description = REPLACE(description, '📺 Aula', '📺 Curso: Java COMPLETO Programação Orientada a Objetos (Nelio Alves)\n📺 Aula')
WHERE board_id = @board_id
  AND description NOT LIKE '%📺 Curso:%'
  AND description REGEXP '^\\[D-(1[1-9]|[23][0-9]|40)\\]';

-- BLOCO 3 — D-41 a D-47 — Curso de PHP Orientado a Objetos (Cesar Nicolau Szpak)
UPDATE tasks
SET description = REPLACE(description, '📺 Aula', '📺 Curso: Curso de PHP Orientado a Objetos (Cesar Nicolau Szpak)\n📺 Aula')
WHERE board_id = @board_id
  AND description NOT LIKE '%📺 Curso:%'
  AND description REGEXP '^\\[D-4[1-7]\\]';

-- BLOCO 4 — D-48 a D-68 — O curso completo de Banco de Dados e SQL (Felipe Mafra)
UPDATE tasks
SET description = REPLACE(description, '📺 Aula', '📺 Curso: O curso completo de Banco de Dados e SQL (Felipe Mafra)\n📺 Aula')
WHERE board_id = @board_id
  AND description NOT LIKE '%📺 Curso:%'
  AND description REGEXP '^\\[D-(4[89]|5[0-9]|6[0-8])\\]';

-- BLOCO 5 — D-69 a D-90 — Formação em Redes de Computadores, Módulo 1 e 2 (Bruno Wanderley)
UPDATE tasks
SET description = REPLACE(description, '📺 Aula', '📺 Curso: Formação em Redes de Computadores (Bruno Wanderley)\n📺 Aula')
WHERE board_id = @board_id
  AND description NOT LIKE '%📺 Curso:%'
  AND description REGEXP '^\\[D-(69|[78][0-9]|90)\\]';

-- BLOCO 6 — D-91 a D-109 — Formação Linux Completa (mateusmuller)
UPDATE tasks
SET description = REPLACE(description, '📺 Aula', '📺 Curso: Formação Linux Completa (mateusmuller)\n📺 Aula')
WHERE board_id = @board_id
  AND description NOT LIKE '%📺 Curso:%'
  AND description REGEXP '^\\[D-(9[1-9]|10[0-9])\\]';

-- BLOCO 7 — D-110 a D-122 — Programação Shell Script (Ricardo Prudenciato)
UPDATE tasks
SET description = REPLACE(description, '📺 Aula', '📺 Curso: Programação Shell Script (Ricardo Prudenciato)\n📺 Aula')
WHERE board_id = @board_id
  AND description NOT LIKE '%📺 Curso:%'
  AND description REGEXP '^\\[D-1(1[0-9]|2[0-2])\\]';

-- BLOCO 8 — D-123 a D-128 — Matemática para quem detesta Matemática (Denis Wiener)
UPDATE tasks
SET description = REPLACE(description, '📺 Aula', '📺 Curso: Matemática para quem detesta Matemática (Denis Wiener)\n📺 Aula')
WHERE board_id = @board_id
  AND description NOT LIKE '%📺 Curso:%'
  AND description REGEXP '^\\[D-12[3-8]\\]';

-- Conferência
SELECT COUNT(*) AS total_com_curso FROM tasks WHERE board_id = @board_id AND description LIKE '%📺 Curso:%';
SELECT COUNT(*) AS total_sem_curso_mas_com_aula FROM tasks WHERE board_id = @board_id AND description LIKE '%📺 Aula%' AND description NOT LIKE '%📺 Curso:%';
