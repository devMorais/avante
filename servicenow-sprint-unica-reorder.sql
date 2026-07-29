-- ============================================================
-- Redistribui a ordem das 34 tasks da Sprint única (id 152) numa
-- sequência pedagógica variada, intercalando o conteúdo original
-- (Dias 1-6, entrevista já realizada) com o conteúdo novo de
-- CIS-DF/scripting, em vez de dois blocos separados.
-- ============================================================
UPDATE tasks SET sort_order = CASE id
  WHEN 121 THEN 1  WHEN 122 THEN 2  WHEN 123 THEN 3  WHEN 124 THEN 4
  WHEN 832 THEN 5
  WHEN 125 THEN 6  WHEN 126 THEN 7  WHEN 127 THEN 8
  WHEN 141 THEN 9  WHEN 142 THEN 10 WHEN 143 THEN 11
  WHEN 833 THEN 12
  WHEN 144 THEN 13 WHEN 145 THEN 14 WHEN 146 THEN 15
  WHEN 827 THEN 16
  WHEN 828 THEN 17
  WHEN 147 THEN 18 WHEN 148 THEN 19
  WHEN 149 THEN 20
  WHEN 829 THEN 21
  WHEN 830 THEN 22
  WHEN 831 THEN 23
  WHEN 150 THEN 24
  WHEN 826 THEN 25
  WHEN 834 THEN 26 WHEN 835 THEN 27
  WHEN 836 THEN 28
  WHEN 837 THEN 29
  WHEN 151 THEN 30 WHEN 152 THEN 31 WHEN 153 THEN 32
  WHEN 838 THEN 33
  WHEN 839 THEN 34
  ELSE sort_order END
WHERE board_id=4 AND sprint_id=152;
