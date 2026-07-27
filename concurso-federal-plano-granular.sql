-- ============================================================
-- Reset do plano do board "Concurso Federal - Informática" (16)
-- Substitui o plano anterior (13 tasks / 1 sprint / só Fernando) por
-- uma versão granular: demandas de 1-2 aulas cada, em DUAS sprints
-- com conteúdo IDÊNTICO — uma para Fernando, outra para Claudia,
-- estudando em paralelo. Sem tarefa META desta vez.
-- Reaproveita board/status/prioridades/tipos/tags já existentes.
-- Rodar UMA VEZ.
-- ============================================================

DELETE FROM tasks WHERE board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
DELETE FROM sprints WHERE board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');

INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint Fernando — Revisão Granular', '2026-08-03', '2026-11-30', NOW(), NOW()
FROM boards WHERE name = 'Concurso Federal - Informática';
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
SELECT id, 'Sprint Claudia — Revisão Granular', '2026-08-03', '2026-11-30', NOW(), NOW()
FROM boards WHERE name = 'Concurso Federal - Informática';

SET @board_id = (SELECT id FROM boards WHERE name = 'Concurso Federal - Informática');
SET @status_fila = (SELECT id FROM statuses WHERE board_id = @board_id AND name = 'Em Fila');
SET @sprint_f = (SELECT id FROM sprints WHERE board_id = @board_id AND name = 'Sprint Fernando — Revisão Granular');
SET @sprint_c = (SELECT id FROM sprints WHERE board_id = @board_id AND name = 'Sprint Claudia — Revisão Granular');

-- ============================================================
-- BLOCO 1 — LÓGICA/ALGORITMOS (D-01 a D-10), prioridade Alta
-- Curso: [SerTop] Algoritmos e Lógica - I
-- ============================================================

SET @d = '[D-01] O que é pensar como algoritmo

🎯 Todo problema de prova começa igual: alguém descreveu um processo, e você precisa enxergar os passos escondidos nele.
📺 Aulas 7-8: "O que é Algoritmo?" e "Inferência lógica"
✅ Feito quando: você conseguir explicar em voz alta, sem olhar a aula, o que é um algoritmo e um exemplo de inferência lógica do dia a dia.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 1, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 1, NOW(), NOW());

SET @d = '[D-02] Dedução e indução, os dois lados do raciocínio

🎯 Banca adora dar 3 exemplos e pedir a regra geral (indução), ou dar a regra e pedir a consequência (dedução).
📺 Aula 9: "Princípio da dedução e indução"
✅ Feito quando: você souber identificar, numa questão, se ela pede dedução ou indução.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 2, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 2, NOW(), NOW());

SET @d = '[D-03] Portugol: a língua que toda banca fala

🎯 O item mais importante do curso inteiro — banca escreve questão de lógica em pseudocódigo/Portugol, não em Java ou PHP.
📺 Aula 12: "Pseudocódigo e Portugol"
✅ Feito quando: você conseguir ler um trecho pequeno de Portugol sem travar.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 3, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 3, NOW(), NOW());

SET @d = '[D-04] Tipos de dados e variáveis: as caixinhas do programa

🎯 Antes de guardar qualquer coisa, você precisa saber que tipo de coisa está guardando.
📺 Aulas 14-15: "Tipos de dados" e "Variáveis"
✅ Feito quando: você souber nomear os tipos de dados básicos e explicar o que é uma variável sem recorrer ao vídeo.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 4, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 4, NOW(), NOW());

SET @d = '[D-05] Entrada, saída e comentários

🎯 Todo algoritmo de prova tem um "leia" e um "escreva" — e comentário é a nota que você deixa pra você mesmo entender depois.
📺 Aulas 16-17: "Saída e Entrada de dados" e "Utilização de Comentários"
✅ Feito quando: você souber montar mentalmente um algoritmo simples com leia/escreva.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 5, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 5, NOW(), NOW());

SET @d = '[D-06] Operações lógicas: E, OU e NÃO

🎯 A base de toda tabela-verdade que também vai aparecer em Segurança/Raciocínio Lógico mora aqui.
📺 Aula 19: "Operações lógicas"
✅ Feito quando: você souber montar a tabela-verdade do E e do OU de cabeça.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 6, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 6, NOW(), NOW());

SET @d = '[D-07] Operadores aritméticos e relacionais

🎯 Somar é fácil. O truque de prova é a precedência: quem calcula primeiro quando tem tudo junto na mesma linha?
📺 Aulas 20-21: "Operadores aritméticos" e "Operadores relacionais"
✅ Feito quando: você souber resolver uma expressão com + - * / e comparação numa ordem só, sem calculadora.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 7, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 7, NOW(), NOW());

SET @d = '[D-08] Concatenação: juntando texto

🎯 Pequeno, mas cai — como colar dois pedaços de texto num só.
📺 Aula 22: "Operadores de concatenação"
✅ Feito quando: você souber concatenar duas strings de cabeça.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 8, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 8, NOW(), NOW());

SET @d = '[D-09] SE/SENÃO e ESCOLHA: os dois jeitos de decidir

🎯 As duas estruturas de decisão que toda questão de Portugol usa pra criar um "labirinto" de caminhos.
📺 Aulas 23-24: "Estrutura SE e SENAO" e "Estrutura ESCOLHA"
✅ Feito quando: você conseguir seguir na mão (sem rodar código) um SE-SENÃO aninhado com 2 níveis.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 9, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 9, NOW(), NOW());

SET @d = '[D-10] PARA, ENQUANTO e REPITA: os três loops clássicos

🎯 Toda questão de "quantas vezes esse trecho roda" mora aqui — é onde mais gente erra por perder a conta.
📺 Aulas 25-27: "Estrutura PARA", "Estrutura ENQUANTO" e "Estrutura REPITA"
✅ Feito quando: você souber a diferença entre um loop que testa a condição antes e um que testa depois (REPITA).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 10, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Lógica/Algoritmos', 'Tarefa', 10, NOW(), NOW());

-- ============================================================
-- BLOCO 2 — JAVA POO (D-11 a D-40), prioridade Alta
-- Curso: Java COMPLETO Programação Orientada a Objetos (Nelio Alves)
-- ============================================================

SET @d = '[D-11] Antes do código: o que é mesmo um programa

🎯 Todo curso técnico começa igual — e essa base vale tanto pra prova quanto pra qualquer linguagem que aparecer no edital.
📺 Aulas 8-12: Algoritmo/Programa de Computador, Linguagem de programação, IDE, Compilação x interpretação
✅ Feito quando: você souber explicar a diferença entre linguagem compilada e interpretada com um exemplo de cada.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 11, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 11, NOW(), NOW());

SET @d = '[D-12] JDK, JVM e a estrutura de um programa Java

🎯 Essa sopa de letrinhas (JDK/JVM) aparece direto em questão de "o que roda o quê" no Java.
📺 Aulas 15-18: Versões do Java, Histórico, JDK/JVM, Estrutura de uma aplicação Java
✅ Feito quando: você souber explicar pra que serve o JDK e pra que serve a JVM, sem trocar um pelo outro.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 12, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 12, NOW(), NOW());

SET @d = '[D-13] Seu primeiro Hello World em Java

🎯 Ver o programa rodar de verdade fixa muito mais do que só ler sobre sintaxe.
📺 Aulas 24-25: Primeiro programa Java no Eclipse, Sintaxe simplificada
✅ Feito quando: você tiver rodado pelo menos um programa Java simples até o fim, sem erro.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 13, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 13, NOW(), NOW());

SET @d = '[D-14] Expressões aritméticas, variáveis e tipos básicos em Java

🎯 A mesma lógica de "caixinhas" que você já viu em Portugol (D-04), agora com a sintaxe real de uma linguagem.
📺 Aulas 28-29: Expressões aritméticas, Variáveis e tipos básicos em Java
✅ Feito quando: você souber declarar uma variável int, double e String de cabeça.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 14, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 14, NOW(), NOW());

SET @d = '[D-15] As três operações básicas e a saída de dados

🎯 Entrada, processamento e saída — o esqueleto de qualquer programa, mais o conceito de casting (converter um tipo em outro).
📺 Aulas 30-32: As três operações básicas de programação, Saída de dados, Processamento de dados/Casting
✅ Feito quando: você souber explicar o que é casting com um exemplo (ex: double virando int).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 15, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 15, NOW(), NOW());

SET @d = '[D-16] Entrada de dados e funções matemáticas

🎯 Ler o que o usuário digita é a outra ponta do "leia" que você já viu em Portugol.
📺 Aulas 33-35: Entrada de dados em Java (partes 1-2), Funções matemáticas em Java
✅ Feito quando: você souber ler um número digitado pelo teclado num programa Java.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 16, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 16, NOW(), NOW());

SET @d = '[D-17] Comparações e decisões: if-else em Java

🎯 O SE/SENÃO do Portugol (D-09) ganha aqui a sintaxe { } que toda linguagem C-like usa.
📺 Aulas 40-42: Expressões comparativas, Expressões lógicas, Estrutura condicional (if-else)
✅ Feito quando: você souber escrever um if-else com uma condição composta (E/OU) sem consultar nada.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 17, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 17, NOW(), NOW());

SET @d = '[D-18] Atribuição cumulativa, switch-case e operador ternário

🎯 Três atalhos de sintaxe que toda prova adora testar porque parecem "pegadinha" pra quem só decorou o if-else.
📺 Aulas 45-47: Operadores de atribuição cumulativa (+=, -=...), switch-case, Expressão condicional ternária
✅ Feito quando: você souber reescrever um if-else simples como ternário.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 18, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 18, NOW(), NOW());

SET @d = '[D-19] Escopo: onde cada variável pode ser vista

🎯 Erro clássico de quem começa: usar uma variável fora do bloco onde ela foi criada.
📺 Aula 48: Escopo e inicialização
✅ Feito quando: você souber dizer se uma variável declarada dentro de um if pode ser usada fora dele.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 19, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 19, NOW(), NOW());

SET @d = '[D-20] While: repetindo enquanto uma condição for verdadeira

🎯 O ENQUANTO do Portugol (D-10), agora com teste de mesa de verdade pra treinar seguir o valor das variáveis passo a passo.
📺 Aulas 52-53: Estrutura repetitiva while, Teste de mesa com while
✅ Feito quando: você tiver feito o teste de mesa de um while na mão, escrevendo o valor das variáveis a cada volta.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 20, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 20, NOW(), NOW());

SET @d = '[D-21] For: o loop mais usado em prova de concurso

🎯 Se você só puder dominar um tipo de loop antes da prova, que seja esse.
📺 Aulas 57-58: Estrutura repetitiva for, Teste de mesa com for
✅ Feito quando: você souber montar um for contando de trás pra frente sem pensar duas vezes.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 21, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 21, NOW(), NOW());

SET @d = '[D-22] Do-while: o loop que roda pelo menos uma vez

🎯 O REPITA do Portugol (D-10) — a diferença chave é que ele testa a condição DEPOIS, não antes.
📺 Aula 62: Estrutura repetitiva faça-enquanto (do-while)
✅ Feito quando: você souber explicar por que um do-while sempre executa pelo menos uma vez, mesmo com condição falsa.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 22, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 22, NOW(), NOW());

SET @d = '[D-23] Convenções de nomes, operadores bitwise e funções de String

🎯 Um apanhado de detalhes miúdos que costumam aparecer como distrator em questão de múltipla escolha.
📺 Aulas 65-68: Restrições e convenções para nomes, Operadores bitwise, Funções interessantes para String, Comentários e Funções (sintaxe)
✅ Feito quando: você souber pelo menos 3 métodos de String de cor (ex: length, substring, indexOf).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 23, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 23, NOW(), NOW());

SET @d = '[D-24] Do procedural pro orientado a objetos: primeira classe

🎯 O momento em que o curso mostra na prática POR QUE precisamos de classes — resolvendo o mesmo problema com e sem OO.
📺 Aulas 71-74: Resolvendo um problema sem orientação a objetos, Criando uma classe com três atributos (triângulo), Método para reaproveitamento/delegação, Começando o segundo problema
✅ Feito quando: você souber explicar com suas palavras por que a versão com classe ficou mais organizada.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 24, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 24, NOW(), NOW());

SET @d = '[D-25] Object e toString: todo objeto Java tem uma origem comum

🎯 Curiosidade que vira pegadinha de prova: TODA classe em Java, mesmo sem você escrever nada, já herda de Object.
📺 Aulas 75-77: Object e toString, Finalizando o programa, Exercícios de fixação
✅ Feito quando: você souber pra que serve sobrescrever o método toString de uma classe.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 25, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 25, NOW(), NOW());

SET @d = '[D-26] Membros estáticos: o que pertence à classe, não ao objeto

🎯 A diferença entre "cada objeto tem o seu" e "é um só, compartilhado por todos" — item clássico de prova de POO.
📺 Aulas 78-79: Membros estáticos (partes 1-2)
✅ Feito quando: você souber dar um exemplo de quando faz sentido usar static e quando não faz.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 26, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 26, NOW(), NOW());

SET @d = '[D-27] Construtores, this, sobrecarga e encapsulamento

🎯 Quatro dos pilares mais cobrados de POO, todos juntos porque um puxa o outro na prática.
📺 Aulas 83-86: Construtores, Palavra this, Sobrecarga, Encapsulamento
✅ Feito quando: você souber explicar encapsulamento sem usar a palavra "encapsulamento" na explicação.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 27, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 27, NOW(), NOW());

SET @d = '[D-28] Getters, setters e os quatro modificadores de acesso

🎯 public, private, protected e o "pacote" (default) — decorar o alcance de cada um evita erro bobo em questão de código.
📺 Aulas 87-88: Gerando construtores/getters/setters automaticamente no Eclipse, Modificadores de acesso
✅ Feito quando: você souber ordenar os 4 modificadores do mais aberto pro mais fechado.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 28, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 28, NOW(), NOW());

SET @d = '[D-29] Vetores: a estrutura de dados mais cobrada em concurso

🎯 Fecha exatamente a lacuna que o curso de Lógica (Bloco 1) deixou aberta — decore este aqui de verdade.
📺 Aulas 94-98: Tipos referência x tipos valor, Garbage collector/escopo local, Vetores (partes 1-2), Exercícios de fixação
✅ Feito quando: você souber percorrer um vetor com for e somar todos os elementos, na mão.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 29, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 29, NOW(), NOW());

SET @d = '[D-30] Boxing/unboxing e o laço for each

🎯 O "for each" é o jeito mais elegante de percorrer uma coleção — e cai bastante em questão de "qual das opções está correta".
📺 Aulas 101-104: Desafio sobre vetores (pensionato), Correção, Boxing/unboxing e wrapper classes, Laço for each
✅ Feito quando: você souber reescrever um for comum como for each.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 30, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 30, NOW(), NOW());

SET @d = '[D-31] Listas: o vetor que cresce sozinho

🎯 ArrayList é a coleção mais usada do Java no mundo real — e também a mais citada em prova de Collections.
📺 Aulas 105-106: Listas (partes 1-2)
✅ Feito quando: você souber explicar a diferença prática entre um array e uma List.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 31, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 31, NOW(), NOW());

SET @d = '[D-32] Matrizes: o vetor de duas dimensões

🎯 Tabuleiro, planilha, imagem — tudo isso na prática é uma matriz, e questão de prova adora um exemplo assim.
📺 Aula 109: Matrizes
✅ Feito quando: você souber acessar a posição [linha][coluna] de uma matriz sem hesitar.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 32, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 32, NOW(), NOW());

SET @d = '[D-33] Enumerações e composição

🎯 Enum é o jeito certo de representar "um valor dentre um conjunto fixo" (dias da semana, status de pedido...) — muito mais seguro que usar texto solto.
📺 Aulas 127-129: Enumerações, Um pouco sobre design, Composição
✅ Feito quando: você souber dar um exemplo de quando usar enum em vez de String.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 33, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 33, NOW(), NOW());

SET @d = '[D-34] Herança: quando uma classe nasce de outra

🎯 O pilar de POO mais cobrado de todos — inclusive upcasting/downcasting, que é onde a maioria erra.
📺 Aulas 138-141: Herança, Upcasting e downcasting, Sobreposição/palavra super/@Override, Classes e métodos final
✅ Feito quando: você souber explicar a diferença entre upcasting e downcasting com um exemplo.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 34, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 34, NOW(), NOW());

SET @d = '[D-35] Polimorfismo e classes abstratas

🎯 O pilar mais "filosófico" de POO — a mesma chamada de método se comportando diferente dependendo do objeto real por trás dela.
📺 Aulas 142-146: Introdução ao polimorfismo, Exercício resolvido, Classes abstratas, Métodos abstratos
✅ Feito quando: você souber explicar por que uma classe abstrata não pode ser instanciada diretamente.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 35, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 35, NOW(), NOW());

SET @d = '[D-36] Tratamento de exceções: quando o programa pode quebrar

🎯 try-catch-finally e exceções personalizadas — item recorrente em prova de programação de qualquer linguagem.
📺 Aulas 151-155: Discussão inicial sobre exceções, Estrutura try-catch, Pilha de chamadas (stack trace), Bloco finally, Criando exceções personalizadas
✅ Feito quando: você souber explicar em que ordem os blocos try/catch/finally executam.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 36, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 36, NOW(), NOW());

SET @d = '[D-37] Interfaces: o contrato que uma classe promete cumprir

🎯 Diferente de herança (uma classe só pode ter uma classe-mãe), uma classe pode implementar várias interfaces — isso já foi pegadinha de prova.
📺 Aulas 173-177: Interfaces, Solução do problema (partes 1-3), Inversão de controle e injeção de dependência
✅ Feito quando: você souber a diferença entre "implementar uma interface" e "herdar de uma classe".';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 37, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 37, NOW(), NOW());

SET @d = '[D-38] Herança múltipla, Comparable e default methods

🎯 O "problema do diamante" é um clássico de prova teórica — por que Java não permite herança múltipla de classes, mas permite de interfaces.
📺 Aulas 181-184: Herdar x cumprir contrato, Herança múltipla e o problema do diamante, Interface Comparable, Default methods
✅ Feito quando: você souber explicar por que interfaces resolvem o problema do diamante e classes não.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 38, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 38, NOW(), NOW());

SET @d = '[D-39] Generics, Set e Map: o Collections Framework

🎯 Provavelmente o bloco mais denso e mais cobrado em prova de Analista com foco em Java — reserve um tempo maior pra esse aqui.
📺 Aulas 187-198: Generics, Genéricos delimitados, Curingas, HashCode/Equals, Set, TreeSet, exercícios, Map
✅ Feito quando: você souber a diferença entre List, Set e Map em uma frase cada.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 39, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 39, NOW(), NOW());

SET @d = '[D-40] Lambda, Stream e um empurrãozinho de SQL

🎯 Fecha o bloco de Java com o que há de mais moderno na linguagem, mais uma aula avulsa de nivelamento em SQL que serve de ponte pro Bloco de Banco de Dados.
📺 Aulas 202-211: Programação funcional, Interface funcional, Predicate/Consumer/Function, Stream, Pipeline — e a Aula 242 (avulsa): Nivelamento de Álgebra Relacional e SQL
✅ Feito quando: você souber escrever uma expressão lambda simples (ex: filtrar uma lista de números pares).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 40, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'POO', 'Tarefa', 40, NOW(), NOW());

-- ============================================================
-- BLOCO 3 — PHP ORIENTADO A OBJETOS (D-41 a D-47), prioridade Média
-- Curso: Curso de PHP Orientado a Objetos (Cesar Nicolau Szpak)
-- ============================================================

SET @d = '[D-41] POO em outra sotaque: classes e objetos em PHP

🎯 Mesma ideia do Java (D-24), sintaxe diferente — comparar as duas linguagens lado a lado fixa o conceito de verdade.
📺 Aulas 5-6: Introdução ao PHP Orientado a Objetos, Como usar classes e objetos no PHP
✅ Feito quando: você souber apontar 2 diferenças de sintaxe entre declarar uma classe em PHP e em Java.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'POO', 'Tarefa', 41, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'POO', 'Tarefa', 41, NOW(), NOW());

SET @d = '[D-42] Métodos e atributos em PHP

🎯 O $this-> do PHP faz o mesmo papel do this. do Java (D-27) — mesma ideia, símbolo diferente.
📺 Aula 7: Como usar método e atributo com PHP
✅ Feito quando: você souber criar uma classe PHP simples com 1 atributo e 1 método de cabeça.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'POO', 'Tarefa', 42, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'POO', 'Tarefa', 42, NOW(), NOW());

SET @d = '[D-43] Herança em PHP

🎯 O extends do PHP resolve o mesmo problema do extends do Java (D-34) — mais uma chance de fixar o conceito.
📺 Aula 9: Como usar herança no PHP
✅ Feito quando: você souber criar duas classes em PHP com uma herdando da outra.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'POO', 'Tarefa', 43, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'POO', 'Tarefa', 43, NOW(), NOW());

SET @d = '[D-44] Classe e método abstrato em PHP

🎯 Terceira vez vendo esse conceito (Portugol não tem, Java tem em D-35) — se ainda tiver dúvida, é aqui que ela desaparece.
📺 Aulas 10-11: Como usar classe abstrata com PHP, Como usar método abstrato com PHP
✅ Feito quando: você souber por que uma classe abstrata existe mesmo sem poder ser instanciada.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'POO', 'Tarefa', 44, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'POO', 'Tarefa', 44, NOW(), NOW());

SET @d = '[D-45] Classe/método final e interface em PHP

🎯 final impede que algo seja sobrescrito; interface define um contrato — os dois lados opostos de "o que pode mudar".
📺 Aulas 17-18: Como criar classe e método final com PHP, Como criar interface com PHP
✅ Feito quando: você souber explicar por que marcar um método como final é uma decisão de design, não só sintaxe.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'POO', 'Tarefa', 45, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'POO', 'Tarefa', 45, NOW(), NOW());

SET @d = '[D-46] Atributo estático em PHP

🎯 O static do PHP se comporta igual ao static do Java (D-26) — compartilhado por todos os objetos da classe.
📺 Aula 19: Como criar atributo estático com PHP
✅ Feito quando: você souber dar um exemplo de uso de atributo estático (ex: contador de quantos objetos foram criados).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'POO', 'Tarefa', 46, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'POO', 'Tarefa', 46, NOW(), NOW());

SET @d = '[D-47] Público, privado e protegido em PHP

🎯 Fecha o bloco de POO comparando os modificadores de acesso do PHP com os que você já viu em Java (D-28).
📺 Aulas 20-22: Atributo/método público, privado e protegido no PHP
✅ Feito quando: você souber dizer, sem pensar, se um atributo privado de uma classe-mãe pode ser acessado direto pela classe-filha (dica: não pode — isso é pegadinha clássica).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'POO', 'Tarefa', 47, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'POO', 'Tarefa', 47, NOW(), NOW());

-- ============================================================
-- BLOCO 4 — BANCO DE DADOS E SQL (D-48 a D-68), prioridade Alta
-- Curso: O curso completo de Banco de Dados e SQL (Felipe Mafra)
-- ============================================================

SET @d = '[D-48] Modelagem lógica e física: o mapa antes da construção

🎯 Ninguém constrói uma casa sem planta — banco de dados sem modelagem é a mesma armadilha.
📺 Aulas 18-19: Modelagem Lógica e Física
✅ Feito quando: você souber explicar a diferença entre o modelo lógico (conceitual) e o físico (tabelas de verdade).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 48, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 48, NOW(), NOW());

SET @d = '[D-49] CHAR x VARCHAR, ENUM x Numéricos, valores nulos

🎯 Escolher o tipo errado de coluna é um erro que só aparece depois — e é exatamente o tipo de detalhe que uma prova gosta de testar.
📺 Aulas 20-21, 23: Comparando CHAR e VARCHAR, Comparando ENUM e Numéricos, Tipos Nulos e Inteiros
✅ Feito quando: você souber quando usar CHAR em vez de VARCHAR (dica: tamanho fixo).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 49, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 49, NOW(), NOW());

SET @d = '[D-50] Projeções e seleções: o SELECT do dia a dia

🎯 A instrução que você vai escrever mais vezes na vida — e a que mais cai em qualquer prova com bloco de SQL.
📺 Aulas 24-25: Conhecendo as Projeções, Seleções
✅ Feito quando: você souber a diferença entre escolher colunas (projeção) e escolher linhas (seleção) num SELECT.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 50, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 50, NOW(), NOW());

SET @d = '[D-51] Tabela verdade e operadores lógicos em SQL

🎯 O AND/OR do SQL é a mesma lógica E/OU que você já viu em D-06 — só que agora filtrando linhas de uma tabela.
📺 Aulas 30-32: A Tabela Verdade, Operadores Lógicos - Prática, Performance com Operadores Lógicos
✅ Feito quando: você souber prever o resultado de um WHERE com AND e OR combinados, sem rodar a query.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 51, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 51, NOW(), NOW());

SET @d = '[D-52] WHERE e UPDATE: filtrando e alterando

🎯 UPDATE sem WHERE é a lenda urbana de todo DBA — alterar a tabela inteira por engano. Aqui você aprende a usar os dois juntos com segurança.
📺 Aulas 37-38: A cláusula WHERE, A Cláusula Update
✅ Feito quando: você souber escrever um UPDATE que altera só as linhas certas, filtradas por WHERE.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 52, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 52, NOW(), NOW());

SET @d = '[D-53] DELETE: apagando com responsabilidade

🎯 Mesmo cuidado do UPDATE, agora pra apagar — e apagado, sem backup, não volta.
📺 Aula 40: A Cláusula DELETE
✅ Feito quando: você souber a diferença entre DELETE FROM tabela (apaga tudo) e DELETE FROM tabela WHERE... (apaga só o filtrado).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 53, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 53, NOW(), NOW());

SET @d = '[D-54] Por que modelar antes de criar qualquer tabela

🎯 A parte "chata" que evita retrabalho — entender por que a modelagem existe antes de aprender as técnicas dela.
📺 Aulas 41-42: Começando a Modelar, A história da Modelagem
✅ Feito quando: você souber explicar em 2 frases por que pular a modelagem custa caro depois.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 54, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 54, NOW(), NOW());

SET @d = '[D-55] Primeira Forma Normal: o começo da normalização

🎯 O item mais clássico de "modelagem" em qualquer edital — e o mais fácil de errar sem prática.
📺 Aula 43: Primeira Forma Normal
✅ Feito quando: você souber identificar uma tabela que viola a 1FN (ex: uma coluna guardando vários valores separados por vírgula).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 55, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 55, NOW(), NOW());

SET @d = '[D-56] Cardinalidade e obrigatoriedade: as regras do relacionamento

🎯 "1 pra 1", "1 pra muitos", "muitos pra muitos" — decorar essa nomenclatura evita perder questão fácil.
📺 Aula 44: Cardinalidade e Obrigatoriedade
✅ Feito quando: você souber classificar de cabeça um relacionamento (ex: pedido-cliente é N pra 1).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 56, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 56, NOW(), NOW());

SET @d = '[D-57] Do modelo lógico pro modelo físico

🎯 A hora de virar diagrama em CREATE TABLE de verdade.
📺 Aulas 45-46: Transferindo o Modelo Lógico para o Modelo Físico (partes 1-2)
✅ Feito quando: você tiver transformado um diagrama simples (2 entidades) em duas tabelas com SQL.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 57, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 57, NOW(), NOW());

SET @d = '[D-58] Foreign Key: a ponte entre duas tabelas

🎯 Sem chave estrangeira, banco relacional vira só um monte de tabelas soltas sem relação nenhuma.
📺 Aulas 47-48: Entendendo a Foreign Key (partes 1-2)
✅ Feito quando: você souber explicar o que acontece se tentar inserir uma FK que não existe na tabela referenciada.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 58, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 58, NOW(), NOW());

SET @d = '[D-59] Inserindo dados em relacionamentos 1x1 e 1xN

🎯 Saber a teoria de FK (D-58) é uma coisa, saber inserir dados respeitando ela é outra.
📺 Aulas 50-52: Inserindo Dados, Inserções em Relacionamentos 1x1, Inserções 1xN
✅ Feito quando: você souber a ordem certa de inserir (a tabela "pai" sempre antes da "filha").';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 59, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 59, NOW(), NOW());

SET @d = '[D-60] Junção e Inner Join: unindo duas tabelas numa consulta

🎯 Provavelmente o comando SQL mais cobrado depois do SELECT puro — item que aparece em quase toda prova técnica.
📺 Aulas 53-55: Seleção e Projeção, Junção, Inner Join
✅ Feito quando: você souber escrever um INNER JOIN simples entre duas tabelas de cabeça.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 60, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 60, NOW(), NOW());

SET @d = '[D-61] DML x DDL: manipular dado x manipular estrutura

🎯 Confusão clássica de quem está começando — INSERT/UPDATE/DELETE mexem no dado, CREATE/ALTER/DROP mexem na estrutura da tabela.
📺 Aulas 56-57: Comandos de DML, DDL - Modificando Tabelas
✅ Feito quando: você souber classificar 4 comandos SQL diferentes como DML ou DDL sem errar nenhum.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 61, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 61, NOW(), NOW());

SET @d = '[D-62] Views e ORDER BY: consultas prontas e resultados ordenados

🎯 Uma view "congela" uma consulta complexa como se fosse uma tabela — e ORDER BY é o comando que organiza qualquer resultado.
📺 Aulas 62-64: Views, Operações de DML em Views, Ordenando Dados
✅ Feito quando: você souber explicar pra que serve criar uma view em vez de repetir a mesma query toda hora.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 62, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 62, NOW(), NOW());

SET @d = '[D-63] GROUP BY e funções de agregação: somando, contando, tirando média

🎯 COUNT, SUM, AVG, MAX, MIN — as cinco funções que toda prova de SQL testa pelo menos uma vez.
📺 Aulas 72-73: Group By/Count/Max/Min/Avg, Utilizando o SUM
✅ Feito quando: você souber escrever um GROUP BY que conta quantas linhas existem por categoria.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 63, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 63, NOW(), NOW());

SET @d = '[D-64] Subqueries: uma consulta dentro da outra

🎯 Quando um JOIN não resolve, uma query dentro de outra costuma resolver — e prova adora testar se você entende a ordem de execução.
📺 Aula 74: Utilizando Subqueries
✅ Feito quando: você souber identificar qual parte de uma query com subquery executa primeiro.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 64, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 64, NOW(), NOW());

SET @d = '[D-65] Alterando tabelas, constraints e dicionário de dados

🎯 Constraint é a regra que o banco obriga sozinho (ex: não aceitar e-mail duplicado) — e o dicionário de dados é onde tudo isso fica documentado.
📺 Aulas 76-80: Verificando/alterando estrutura de tabela, Organizando chaves e dicionário de dados, Constraints nomeadas x dicionário, Querys de dicionário, Revisão de Foreign Keys
✅ Feito quando: você souber dar um exemplo de constraint além de FK (ex: NOT NULL, UNIQUE).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 65, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 65, NOW(), NOW());

SET @d = '[D-66] Triggers: o banco reagindo sozinho a um evento

🎯 Um "gatilho" que dispara automaticamente quando algo acontece na tabela (inserir, atualizar, apagar) — item de nível um pouco mais avançado, mas que aparece em edital mais técnico.
📺 Aulas 84-88: Introdução às Triggers, Trigger na prática, Triggers para backups, Eventos de uma trigger, Auditando tabela com trigger
✅ Feito quando: você souber explicar com suas palavras o que é uma trigger, sem juridiquês técnico.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 66, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 66, NOW(), NOW());

SET @d = '[D-67] Autorelacionamento: quando uma tabela se relaciona com ela mesma

🎯 Funcionário que tem um funcionário como chefe, categoria que tem uma categoria "pai" — o clássico exemplo de autorelacionamento.
📺 Aula 89: Eu e eu mesmo! O Autorelacionamento
✅ Feito quando: você conseguir pensar em um exemplo próprio de autorelacionamento, diferente do que foi usado na aula.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 67, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 67, NOW(), NOW());

SET @d = '[D-68] 2ª e 3ª Formas Normais: fechando a normalização

🎯 Depois da 1FN (D-55), essas duas fecham o trio mais cobrado de normalização em qualquer edital com bloco de modelagem.
📺 Aula 93: 2 e 3 Formas Normais
✅ Feito quando: você souber a diferença entre o que a 2FN resolve e o que a 3FN resolve.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 68, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Banco de Dados', 'Tarefa', 68, NOW(), NOW());

-- ============================================================
-- BLOCO 5 — REDES DE COMPUTADORES (D-69 a D-90), prioridade Alta
-- Curso: Formação em Redes de Computadores, Módulo 1 e 2 (Bruno Wanderley)
-- ============================================================

SET @d = '[D-69] Topologias de rede: anel, barramento, estrela e malha

🎯 O primeiro desenho que toda prova de Redes pede: como os cabos se conectam entre si.
📺 Módulo 1, Aulas 13-15: Redes em Anel, Redes em Barramento, Redes em Estrela e Malha
✅ Feito quando: você souber desenhar de memória as 4 topologias.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 69, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 69, NOW(), NOW());

SET @d = '[D-70] Hub x Switch: o antes e o depois da rede local

🎯 Um manda a mensagem pra todo mundo, o outro sabe exatamente pra quem mandar — entender essa diferença explica metade das questões de rede local.
📺 Módulo 1, Aulas 16-17: Funcionamento do Hub, Funcionamento do Switch
✅ Feito quando: você souber explicar por que o hub praticamente sumiu do mercado.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 70, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 70, NOW(), NOW());

SET @d = '[D-71] Modelo OSI, parte 1: as camadas de baixo

🎯 O item mais garantido de qualquer prova de Redes — comece decorando de baixo pra cima: Física, Enlace, Rede.
📺 Módulo 1, Aulas 18-20: Modelo OSI - Introdução, Analogias, Camada Física/Enlace/Rede
✅ Feito quando: você souber recitar as 3 primeiras camadas do OSI na ordem certa.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 71, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 71, NOW(), NOW());

SET @d = '[D-72] Modelo OSI, parte 2: as camadas de cima

🎯 Completa as 7 camadas — Transporte, Sessão, Apresentação e Aplicação, de onde vêm os protocolos que você já conhece do dia a dia (HTTP, FTP).
📺 Módulo 1, Aulas 21-23: Modelo OSI - Camada de Transporte e Sessão, Apresentação e Aplicação, Considerações Gerais
✅ Feito quando: você souber recitar as 7 camadas do OSI de trás pra frente também, sem trocar a ordem.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 72, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 72, NOW(), NOW());

SET @d = '[D-73] Ethernet e endereço MAC

🎯 Todo dispositivo de rede tem uma "identidade" gravada de fábrica — é isso que o MAC representa.
📺 Módulo 1, Aulas 24-25: Tecnologia Ethernet - Introdução, Endereço MAC
✅ Feito quando: você souber quantos bits/bytes tem um endereço MAC (dica: 48 bits, 6 bytes).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 73, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 73, NOW(), NOW());

SET @d = '[D-74] Endereço IP e classes de endereço

🎯 O RG da internet — e as classes A/B/C que ainda caem em prova mesmo já não sendo tão usadas na prática.
📺 Módulo 1, Aulas 29-30: Endereço IP - Visão Rápida, Endereço IP - Visão Rápida (Classes de Endereços)
✅ Feito quando: você souber identificar se um IP é classe A, B ou C só olhando o primeiro número.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 74, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 74, NOW(), NOW());

SET @d = '[D-75] CSMA/CD, domínios de colisão e broadcast

🎯 A regra de trânsito da rede antiga: como os dispositivos evitavam "falar" ao mesmo tempo no mesmo cabo.
📺 Módulo 1, Aulas 31-33: Tecnologia CSMA/CD, Domínios de Colisão e Broadcast, Modelo de Hierarquia de Rede Cisco
✅ Feito quando: você souber a diferença entre domínio de colisão e domínio de broadcast.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 75, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 75, NOW(), NOW());

SET @d = '[D-76] Cabeamento estruturado: os padrões que organizam o cabo

🎯 A parte "física de verdade" da prova — os padrões EIA/TIA que todo prédio comercial segue.
📺 Módulo 1, Aulas 44-48: Introdução ao Cabeamento Estruturado, Padrões EIA/TIA, Subsistemas de Cabeamento, Sistema ANSI/TIA 568 C1, Estrutura do Cabeamento Horizontal
✅ Feito quando: você souber nomear pelo menos 2 dos subsistemas de cabeamento estruturado.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 76, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 76, NOW(), NOW());

SET @d = '[D-77] Cabos UTP e o código de cores 568A/568B

🎯 Se tem uma coisa que cai literalmente em toda prova técnica de Redes é a ordem de cores da crimpagem.
📺 Módulo 1, Aulas 50-51: Cabos UTP, Código de Cores EIA/TIA 568A e 568B
✅ Feito quando: você souber recitar a ordem de cores do padrão 568B de cabeça (branco-laranja, laranja, branco-verde, azul, branco-azul, verde, branco-marrom, marrom).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 77, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 77, NOW(), NOW());

SET @d = '[D-78] Cabo direto x cabo cross-over

🎯 Mesma cor nas duas pontas, ou padrões diferentes? A resposta muda dependendo do que você está conectando.
📺 Módulo 1, Aula 52: Cabo Direto (Straight-Through) e Cabo Cross-Over
✅ Feito quando: você souber quando usar cada tipo (dica: hoje em dia, portas Gigabit fazem isso sozinhas, mas prova ainda cobra a teoria clássica).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 78, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 78, NOW(), NOW());

SET @d = '[D-79] Testes de certificação de cabo: atenuação, NEXT, ACR

🎯 Sigla em cima de sigla — não precisa decorar tudo, mas entender que "atenuação" é o sinal enfraquecendo já resolve boa parte das questões.
📺 Módulo 1, Aulas 55-58: Atenuação e Near-End Crosstalk (NEXT), PSNEXT/ELFEXT/PSELFEXT, ACR e PSACR, Perda de Retorno e Atraso de Propagação
✅ Feito quando: você souber explicar o que é atenuação com suas próprias palavras.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 79, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 79, NOW(), NOW());

SET @d = '[D-80] Gigabit Ethernet e 10Gbps em par trançado

🎯 Cat5e, Cat6, Cat6a — a categoria do cabo decide a velocidade máxima que ele aguenta.
📺 Módulo 1, Aulas 59-60: Gigabit Ethernet sobre Par Trançado - Introdução, Atingindo 10 Gbps em um Par Trançado
✅ Feito quando: você souber a distância máxima de 10Gbps num cabo Cat6 comum (dica: cerca de 55m, não os 100m completos).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 80, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 80, NOW(), NOW());

SET @d = '[D-81] Fibra óptica: luz em vez de eletricidade

🎯 A diferença de "mundo" entre cabo de cobre e fibra — e a dupla que mais aparece em prova: multimodo x monomodo.
📺 Módulo 1, Aulas 62-67: Introdução às Fibras Ópticas, A Natureza da Luz, O Espectro Óptico, Tipos de Fibras, Multimodo e Monomodo (visão geral e detalhes)
✅ Feito quando: você souber dizer qual das duas (multimodo ou monomodo) alcança distâncias maiores.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 81, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 81, NOW(), NOW());

SET @d = '[D-82] Atenuação e dispersão em fibra óptica

🎯 O mesmo conceito de "sinal enfraquecendo" (D-79), agora aplicado à luz dentro de uma fibra.
📺 Módulo 1, Aulas 68-70: Atenuação em Fibras (Espalhamento, Macrocurvatura e Microcurvatura), Dispersão em Fibras
✅ Feito quando: você souber o que uma curvatura muito fechada num cabo de fibra pode causar.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 82, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 82, NOW(), NOW());

SET @d = '[D-83] Wireless: fundamentos do Wi-Fi

🎯 802.11, 2.4GHz x 5GHz, e como o Wi-Fi se encaixa no Modelo OSI que você já estudou em D-71/D-72.
📺 Módulo 1, Aulas 87-92: Vantagens das Redes Wireless, Padrões IEEE 802.11, Inter-relacionamento com OSI, Topologias Infraestrutura e Ad-Hoc, Faixa de 2.4GHz, Faixa de 5GHz
✅ Feito quando: você souber uma vantagem prática da faixa de 5GHz sobre a de 2.4GHz.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 83, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 83, NOW(), NOW());

SET @d = '[D-84] Bridge: o avô do switch moderno

🎯 Entender a Bridge ajuda a entender por que o Switch (D-85) funciona do jeito que funciona hoje.
📺 Módulo 2, Aulas 6-8: Bridge - Visão Geral, Funcionamento, Tipos
✅ Feito quando: você souber em que o Switch "evoluiu" a ideia da Bridge.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 84, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 84, NOW(), NOW());

SET @d = '[D-85] Switch por dentro: tabela de encaminhamento e modos

🎯 Como o Switch "sabe" pra qual porta mandar cada quadro — a resposta é a tabela de endereços MAC que ele monta sozinho.
📺 Módulo 2, Aulas 9-12: Switch - Funcionamento Básico, Tabelas de Encaminhamento, Modos de Encaminhamento (Store and Forward e Cut-Through), Switches Multi Camada
✅ Feito quando: você souber a diferença entre os modos Store-and-Forward e Cut-Through.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 85, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 85, NOW(), NOW());

SET @d = '[D-86] VLAN: dividindo uma rede física em redes lógicas

🎯 Sem trocar um fio de lugar, você separa o setor Financeiro do setor de TI só na configuração — isso é VLAN.
📺 Módulo 2, Aulas 13-17: Introdução à VLANs, Visão Geral e Vantagens, Tipos de Associações, Links de Acesso e Trunk, IEEE 802.1Q
✅ Feito quando: você souber explicar a diferença entre uma porta de acesso e uma porta trunk.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 86, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 86, NOW(), NOW());

SET @d = '[D-87] Roteadores: a ponte entre redes diferentes

🎯 Enquanto o Switch trabalha dentro de uma rede, o roteador é quem decide o caminho entre redes diferentes (ex: sua rede e a internet).
📺 Módulo 2, Aulas 38-40: Visão Geral dos Roteadores, Estrutura de um Roteador de Grande Porte, Parâmetros de Qualidade de Conexão
✅ Feito quando: você souber, numa frase, a diferença entre o trabalho de um switch e o de um roteador.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 87, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 87, NOW(), NOW());

SET @d = '[D-88] TCP/IP: a suíte que roda a internet

🎯 A camada de Aplicação do TCP/IP é onde moram os protocolos que você usa todo dia sem perceber: e-mail, DHCP, FTP, HTTP.
📺 Módulo 2, Aulas 46-53: Introdução à Suíte TCP/IP, Camadas TCP/IP x OSI, Camada de Aplicação, Correio Eletrônico e Protocolos, Protocolo DHCP, FTP, HTTP
✅ Feito quando: você souber pra que serve o DHCP numa frase simples.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 88, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 88, NOW(), NOW());

SET @d = '[D-89] Camada de transporte: TCP e o aperto de mão em três vias

🎯 O "three-way handshake" (SYN, SYN-ACK, ACK) é um dos itens mais clássicos de prova de Redes — decore os três passos.
📺 Módulo 2, Aulas 54-58: Camada de Transporte, Funcionamento dos Sockets, Protocolo TCP - Three Way Handshake, Encerramento da Conexão, Cabeçalho TCP
✅ Feito quando: você souber recitar os 3 passos do three-way handshake na ordem certa.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 89, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 89, NOW(), NOW());

SET @d = '[D-90] UDP, IP, ARP e ICMP: fechando o núcleo de TCP/IP

🎯 Os quatro protocolos que faltavam pra fechar o quadro completo — inclusive ARP e ICMP, que aparecem direto em questão de troubleshooting.
📺 Módulo 2, Aulas 59-63: Protocolo UDP, Camada de Rede - Protocolo IP, Protocolo ARP (visão geral e detalhes), Protocolo ICMP
✅ Feito quando: você souber pra que serve o ping por baixo dos panos (dica: ele usa ICMP).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 90, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Redes', 'Tarefa', 90, NOW(), NOW());

-- ============================================================
-- BLOCO 6 — LINUX FUNDAMENTOS (D-91 a D-109), prioridade Alta
-- Curso: Formação Linux Completa (mateusmuller)
-- ============================================================

SET @d = '[D-91] Distribuições Linux: um kernel, várias caras

🎯 CentOS, Ubuntu, Debian, Rocky — todas usam o mesmo kernel Linux por baixo, mudando o "empacotamento" em volta.
📺 Aula 2: O que são distribuições? Quais são as principais do mercado?
✅ Feito quando: você souber nomear 3 distribuições Linux diferentes.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 91, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 91, NOW(), NOW());

SET @d = '[D-92] FHS: para que serve cada pasta do Linux

🎯 /etc, /home, /var, /bin — cada uma tem uma função fixa, e prova adora perguntar "onde ficam os arquivos de configuração?"
📺 Aulas 11-12: Introdução ao File System Hierarchy, FHS na prática
✅ Feito quando: você souber pra que serve /etc, /home e /var, sem consultar nada.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 92, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 92, NOW(), NOW());

SET @d = '[D-93] Boot do Linux e systemd

🎯 O que acontece entre apertar o botão de ligar e a tela de login aparecer — e o systemd é quem toma conta disso hoje em dia.
📺 Aulas 13, 16-18: Processo de Boot do Linux, systemd vs SysV, Prática, systemctl
✅ Feito quando: você souber pra que serve o comando systemctl status de um serviço.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 93, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 93, NOW(), NOW());

SET @d = '[D-94] Partições: dividindo o disco em pedaços

🎯 Antes de instalar qualquer sistema, alguém decidiu como o disco seria repartido — e isso também é testável em prova.
📺 Aulas 20-23: Criação de partições (teoria e prática), Formatar partições, Montar automaticamente ao longo do boot
✅ Feito quando: você souber pra que serve o arquivo fstab.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 94, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 94, NOW(), NOW());

SET @d = '[D-95] LVM: partições que crescem depois de criadas

🎯 O problema clássico de "a partição ficou pequena" tem solução — e ela se chama LVM.
📺 Aulas 26-27: Criar partições com LVM (teoria e prática)
✅ Feito quando: você souber explicar por que o LVM é mais flexível que uma partição comum.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 95, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 95, NOW(), NOW());

SET @d = '[D-96] Gerenciando pacotes: RPM e Yum

🎯 Como instalar, atualizar e remover programas no Linux — e por que existe uma ferramenta pra empacotar (RPM) e outra pra resolver dependências (Yum).
📺 Aulas 29-31: Introdução ao gerenciamento de pacotes, RPM, Yum
✅ Feito quando: você souber a diferença entre instalar um pacote com RPM direto e instalar com Yum.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 96, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 96, NOW(), NOW());

SET @d = '[D-97] Arquivos de inicialização do Bash e o uso de aspas

🎯 Detalhe pequeno que confunde muita gente: aspa simples e aspa dupla se comportam diferente no shell.
📺 Aulas 33, 35: Arquivos de inicialização do Bash, Aspas simples e aspas duplas
✅ Feito quando: você souber a diferença entre aspa simples (texto literal) e aspa dupla (permite variável) no shell.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 97, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 97, NOW(), NOW());

SET @d = '[D-98] Comandos de arquivo e diretório: cp, touch, mv, mkdir

🎯 Os quatro comandos que você vai digitar centenas de vezes se trabalhar com Linux — e que caem soltos em questão de "o que esse comando faz".
📺 Aulas 37-38: Gerenciar arquivos e diretórios (cp & touch), (mv & mkdir)
✅ Feito quando: você souber a diferença entre cp e mv sem hesitar.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 98, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 98, NOW(), NOW());

SET @d = '[D-99] Processamento de texto no terminal

🎯 grep, cut, sort e afins — a arte de filtrar exatamente a linha que você precisa dentro de um arquivo gigante.
📺 Aulas 39-43: Processamento de texto (partes 1-5)
✅ Feito quando: você souber usar grep pra buscar uma palavra dentro de um arquivo.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 99, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 99, NOW(), NOW());

SET @d = '[D-100] Expressões regulares e file globbing

🎯 * ? [ ] — os curingas que deixam um comando pegar "todos os arquivos .txt" de uma vez, em vez de digitar nome por nome.
📺 Aulas 45-47: Expressões Regulares e file globbing (partes 1-3)
✅ Feito quando: você souber o que o padrão *.txt faz num comando ls.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 100, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 100, NOW(), NOW());

SET @d = '[D-101] Redirecionamento: mandando a saída de um comando pra outro lugar

🎯 >, >> e < são a base de praticamente todo script Linux — e também aparecem soltos em questão teórica.
📺 Aula 49: Redirecionamento de comandos
✅ Feito quando: você souber a diferença entre > (sobrescreve) e >> (adiciona ao final).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 101, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 101, NOW(), NOW());

SET @d = '[D-102] Compactação: tar, gzip, bzip2, xz

🎯 Reduzir tamanho e agrupar vários arquivos num só — duas coisas que às vezes um comando só faz (como o tar) e às vezes precisa de dois.
📺 Aulas 52-53: Compactação e compressão, Comandos tar, gzip, bzip2, xz
✅ Feito quando: você souber a diferença entre compactar (juntar arquivos) e comprimir (reduzir tamanho).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 102, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 102, NOW(), NOW());

SET @d = '[D-103] Gerenciamento de processos

🎯 Todo programa rodando no Linux é um "processo" com um número (PID) — e saber consultar/finalizar isso é item clássico de prova prática.
📺 Aulas 55-59: Teoria sobre processos, Obter informações de processos (partes 1-3), Finalizar processos
✅ Feito quando: você souber pra que serve o comando kill.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 103, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 103, NOW(), NOW());

SET @d = '[D-104] Permissões normais: dono, grupo e outros

🎯 A base de rwx que toda prova de Linux cobra — e que você já viu de relance no chmod numérico do curso de Hardware/SO.
📺 Aulas 67-69: Gerenciar permissões normais (partes 1-3)
✅ Feito quando: você souber ler uma permissão do tipo rwxr-xr-- e explicar o que cada trinca significa.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 104, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 104, NOW(), NOW());

SET @d = '[D-105] Permissões especiais e umask

🎯 SUID, SGID, sticky bit e a máscara que decide a permissão padrão de todo arquivo novo — nível avançado, mas item que separa quem só decorou de quem entendeu.
📺 Aulas 70-73: Gerenciar permissões especiais (partes 1-2), Umask (partes 1-2)
✅ Feito quando: você souber dizer pra que serve o sticky bit (dica: pasta /tmp usa ele).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 105, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 105, NOW(), NOW());

SET @d = '[D-106] Link físico e link simbólico

🎯 Dois jeitos diferentes de "apontar" pra um mesmo arquivo — e só um deles quebra se o arquivo original for apagado.
📺 Aulas 75-76: Link físico e link simbólico (hardlink e softlink), partes 1-2
✅ Feito quando: você souber qual dos dois (hardlink ou softlink) para de funcionar se o arquivo original for deletado.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 106, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 106, NOW(), NOW());

SET @d = '[D-107] Encontrando arquivos: find e afins

🎯 Quando você não lembra onde salvou algo, esse é o comando que vasculha o sistema inteiro por você.
📺 Aulas 78-80: Utilitários para encontrar arquivos e diretórios (partes 1-3)
✅ Feito quando: você souber montar um find simples buscando por nome de arquivo.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 107, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 107, NOW(), NOW());

SET @d = '[D-108] Usuários e grupos: quem pode fazer o quê

🎯 useradd, passwd, sudo — a gestão de quem tem conta no sistema e com que poder.
📺 Aulas 90-93: Gerenciar usuários (partes 1-2), Gerenciar usuários (sudo), Gerenciar grupos e senhas
✅ Feito quando: você souber a diferença entre rodar um comando como root e rodar com sudo.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 108, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 108, NOW(), NOW());

SET @d = '[D-109] RAID: redundância e desempenho de disco

🎯 Fecha o bloco de Linux com um tema que também é cobrado em Hardware — os níveis de RAID mais comuns (0, 1, 5, 10).
📺 Aulas 111-112: Introdução ao RAID, Níveis de RAID
✅ Feito quando: você souber qual nível de RAID tolera falha de disco com menos desperdício de espaço (dica: RAID 5).';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 109, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Alta', 'Linux/SO', 'Tarefa', 109, NOW(), NOW());

-- ============================================================
-- BLOCO 7 — SHELL SCRIPT (D-110 a D-122), prioridade Média
-- Curso: Programação Shell Script (Ricardo Prudenciato)
-- ============================================================

SET @d = '[D-110] Revisão relâmpago dos principais comandos Linux

🎯 Um resumo rápido dos comandos que você já viu espalhados no Bloco de Linux, agora juntos num só lugar antes de partir pra automação.
📺 Aulas 6-10: Principais Comandos Linux (partes 1-5)
✅ Feito quando: você sentir que os comandos básicos já saem "no automático", sem pensar.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 110, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 110, NOW(), NOW());

SET @d = '[D-111] Redirecionamento e variáveis, agora dentro de um script

🎯 O mesmo > e >> do D-101, e a mesma ideia de variável do D-04 — só que agora dentro de um arquivo .sh de verdade.
📺 Aulas 12-13: Redirecionamentos de Entrada e Saída, Variáveis no Shell
✅ Feito quando: você souber criar uma variável no shell e imprimir o valor dela com echo.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 111, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 111, NOW(), NOW());

SET @d = '[D-112] Aspas, globbing e expressões regulares no shell

🎯 Junta três peças pequenas que se completam: como o shell trata texto entre aspas, curinga de nome de arquivo, e padrão de busca.
📺 Aula 14, 16-17: O Uso das Aspas no Shell, File Globbing, Básico de Expressões Regulares
✅ Feito quando: você souber prever o que acontece com uma variável dentro de aspas simples x aspas duplas.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 112, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 112, NOW(), NOW());

SET @d = '[D-113] Seu primeiro script: nome, permissão e execução

🎯 O primeiro erro de quem começa: escrever o script certinho e não conseguir rodar porque esqueceu de dar permissão de execução.
📺 Aula 18: O Primeiro Script - Nomes, Permissões e Execução
✅ Feito quando: você tiver criado e executado um script .sh simples do zero (nem que seja só um "echo ola").';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 113, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 113, NOW(), NOW());

SET @d = '[D-114] PATH e boas práticas de comentário

🎯 Por que às vezes você precisa digitar ./script.sh em vez de só script.sh — a resposta está no PATH.
📺 Aulas 19-20: Definição do PATH, Comentários - Boas Práticas
✅ Feito quando: você souber explicar o que é a variável PATH em uma frase.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 114, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 114, NOW(), NOW());

SET @d = '[D-115] Variáveis em script e exit codes

🎯 Todo script termina com um "código de saída" — 0 significa sucesso, qualquer outro número significa que algo deu errado.
📺 Aulas 21-22: Trabalhando com Variáveis no Shell Script, Exit Codes
✅ Feito quando: você souber o que significa um script terminar com exit code 0.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 115, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 115, NOW(), NOW());

SET @d = '[D-116] Recebendo entrada do usuário: read e parâmetros

🎯 Dois jeitos de um script "conversar" com quem está rodando ele: perguntar durante a execução (read) ou já receber pronto ($1, $2...).
📺 Aulas 23-24: Recebendo Entradas do Usuário Através do Comando read, Através de Parâmetros
✅ Feito quando: você souber a diferença entre usar read e usar $1 num script.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 116, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 116, NOW(), NOW());

SET @d = '[D-117] If em Shell Script

🎯 O mesmo SE/SENÃO de sempre (D-09, D-17), só que agora com a sintaxe cheia de colchetes do Bash.
📺 Aulas 28-29: Uso da Instrução If - Conceitos e Sintaxe, Demonstração Prática
✅ Feito quando: você souber escrever um if simples testando se um número é maior que outro em Bash.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 117, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 117, NOW(), NOW());

SET @d = '[D-118] Case em Shell Script

🎯 O ESCOLHA (D-09) e o switch-case (D-18) ganham aqui sua terceira roupagem, agora em Bash.
📺 Aula 30: Uso da Instrução Case - Conceitos, Sintaxe e Prática
✅ Feito quando: você souber quando um case é mais legível que uma sequência de if-elif.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 118, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 118, NOW(), NOW());

SET @d = '[D-119] For em Shell Script

🎯 O loop mais usado em automação Linux — percorrer uma lista de arquivos, de números, ou de qualquer coisa.
📺 Aulas 35-37: Uso da Instrução For - Conceitos e Sintaxe, Demonstração Prática, For + IFS
✅ Feito quando: você souber escrever um for que percorre uma lista simples de 3 itens.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 119, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 119, NOW(), NOW());

SET @d = '[D-120] While e Until em Shell Script

🎯 O while você já conhece (D-20); o until é o "inverso" dele — repete até a condição virar verdadeira, não enquanto for.
📺 Aulas 38-39: Uso da Instrução While - Conceitos e Prática, Uso da Instrução Until - Conceitos e Prática
✅ Feito quando: você souber explicar a diferença de lógica entre while e until.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 120, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 120, NOW(), NOW());

SET @d = '[D-121] continue e break: controlando o loop por dentro

🎯 Dois comandos pequenos que mudam o comportamento de qualquer loop: pular a volta atual (continue) ou sair de vez (break).
📺 Aula 40: Uso dos comandos continue e break
✅ Feito quando: você souber a diferença de efeito entre continue e break dentro de um loop.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 121, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 121, NOW(), NOW());

SET @d = '[D-122] Funções em Shell Script

🎯 Fecha o bloco de Shell Script com a mesma ideia de "reaproveitar código" que você já viu em Java (D-24) e PHP (D-42), agora em Bash.
📺 Aulas 46-47: Uso de Funções no Shell Script - Conceitos e Sintaxe, Demonstração Prática
✅ Feito quando: você souber escrever uma função simples em Bash que recebe um parâmetro.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 122, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Linux/SO', 'Tarefa', 122, NOW(), NOW());

-- ============================================================
-- BLOCO 8 — MATEMÁTICA / RACIOCÍNIO LÓGICO (D-123 a D-128), prioridade Média
-- Curso: Matemática para quem detesta Matemática (Denis Wiener)
-- ============================================================

SET @d = '[D-123] Reconciliação com os números: frações e operações básicas

🎯 Todo concurso tem uma prova de raciocínio lógico-matemático, e ela sempre começa cobrando o básico que a gente jura que já sabe — frações, MMC, MDC.
📺 Módulo de fundamentos: Frações, Operações com Frações, MMC e MDC
✅ Feito quando: você resolver de cabeça uma soma de frações com denominadores diferentes.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Raciocínio Lógico', 'Tarefa', 123, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Raciocínio Lógico', 'Tarefa', 123, NOW(), NOW());

SET @d = '[D-124] Porcentagem e regra de três: as duas ferramentas mais cobradas

🎯 Se tivesse que escolher só duas armas pra prova de matemática de concurso, seriam essas — aparecem disfarçadas em quase toda questão de "problema".
📺 Módulo de aritmética aplicada: Porcentagem, Regra de Três Simples e Composta
✅ Feito quando: você resolver um problema de porcentagem e um de regra de três sem consultar fórmula.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Raciocínio Lógico', 'Tarefa', 124, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Raciocínio Lógico', 'Tarefa', 124, NOW(), NOW());

SET @d = '[D-125] Razão, proporção e grandezas: montando a base pra questões de prova

🎯 Regra de três (D-124) é a ferramenta; razão e proporção são a lógica por trás dela — entender o "porquê" evita decoreba.
📺 Módulo de proporcionalidade: Razão e Proporção, Grandezas Direta e Inversamente Proporcionais
✅ Feito quando: você souber dizer, sem calcular, se duas grandezas de um problema são direta ou inversamente proporcionais.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Raciocínio Lógico', 'Tarefa', 125, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Raciocínio Lógico', 'Tarefa', 125, NOW(), NOW());

SET @d = '[D-126] Equações do 1º e 2º grau

🎯 A base algébrica que sustenta boa parte das questões "armadas" em forma de problema de concurso.
📺 Módulo de álgebra: Equação do 1º Grau, Equação do 2º Grau (Bhaskara)
✅ Feito quando: você resolver uma equação do 2º grau usando Bhaskara sem olhar a fórmula no meio do processo.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Raciocínio Lógico', 'Tarefa', 126, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Raciocínio Lógico', 'Tarefa', 126, NOW(), NOW());

SET @d = '[D-127] Análise combinatória e probabilidade: o terror de quem "detesta matemática"

🎯 É o tópico que mais assusta à primeira vista e, ironicamente, o que mais recompensa quem treina uns poucos padrões de questão.
📺 Módulo de combinatória: Princípio Fundamental da Contagem, Permutação, Combinação, Probabilidade Básica
✅ Feito quando: você souber identificar, olhando o enunciado, se é caso de permutação ou de combinação.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Raciocínio Lógico', 'Tarefa', 127, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Raciocínio Lógico', 'Tarefa', 127, NOW(), NOW());

SET @d = '[D-128] Lógica proposicional aplicada: conectivos e tabela-verdade

🎯 Fecha o bloco de matemática ligando direto com o que você já viu de "E / OU / NÃO" em Algoritmos (D-01) e Java (D-14) — só que agora no formato cobrado em prova.
📺 Módulo de raciocínio lógico: Proposições e Conectivos Lógicos, Tabela-Verdade
✅ Feito quando: você montar a tabela-verdade de uma proposição composta simples (ex: "p E q") sem erro.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Raciocínio Lógico', 'Tarefa', 128, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Raciocínio Lógico', 'Tarefa', 128, NOW(), NOW());

-- ============================================================
-- BLOCO 9 — PENDÊNCIAS / LACUNAS (D-129 a D-132), não são aula-a-aula
-- ============================================================

SET @d = '[D-129] Avaliar os outros cursos de PHP/POO da lista

🎯 Existem outros cursos de PHP orientado a objetos na sua lista do Udemy que ainda não foram abertos aula-a-aula — vale conferir se algum complementa o Bloco 3 (D-41 a D-47) com algo que o curso do Cesar Nicolau não cobriu.
📺 Ação: abrir os cursos de PHP pendentes na sua biblioteca Udemy e mandar a lista de aulas, do mesmo jeito que foi feito com os outros 8 cursos.
✅ Feito quando: você tiver decidido "aproveita" ou "ignora" pra cada curso de PHP pendente, com justificativa.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Baixa', 'Pendências', 'Tarefa', 129, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Baixa', 'Pendências', 'Tarefa', 129, NOW(), NOW());

SET @d = '[D-130] Lacuna: Segurança da Informação

🎯 Segurança da Informação cai em praticamente toda prova federal de TI (conceitos de confidencialidade/integridade/disponibilidade, criptografia básica, malware, backup) e, pela sua biblioteca atual, não há curso dedicado ao tema — vale considerar buscar um.
📺 Ação: pesquisar um curso (Udemy ou outra fonte) de Segurança da Informação com foco em concursos públicos e trazer a ementa pra curadoria.
✅ Feito quando: você tiver decidido se vale comprar/buscar um curso novo ou estudar por PDF/resumo direto.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Pendências', 'Tarefa', 130, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Pendências', 'Tarefa', 130, NOW(), NOW());

SET @d = '[D-131] Lacuna: Raciocínio Lógico puro (lógica proposicional avançada)

🎯 O D-128 dá só a base de conectivos e tabela-verdade — mas concursos federais costumam cobrar também equivalências lógicas, negação de proposições e argumentos/silogismos, que não estão no curso de Matemática atual.
📺 Ação: pesquisar um curso ou material específico de Raciocínio Lógico (equivalências, negações, silogismos, diagramas lógicos) e trazer pra curadoria.
✅ Feito quando: você tiver decidido a fonte de estudo pra esse complemento e ela estiver anotada aqui.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Média', 'Pendências', 'Tarefa', 131, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Média', 'Pendências', 'Tarefa', 131, NOW(), NOW());

SET @d = '[D-132] Decisão pendente: Excel/Office entra no plano?

🎯 Informática básica (Word/Excel/Office) aparece em muitos editais de nível médio/técnico, mas ainda não foi decidido se o edital-alvo de vocês vai cobrar isso — evita estudar algo que talvez nem caia.
📺 Ação: verificar, no edital-alvo (ou no último edital do mesmo cargo), se Informática Básica/Office entra no conteúdo programático.
✅ Feito quando: você tiver a resposta sim/não anotada e, se for sim, um curso de Excel escolhido pra entrar num próximo ciclo do plano.';
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_f, @status_fila, @d, 'Baixa', 'Pendências', 'Tarefa', 132, NOW(), NOW());
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, type, sort_order, created_at, updated_at) VALUES (@board_id, @sprint_c, @status_fila, @d, 'Baixa', 'Pendências', 'Tarefa', 132, NOW(), NOW());

-- ============================================================
-- TAGS EM LOTE — a tag reflete o epic de cada demanda (1 query por
-- bloco/epic, em vez de uma por demanda). D-129 a D-132 (epic
-- "Pendências") usam a tag 'Lacuna', que já existe no board.
-- ============================================================
INSERT INTO task_tag (task_id, tag_id)
SELECT t.id, tg.id FROM tasks t
JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Lógica/Algoritmos'
WHERE t.board_id = @board_id AND t.epic = 'Lógica/Algoritmos';

INSERT INTO task_tag (task_id, tag_id)
SELECT t.id, tg.id FROM tasks t
JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'POO'
WHERE t.board_id = @board_id AND t.epic = 'POO';

INSERT INTO task_tag (task_id, tag_id)
SELECT t.id, tg.id FROM tasks t
JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Banco de Dados'
WHERE t.board_id = @board_id AND t.epic = 'Banco de Dados';

INSERT INTO task_tag (task_id, tag_id)
SELECT t.id, tg.id FROM tasks t
JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Redes'
WHERE t.board_id = @board_id AND t.epic = 'Redes';

INSERT INTO task_tag (task_id, tag_id)
SELECT t.id, tg.id FROM tasks t
JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Linux/SO'
WHERE t.board_id = @board_id AND t.epic = 'Linux/SO';

INSERT INTO task_tag (task_id, tag_id)
SELECT t.id, tg.id FROM tasks t
JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Raciocínio Lógico'
WHERE t.board_id = @board_id AND t.epic = 'Raciocínio Lógico';

INSERT INTO task_tag (task_id, tag_id)
SELECT t.id, tg.id FROM tasks t
JOIN tags tg ON tg.board_id = t.board_id AND tg.name = 'Lacuna'
WHERE t.board_id = @board_id AND t.epic = 'Pendências';

-- ============================================================
-- RESPONSÁVEIS EM LOTE — todas as tarefas da Sprint Fernando
-- ficam com Fernando (user_id 1); todas da Sprint Claudia ficam
-- com Claudia (user_id 2). Um único INSERT por pessoa.
-- ============================================================
INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 1, NOW(), NOW() FROM tasks t WHERE t.board_id = @board_id AND t.sprint_id = @sprint_f;

INSERT INTO task_user (task_id, user_id, created_at, updated_at)
SELECT t.id, 2, NOW(), NOW() FROM tasks t WHERE t.board_id = @board_id AND t.sprint_id = @sprint_c;

-- ============================================================
-- CONFERÊNCIA FINAL
-- ============================================================
SELECT id, name FROM boards WHERE name = 'Concurso Federal - Informática';

SELECT s.id, s.name, s.start_date, s.end_date, COUNT(t.id) AS qtd_tarefas
FROM sprints s
LEFT JOIN tasks t ON t.sprint_id = s.id
WHERE s.board_id = @board_id
GROUP BY s.id, s.name, s.start_date, s.end_date
ORDER BY s.id;

SELECT COUNT(*) AS total_tasks FROM tasks WHERE board_id = @board_id;

SELECT epic, COUNT(*) AS qtd FROM tasks WHERE board_id = @board_id GROUP BY epic ORDER BY MIN(sort_order);

SELECT priority, COUNT(*) AS qtd FROM tasks WHERE board_id = @board_id GROUP BY priority;

SELECT tg.name AS tag, COUNT(*) AS qtd
FROM task_tag tt
JOIN tags tg ON tg.id = tt.tag_id
JOIN tasks t ON t.id = tt.task_id
WHERE t.board_id = @board_id
GROUP BY tg.name;

SELECT u.name AS responsavel, COUNT(*) AS qtd
FROM task_user tu
JOIN users u ON u.id = tu.user_id
JOIN tasks t ON t.id = tu.task_id
WHERE t.board_id = @board_id
GROUP BY u.name;
