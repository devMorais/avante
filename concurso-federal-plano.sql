-- ============================================================
-- Novo quadro: "Concurso Federal - Informática"
-- Gerado a partir da curadoria de 8 cursos analisados nesta sessão
-- (cortando cada um só no que é conteúdo real de prova, não o curso
-- inteiro). Sprint única, conforme pedido. Board pessoal de estudo,
-- sem relação com Avante/Dolen — todas as demandas ficam com Fernando.
-- ============================================================

-- ============================================================
-- PARTE 1 — BOARD, STATUSES, PRIORITIES, TASK_TYPES, TAGS
-- ============================================================
INSERT INTO boards (name, created_at, updated_at) VALUES ('Concurso Federal - Informática', NOW(), NOW());

INSERT INTO statuses (board_id, name, color, `order`, created_at, updated_at)
SELECT id, 'Em Fila', '#6B6B70', 0, NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO statuses (board_id, name, color, `order`, created_at, updated_at)
SELECT id, 'Em Andamento', '#0284C7', 1, NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO statuses (board_id, name, color, `order`, created_at, updated_at)
SELECT id, 'Em Revisão', '#D97706', 2, NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO statuses (board_id, name, color, `order`, created_at, updated_at)
SELECT id, 'Concluída', '#059669', 3, NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';

INSERT INTO priorities (board_id, name, color, `order`, created_at, updated_at)
SELECT id, 'Baixa', '#059669', 0, NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO priorities (board_id, name, color, `order`, created_at, updated_at)
SELECT id, 'Média', '#0284C7', 1, NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO priorities (board_id, name, color, `order`, created_at, updated_at)
SELECT id, 'Alta', '#EA580C', 2, NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO priorities (board_id, name, color, `order`, created_at, updated_at)
SELECT id, 'Urgente', '#DC2626', 3, NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';

INSERT INTO task_types (board_id, name, color, `order`, created_at, updated_at)
SELECT id, 'Tarefa', '#6B6B70', 0, NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO task_types (board_id, name, color, `order`, created_at, updated_at)
SELECT id, 'História', '#7C3AED', 1, NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO task_types (board_id, name, color, `order`, created_at, updated_at)
SELECT id, 'Bug', '#DC2626', 2, NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO task_types (board_id, name, color, `order`, created_at, updated_at)
SELECT id, 'Melhoria', '#0284C7', 3, NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';

INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'Lógica/Algoritmos', '#7C3AED', NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'POO', '#0284C7', NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'Banco de Dados', '#059669', NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'Redes', '#0369A1', NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'Linux/SO', '#D97706', NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'Raciocínio Lógico', '#DB2777', NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO tags (board_id, name, color, created_at, updated_at) SELECT id, 'Lacuna', '#DC2626', NOW(), NOW() FROM boards WHERE name = 'Concurso Federal - Informática';

-- ============================================================
-- PARTE 2 — SPRINT ÚNICA
-- ============================================================
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint 1 — Revisão Curada de Todo o Conteúdo', '2026-08-03', '2026-09-13', NOW(), NOW()
FROM boards WHERE name = 'Concurso Federal - Informática';

-- ============================================================
-- PARTE 3 — META-01 (contexto vivo do plano)
-- ============================================================
INSERT INTO tasks (board_id, sprint_id, status_id, description, notes, priority, epic, sort_order, created_at, updated_at)
SELECT
  b.id,
  (SELECT id FROM sprints WHERE board_id = b.id LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = b.id AND name = 'Em Fila' LIMIT 1),
  '[META-01] Contexto do plano de estudos para concurso federal

Este quadro nasceu de uma curadoria de 41+ cursos da biblioteca Udemy, filtrando só o que é plausível cair numa prova de concurso público federal (cargo de TI: Analista/Técnico), com foco maior em Redes/Cabeamento e Linux (onde havia menos base), e menor em Atendimento (área já coberta pela experiência prévia com a prova da Fibra-DF).

📖 MÉTODO
Cada demanda representa um curso já filtrado — assista SÓ as aulas listadas em "O que assistir", pule o resto (é código/infra/mercado, não teoria de prova). Depois de cada bloco, faça um simulado de múltipla escolha (o mesmo formato usado no plano da prova Fibra-DF) cobrindo o conteúdo assistido, e repita só as questões erradas até dominar.

📋 RESUMO DA CURADORIA (8 cursos avaliados e cortados)
- Algoritmos e Lógica de Programação — base, mas sem estrutura de dados
- Java POO Completo — o mais robusto, cobre POO+coleções+exceções+interfaces
- PHP Orientado a Objetos — reforço de POO em outra linguagem, curso 90% descartado
- Banco de Dados e SQL — modelagem, DML/DDL, JOIN, agregação, subquery (curso de 58h reduzido a ~40 aulas úteis)
- Redes de Computadores (Módulo 1 e 2) — o melhor curso da lista, quase 100% aproveitável
- Formação Linux Completa — só fundamentos, configuração avançada de servidor descartada
- Shell Script — quase 100% aproveitável, muito bem focado
- Matemática — só razão/proporção/regra de três/porcentagem/juros/fatorial; resto é ensino médio genérico

⚠️ LACUNAS CONHECIDAS (sem curso identificado até agora)
- Segurança da Informação (malware, criptografia, backup como conceito de segurança, LGPD) — nenhum curso da biblioteca cobre isso
- Lógica Proposicional/Raciocínio Lógico puro (tabela-verdade, análise combinatória, probabilidade, conjuntos) — o curso de Matemática da biblioteca é ensino médio geral, não cobre isso
- 2 cursos de PHP OOP ainda não foram enviados/avaliados (Alexandre Cardoso, Diego Mariano)
- Cursos de Excel/Office (5 na biblioteca) ainda pendentes de confirmação se entram no escopo',
  '# Curadoria completa — o que assistir em cada curso

Ver o critério de corte de cada curso na descrição da demanda correspondente. Regra geral aplicada: teoria/conceito que aparece em prova = assistir; configuração de ferramenta específica, instalação, ou curso de mercado/certificação avançada (Spring Boot, Oracle DBA interno, SAMBA AD etc.) = pular.',
  'Alta',
  'Meta: Documentação Viva',
  0,
  NOW(), NOW()
FROM boards b WHERE b.name = 'Concurso Federal - Informática';

-- ============================================================
-- PARTE 4 — DEMANDAS DE REVISÃO (D-01 a D-08: cursos já curados)
-- ============================================================

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT b.id,
  (SELECT id FROM sprints WHERE board_id = b.id LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = b.id AND name = 'Em Fila' LIMIT 1),
  '[D-01] Revisão: Algoritmos e Lógica de Programação

📖 CONTEXTO
Curso: "[SerTop] Algoritmos e Lógica - I" (Estía Training, 34 aulas, 7,5h). Base de tudo — lógica de programação é item quase garantido em edital de TI.

📚 O QUE ASSISTIR
- Aulas 7-9: O que é Algoritmo, Inferência lógica, Princípio da dedução e indução
- Aula 12: Pseudocódigo e Portugol (é a "linguagem" usada por bancas de concurso)
- Aulas 14-17: Tipos de dados, Variáveis, Entrada/saída
- Aulas 19-27: Operadores lógicos/aritméticos/relacionais/concatenação, e as estruturas SE/SENÃO, ESCOLHA, PARA, ENQUANTO, REPITA

🚫 O QUE PULAR
Aulas 1-6 (boas-vindas/carreira), 10-11 (JavaScript/instalação), 13 (Visual Studio), 28-34 (Git/GitHub/HackerRank)

⚠️ LACUNA DO CURSO: não cobre vetores/matrizes/estrutura de dados — isso fica coberto no curso de Java (D-02).

📋 CRITÉRIOS DE ACEITE
- [ ] Assistiu todas as aulas listadas em "O que assistir"
- [ ] Fez um simulado próprio de pseudocódigo/Portugol (10 questões) cobrindo as estruturas SE/PARA/ENQUANTO
- [ ] Revisou as questões erradas e refez até acertar todas',
  'Alta', 'Lógica/Algoritmos', 'Tarefa', 1, NOW(), NOW()
FROM boards b WHERE b.name = 'Concurso Federal - Informática';

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT b.id,
  (SELECT id FROM sprints WHERE board_id = b.id LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = b.id AND name = 'Em Fila' LIMIT 1),
  '[D-02] Revisão: Java Programação Orientada a Objetos Completo

📖 CONTEXTO
Curso: "Java COMPLETO Programação Orientada a Objetos + Projetos" (Nelio Alves, 408 aulas, 54h). O curso mais robusto da lista — cobre POO completa, estruturas de dados e coleções. Só ~55% do curso é conteúdo de prova, o resto é Spring/JPA/Mongo/JavaFX (mercado, não edital).

📚 O QUE ASSISTIR (aulas 1-211, aproximadamente 25h)
- Aulas 6-25: Algoritmo, compilação x interpretação, JDK/JVM
- Aulas 26-68: Variáveis, operadores, if-else/switch, while/for/do-while com teste de mesa
- Aulas 69-91: Classes, métodos, construtores, encapsulamento, modificadores de acesso
- Aulas 92-111: Vetores, Listas e Matrizes (fecha a lacuna deixada em D-01)
- Aulas 125-148: Enumerações, Composição, Herança, Polimorfismo, classes/métodos abstratos
- Aulas 149-160: Tratamento de exceções (try-catch-finally, exceções customizadas)
- Aulas 171-198: Interfaces, Generics, Set, Map (Collections Framework)
- Aulas 199-211: Lambda/Stream API
- Aula 242 (avulsa, dentro do módulo JDBC): nivelamento de Álgebra Relacional e SQL

🚫 O QUE PULAR
Aulas 212-238 (Git avançado), 239-241 e 243-264 (JDBC/DAO, exceto a aula 242), 265-304 (Spring Boot/JPA/Hibernate/Heroku), 305-337 (projeto Xadrez, opcional como exercício), 338-407 (MongoDB, JavaFX)

📋 CRITÉRIOS DE ACEITE
- [ ] Assistiu todas as aulas do núcleo (1-211 + aula 242)
- [ ] Fez teste de mesa manual de pelo menos 3 exercícios com while/for
- [ ] Fez um simulado próprio (10 questões) cobrindo herança, polimorfismo, interfaces e Collections
- [ ] Revisou as questões erradas e refez até acertar todas',
  'Alta', 'POO', 'Tarefa', 2, NOW(), NOW()
FROM boards b WHERE b.name = 'Concurso Federal - Informática';

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT b.id,
  (SELECT id FROM sprints WHERE board_id = b.id LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = b.id AND name = 'Em Fila' LIMIT 1),
  '[D-03] Revisão: PHP Orientado a Objetos

📖 CONTEXTO
Curso: "Curso de PHP Orientado a Objetos" (Cesar Nicolau Szpak, 100 aulas, 25h). Reforça o mesmo pilar de POO já visto em Java (D-02), em outra linguagem. Só ~2,5h do curso (10 aulas) é conteúdo real de POO — o resto (90 aulas) é construção de um sistema administrativo completo com MVC/PDO/login, que não é teoria de prova.

📚 O QUE ASSISTIR
- Aulas 5-7: Introdução ao PHP OO, Classes e objetos, Método e atributo
- Aulas 9-11: Herança, Classe abstrata, Método abstrato
- Aulas 17-22: Classe/método final, Interface, Atributo estático, Modificadores de acesso (público/privado/protegido)

🚫 O QUE PULAR
Aulas 1-4 (setup), 8 e 12-16 (herança aplicada a CRUD específico), 23-100 inteiras (MVC, rotas, PDO/migrations, formulários, CSRF, login, layout, Git)

📋 CRITÉRIOS DE ACEITE
- [ ] Assistiu as 10 aulas listadas
- [ ] Comparou mentalmente a sintaxe de POO em PHP com a de Java (D-02) — os conceitos são os mesmos, só muda a sintaxe
- [ ] Fez um simulado próprio (10 questões) misturando terminologia de Java e PHP para POO',
  'Média', 'POO', 'Tarefa', 3, NOW(), NOW()
FROM boards b WHERE b.name = 'Concurso Federal - Informática';

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT b.id,
  (SELECT id FROM sprints WHERE board_id = b.id LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = b.id AND name = 'Em Fila' LIMIT 1),
  '[D-04] Revisão: Banco de Dados e SQL

📖 CONTEXTO
Curso: "O curso completo de Banco de Dados e SQL, sem mistérios!" (Felipe Mafra, 313 aulas, 58,5h). É um bundle com o mesmo conteúdo básico de MySQL repetido 3 vezes, mais módulos de SQL Server, Oracle (nível DBA/arquitetura interna) e Data Science/Big Data (fora do escopo). Usar só a primeira passada.

📚 O QUE ASSISTIR (dentro das aulas 1-96, ignorar as repetições em 223-313)
- Aulas 18-19: Modelagem Lógica e Física
- Aulas 20-21, 23: Tipos de dados (CHAR/VARCHAR, ENUM/Numéricos, Nulos/Inteiros)
- Aulas 24-25: Projeções e Seleções (SELECT)
- Aulas 30-32: Tabela Verdade, Operadores Lógicos, Performance
- Aulas 37-40: WHERE, UPDATE, DELETE
- Aulas 41-48: Modelagem completa (1ª Forma Normal, Cardinalidade/Obrigatoriedade, Lógico→Físico, Foreign Key)
- Aulas 50-55: Inserção de dados, relacionamentos 1x1/1xN, Junção, Inner Join
- Aulas 56-57: DML e DDL
- Aulas 62-64: Views, DML em Views, ORDER BY
- Aulas 72-75: GROUP BY/COUNT/MAX/MIN/AVG/SUM (agregação), Subqueries
- Aulas 76-80: Alterar estrutura de tabela, Constraints, Dicionário de Dados, revisão de FK
- Aulas 84-88: Triggers (conceito)
- Aula 89: Autorelacionamento
- Aula 93: 2ª e 3ª Formas Normais

🚫 O QUE PULAR
Instalação/VM (1-17, 49, 66), módulo SQL Server inteiro (96-120), módulo Estatística/Data Science/Big Data (121-146, 211-222), módulo Oracle inteiro (147-210, é nível DBA), e as duas repetições finais (223-313)

📋 CRITÉRIOS DE ACEITE
- [ ] Assistiu as ~40 aulas listadas
- [ ] Praticou escrever manualmente 5 queries com JOIN e 5 com GROUP BY
- [ ] Fez um simulado próprio (10 questões) cobrindo modelagem/normalização, DML/DDL, JOIN e agregação
- [ ] Revisou as questões erradas e refez até acertar todas',
  'Alta', 'Banco de Dados', 'Tarefa', 4, NOW(), NOW()
FROM boards b WHERE b.name = 'Concurso Federal - Informática';

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT b.id,
  (SELECT id FROM sprints WHERE board_id = b.id LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = b.id AND name = 'Em Fila' LIMIT 1),
  '[D-05] Revisão: Redes de Computadores (Módulo 1 e 2)

📖 CONTEXTO
Curso: "Formação em Redes de Computadores - Módulo 1 e 2" (Bruno Wanderley, 185 aulas somadas, ~9h+). O melhor curso da lista pra concurso — cita explicitamente preparação para concurso público no público-alvo. Diferente dos outros, quase tudo é aproveitável.

📚 O QUE ASSISTIR (quase o curso inteiro)
- Módulo 1: Topologias (anel, barramento, estrela, malha), Hub x Switch, Modelo OSI completo, Ethernet/Endereço MAC, Endereço IP e classes, CSMA/CD, domínios de colisão/broadcast, Cabeamento estruturado completo (padrões EIA/TIA, 568A/568B, cabo direto x cross-over, categorias UTP)
- Módulo 2: Switch (funcionamento, tabela de encaminhamento), VLAN (conceito, trunk, 802.1Q), Roteador/Gateway, TCP/IP completo (camadas, DHCP, FTP, HTTP, TCP three-way handshake, cabeçalho TCP, UDP, protocolo IP, ARP, ICMP)

🚫 O QUE PULAR OU DEIXAR PARA DEPOIS
Configurações práticas no Packet Tracer (comandos IOS), Spanning Tree Protocol/PVST+/RSTP, protocolos DTP/VTP, Wireless LAN Controller/Site Survey/arquiteturas Cisco, detalhes profundos de fibra óptica (OTDR, componentes ópticos, SDH), Wireshark prático, instalação do Packet Tracer, posts de anúncio do instrutor

📋 CRITÉRIOS DE ACEITE
- [ ] Assistiu o núcleo completo listado acima
- [ ] Decorou as 4 portas clássicas: 80 (HTTP), 443 (HTTPS), 21 (FTP), 25 (SMTP)
- [ ] Fez um simulado próprio (10 questões) cobrindo Modelo OSI, cabeamento 568B, e TCP/IP
- [ ] Revisou as questões erradas e refez até acertar todas',
  'Alta', 'Redes', 'Tarefa', 5, NOW(), NOW()
FROM boards b WHERE b.name = 'Concurso Federal - Informática';

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT b.id,
  (SELECT id FROM sprints WHERE board_id = b.id LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = b.id AND name = 'Em Fila' LIMIT 1),
  '[D-06] Revisão: Fundamentos de Linux

📖 CONTEXTO
Curso: "Formação Linux Completa: Do Básico ao Avançado" (mateusmuller, 171 aulas, 23h). Curso de nível SysAdmin/DevOps (LPI/LFCE) — a base de comandos é ótima para concurso, mas a configuração avançada de servidores (DNS/FTP/HTTP/Proxy/DHCP/Firewall/LDAP/SAMBA) é conteúdo de certificação profissional, não de edital.

📚 O QUE ASSISTIR (fundamentos, aproximadamente aulas 2-114)
- Distribuições Linux (conceito), FHS/estrutura de diretórios
- Boot do Linux, systemd x SysV, systemctl
- Partições, formatação, fstab, LVM (conceito)
- Gerenciamento de pacotes RPM/Yum
- Comandos de arquivo/diretório, processamento de texto, RegEx
- Redirecionamento (stdin/stdout/stderr), compactação (tar/gzip/bzip2)
- Gerenciamento de processos
- Permissões (normais e especiais, umask) — item muito cobrado
- Link físico x simbólico, localizar arquivos (find)
- Shell Script básico (variáveis, condicionais, loops), Cron
- Gerenciamento de usuários/grupos
- RAID: introdução e níveis

🚫 O QUE PULAR
Instalação de distribuição (CentOS/Rocky/Vagrant), SSH/chaves configuração prática, Chronyd/NTP, Vim a fundo, e praticamente todo o bloco de configuração avançada de servidor (DNS Bind9, FTP vsftpd, NFS, Apache/NGINX/proxy reverso, SQUID, DHCPD, Rsyslog, Rsync, Postfix, Dovecot, Firewalld, LDAP, SAMBA AD) — exceto a aula de "Introdução" de cada um desses (só o conceito, não a configuração)

📋 CRITÉRIOS DE ACEITE
- [ ] Assistiu o núcleo de fundamentos listado acima
- [ ] Praticou no terminal (ou máquina virtual) os comandos básicos de arquivo/permissão/processo
- [ ] Fez um simulado próprio (10 questões) cobrindo permissões, comandos básicos e RAID
- [ ] Revisou as questões erradas e refez até acertar todas',
  'Alta', 'Linux/SO', 'Tarefa', 6, NOW(), NOW()
FROM boards b WHERE b.name = 'Concurso Federal - Informática';

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT b.id,
  (SELECT id FROM sprints WHERE board_id = b.id LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = b.id AND name = 'Em Fila' LIMIT 1),
  '[D-07] Revisão: Shell Script

📖 CONTEXTO
Curso: "Programação Shell Script - Automatizando Rotinas no Linux" (Ricardo Prudenciato, 66 aulas). Curso enxuto e muito bem focado — ao contrário dos mega-cursos anteriores, quase tudo aqui é sintaxe de Shell Script diretamente testável (estruturas condicionais e de repetição em Bash).

📚 O QUE ASSISTIR (aulas 5-49, praticamente o núcleo inteiro)
- Aulas 6-10: Principais comandos Linux
- Aula 12: Redirecionamentos de entrada/saída
- Aula 13: Variáveis no Shell
- Aulas 16-17: File Globbing e Expressões Regulares básico
- Aulas 18-24: Estrutura de um script (permissões, execução, PATH), variáveis, Exit Codes, entrada via read e parâmetros posicionais
- Aulas 28-30: If/Case (estruturas condicionais em Bash)
- Aulas 35-40: For, While, Until, continue/break
- Aulas 46-47: Funções em Shell Script
- Exercícios de cada bloco (25-27, 31-34, 41-45, 48-49)

🚫 O QUE PULAR OU DEIXAR PARA DEPOIS
Aulas 1-4 (introdução/setup), 50-53 (logs e e-mail, mais sysadmin que sintaxe), 58-59 (debug), 63-66 (encerramento/contato)

📋 CRITÉRIOS DE ACEITE
- [ ] Assistiu o núcleo listado acima
- [ ] Escreveu manualmente pelo menos 3 scripts pequenos usando if/for/while
- [ ] Fez um simulado próprio (10 questões) cobrindo sintaxe de If/Case/For/While em Bash
- [ ] Revisou as questões erradas e refez até acertar todas',
  'Média', 'Linux/SO', 'Tarefa', 7, NOW(), NOW()
FROM boards b WHERE b.name = 'Concurso Federal - Informática';

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT b.id,
  (SELECT id FROM sprints WHERE board_id = b.id LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = b.id AND name = 'Em Fila' LIMIT 1),
  '[D-08] Revisão: Matemática (Razão/Proporção, Regra de Três, Porcentagem, Juros)

📖 CONTEXTO
Curso: "Matemática para quem detesta Matemática" (Denis Wiener, 122 aulas, 29,5h). Atenção: é um curso de Matemática básica de ensino médio (aritmética, álgebra, trigonometria), não é "Raciocínio Lógico" no sentido de edital de concurso. Só uma fração pequena do curso é diretamente aplicável.

📚 O QUE ASSISTIR
- Aulas 14-17: Razão e Proporção, Regra de Três
- Aulas 18-19: Porcentagem
- Aulas 20-22: Juros simples e composto
- Aula 56: Números Fatoriais (porta de entrada para Análise Combinatória)
- Aulas 53-54: Sistema de equações

🚫 O QUE PULAR
Aulas 23-32 (Funções 1º/2º grau), 36-42 (Trigonometria), 43-47 (Função exponencial, polinômios, expressões algébricas), 57 (Números complexos), 55 (Vértices/Faces/Arestas), 48-52 (Matrizes), 58-83 ("Uma história sobre...", motivacional sem conteúdo técnico). As listas de exercício (84-122): fazer só as dos tópicos assistidos, não todas.

⚠️ LACUNA IMPORTANTE: este curso NÃO cobre Lógica Proposicional (tabela-verdade, conectivos), Análise Combinatória além do fatorial isolado, Probabilidade básica, nem Conjuntos (diagramas de Venn) — que são o núcleo real de "Raciocínio Lógico-Matemático" em edital. Ver [D-11].

📋 CRITÉRIOS DE ACEITE
- [ ] Assistiu as aulas listadas
- [ ] Fez um simulado próprio (10 questões) cobrindo regra de três, porcentagem e juros
- [ ] Revisou as questões erradas e refez até acertar todas',
  'Média', 'Raciocínio Lógico', 'Tarefa', 8, NOW(), NOW()
FROM boards b WHERE b.name = 'Concurso Federal - Informática';

-- ============================================================
-- PARTE 5 — PENDÊNCIAS E LACUNAS (D-09 a D-12)
-- ============================================================

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT b.id,
  (SELECT id FROM sprints WHERE board_id = b.id LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = b.id AND name = 'Em Fila' LIMIT 1),
  '[D-09] Pendência: avaliar os 2 cursos de PHP OOP ainda não enviados

📖 CONTEXTO
Da lista original de cursos possíveis, 2 ainda não foram abertos e enviados para análise: "PHP Orientado a Objetos Completo" (Alexandre Cardoso, Clube Full-Stack) e "Introdução ao PHP orientado a objetos" (Diego Mariano, Ph.D.). Como D-02 (Java) e D-03 (PHP - Szpak) já cobrem bem o pilar de POO, esses dois provavelmente são redundantes — mas vale confirmar rapidamente antes de descartar.

📋 CRITÉRIOS DE ACEITE
- [ ] Abrir os dois cursos na Udemy e conferir a ementa (só o índice de aulas, sem precisar assistir)
- [ ] Decidir: se o conteúdo for majoritariamente igual ao que já foi coberto em D-02/D-03, descartar sem assistir
- [ ] Se algum tiver algo genuinamente novo (ex: algum tópico de POO não coberto ainda), criar uma demanda específica pra essa parte',
  'Baixa', 'POO', 'Tarefa', 9, NOW(), NOW()
FROM boards b WHERE b.name = 'Concurso Federal - Informática';

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT b.id,
  (SELECT id FROM sprints WHERE board_id = b.id LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = b.id AND name = 'Em Fila' LIMIT 1),
  '[D-10] Lacuna: Segurança da Informação

📖 CONTEXTO
Nenhum curso da biblioteca Udemy analisada cobre Segurança da Informação — item quase sempre presente em edital de TI (malware, criptografia simétrica/assimétrica, backup como conceito de segurança — regra 3-2-1, firewall, autenticação multifator, LGPD, engenharia social/phishing). Esse conteúdo já foi coberto uma vez no plano de estudo da prova Fibra-DF (ver o artifact gerado naquela ocasião), mas vale revisar e aprofundar pro concurso federal.

📋 CRITÉRIOS DE ACEITE
- [ ] Verificar se existe algum curso de Segurança da Informação na biblioteca que ainda não foi mostrado
- [ ] Se não existir, pedir para eu gerar um material de estudo + simulado de Segurança da Informação do zero (mesmo formato usado no plano da prova Fibra-DF)
- [ ] Revisar o conteúdo e fazer o simulado até dominar',
  'Média', 'Lacuna', 'Tarefa', 10, NOW(), NOW()
FROM boards b WHERE b.name = 'Concurso Federal - Informática';

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT b.id,
  (SELECT id FROM sprints WHERE board_id = b.id LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = b.id AND name = 'Em Fila' LIMIT 1),
  '[D-11] Lacuna: Lógica Proposicional e Raciocínio Lógico-Matemático puro

📖 CONTEXTO
O curso de Matemática disponível (D-08) é ensino médio geral, não cobre o núcleo clássico de "Raciocínio Lógico" de edital: lógica proposicional (proposições, conectivos, tabela-verdade, negação de proposição composta, equivalências lógicas), análise combinatória (arranjo, combinação, permutação — além do fatorial isolado já visto), probabilidade básica, e conjuntos (diagramas de Venn, operações). Esse é um bloco praticamente garantido em qualquer edital federal.

📋 CRITÉRIOS DE ACEITE
- [ ] Verificar se existe algum curso específico de Raciocínio Lógico/Lógica Proposicional na biblioteca ainda não mostrado
- [ ] Se não existir, pedir para eu gerar um material de estudo + simulado de Lógica Proposicional/Combinatória/Probabilidade/Conjuntos do zero
- [ ] Revisar o conteúdo e fazer o simulado até dominar',
  'Alta', 'Lacuna', 'Tarefa', 11, NOW(), NOW()
FROM boards b WHERE b.name = 'Concurso Federal - Informática';

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at)
SELECT b.id,
  (SELECT id FROM sprints WHERE board_id = b.id LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = b.id AND name = 'Em Fila' LIMIT 1),
  '[D-12] Decisão pendente: Excel/Office entra no escopo?

📖 CONTEXTO
A biblioteca tem 5 cursos de Excel/Office (Microsoft Excel Completo, Excel 365 Fórmulas Avançadas, Macros VBA para Excel, 9 fórmulas mais usadas, Solver para Logística). Isso é "Informática básica/Office", diferente do bloco de TI técnica (POO/SQL/Redes/Linux) — cai em edital geral/administrativo e às vezes também aparece como bloco básico em edital de TI. Ainda não ficou definido se o cargo-alvo do concurso federal inclui esse bloco.

📋 CRITÉRIOS DE ACEITE
- [ ] Confirmar se o cargo/edital-alvo tem bloco de Informática básica/Office
- [ ] Se sim, mandar o conteúdo dos 5 cursos de Excel para eu analisar e cortar como fiz com os outros
- [ ] Se não, arquivar esta demanda sem necessidade de ação',
  'Baixa', 'Lacuna', 'Tarefa', 12, NOW(), NOW()
FROM boards b WHERE b.name = 'Concurso Federal - Informática';

-- ============================================================
-- PARTE 6 — TAGS POR DEMANDA
-- ============================================================
INSERT INTO task_tag (task_id, tag_id) SELECT t.id, tg.id FROM tasks t JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Lógica/Algoritmos' WHERE t.description LIKE '[D-01]%' AND t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
INSERT INTO task_tag (task_id, tag_id) SELECT t.id, tg.id FROM tasks t JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'POO' WHERE t.description LIKE '[D-02]%' AND t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
INSERT INTO task_tag (task_id, tag_id) SELECT t.id, tg.id FROM tasks t JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'POO' WHERE t.description LIKE '[D-03]%' AND t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
INSERT INTO task_tag (task_id, tag_id) SELECT t.id, tg.id FROM tasks t JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Banco de Dados' WHERE t.description LIKE '[D-04]%' AND t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
INSERT INTO task_tag (task_id, tag_id) SELECT t.id, tg.id FROM tasks t JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Redes' WHERE t.description LIKE '[D-05]%' AND t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
INSERT INTO task_tag (task_id, tag_id) SELECT t.id, tg.id FROM tasks t JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Linux/SO' WHERE t.description LIKE '[D-06]%' AND t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
INSERT INTO task_tag (task_id, tag_id) SELECT t.id, tg.id FROM tasks t JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Linux/SO' WHERE t.description LIKE '[D-07]%' AND t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
INSERT INTO task_tag (task_id, tag_id) SELECT t.id, tg.id FROM tasks t JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Raciocínio Lógico' WHERE t.description LIKE '[D-08]%' AND t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
INSERT INTO task_tag (task_id, tag_id) SELECT t.id, tg.id FROM tasks t JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'POO' WHERE t.description LIKE '[D-09]%' AND t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
INSERT INTO task_tag (task_id, tag_id) SELECT t.id, tg.id FROM tasks t JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Lacuna' WHERE t.description LIKE '[D-10]%' AND t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
INSERT INTO task_tag (task_id, tag_id) SELECT t.id, tg.id FROM tasks t JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Raciocínio Lógico' WHERE t.description LIKE '[D-11]%' AND t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
INSERT INTO task_tag (task_id, tag_id) SELECT t.id, tg.id FROM tasks t JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Lacuna' WHERE t.description LIKE '[D-11]%' AND t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
INSERT INTO task_tag (task_id, tag_id) SELECT t.id, tg.id FROM tasks t JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Lacuna' WHERE t.description LIKE '[D-12]%' AND t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');

-- ============================================================
-- PARTE 7 — RESPONSÁVEL (Fernando, id 1, em todas — board pessoal)
-- ============================================================
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 1, NOW(), NOW() FROM tasks t
WHERE t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática')
AND t.description LIKE '[D-%]%';

-- ============================================================
-- PARTE 8 — Conferência final
-- ============================================================
SELECT id, name FROM boards WHERE name = 'Concurso Federal - Informática';
SELECT COUNT(*) AS total_tasks FROM tasks WHERE board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
SELECT priority, COUNT(*) AS qtd FROM tasks WHERE board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática') GROUP BY priority;
SELECT tg.name AS tag, COUNT(*) AS qtd FROM task_tag tt JOIN tags tg ON tg.id = tt.tag_id JOIN tasks t ON t.id = tt.task_id WHERE t.board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática') GROUP BY tg.name;
