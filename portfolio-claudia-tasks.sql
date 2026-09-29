-- ============================================================
-- Portfolio Claudia - board + sprints + cards
-- Gerado por portfolio-claudia-gerar-sql.py a partir de
-- portfolio-claudia-tasks.json. NAO edite este arquivo na mao.
--
-- Rodar no banco do Avante (gestao_tarefas) de PRODUCAO.
-- ATENCAO: nao e idempotente. Rodar duas vezes duplica as linhas.
-- Confira antes:  SELECT id, name FROM boards ORDER BY id DESC LIMIT 5;
-- ============================================================

START TRANSACTION;

-- Passo 1: criar o board
INSERT INTO boards (name, created_at, updated_at)
VALUES ('Portfólio Claudia', NOW(), NOW());
SET @board := LAST_INSERT_ID();

-- Passo 2: status, prioridades e tipos padrao (iguais aos que o
-- BoardController cria quando o board nasce pela interface)
INSERT INTO statuses (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Em Fila', '#6B6B70', 0, NOW(), NOW());
INSERT INTO statuses (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Em Andamento', '#0284C7', 1, NOW(), NOW());
INSERT INTO statuses (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Em Revisao', '#D97706', 2, NOW(), NOW());
INSERT INTO statuses (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Concluida', '#059669', 3, NOW(), NOW());

INSERT INTO priorities (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Baixa', '#059669', 0, NOW(), NOW());
INSERT INTO priorities (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Media', '#0284C7', 1, NOW(), NOW());
INSERT INTO priorities (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Alta', '#EA580C', 2, NOW(), NOW());
INSERT INTO priorities (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Urgente', '#DC2626', 3, NOW(), NOW());

INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Tarefa', '#6B6B70', 0, NOW(), NOW());
INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Historia', '#7C3AED', 1, NOW(), NOW());
INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Bug', '#DC2626', 2, NOW(), NOW());
INSERT INTO task_types (board_id, area, name, color, `order`, created_at, updated_at)
VALUES (@board, 'programming', 'Melhoria', '#0284C7', 3, NOW(), NOW());

SET @fila := (SELECT id FROM statuses WHERE board_id = @board AND name = 'Em Fila' LIMIT 1);

-- Passo 3: as 4 sprints
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Sprint 1 — Fundação & Conteúdo', '2026-09-30', '2026-10-11', 1, NOW(), NOW());
SET @sprint1 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Sprint 2 — Site público', '2026-10-12', '2026-11-01', 2, NOW(), NOW());
SET @sprint2 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Sprint 3 — API & Painel administrativo', '2026-11-02', '2026-11-22', 3, NOW(), NOW());
SET @sprint3 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Sprint 4 — Qualidade, SEO & Publicação', '2026-11-23', '2026-12-06', 4, NOW(), NOW());
SET @sprint4 := LAST_INSERT_ID();

-- Passo 4: as 24 cards, todas em 'Em Fila'
-- PC-01
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint1,
  @fila,
  '[PC-01] Montar o monorepo: Angular 20 + Laravel 13',
  'Como Claudia, preciso criar a estrutura base do projeto no repositório https://github.com/devMorais/portfolio-claudia, com frontend Angular e backend Laravel separados em pastas, para ter onde construir tudo o que vem depois.

O repositório já existe no GitHub e está vazio. O projeto local fica em C:\\laragon\\www\\portfolio-claudia.

Critérios de aceite:
- Pasta frontend/ com um projeto Angular 20 novo (routing habilitado, SCSS como pré-processador, standalone components)
- Pasta backend/ com um projeto Laravel 13 novo (PHP 8.3+)
- README.md na raiz explicando o que é o projeto, a stack e como rodar frontend e backend
- .gitignore cobrindo node_modules/, vendor/, .env, dist/, storage de logs
- .env.example no backend com as variáveis necessárias (sem senha real dentro)
- `npm start` sobe o Angular em localhost:4200 e `php artisan serve` sobe a API, os dois sem erro
- Primeiro commit e push na branch main: ''chore: estrutura inicial do monorepo''
- NENHUMA senha, token ou credencial commitada em nenhum arquivo',
  'Alta',
  'Fundação',
  'Tarefa',
  'Passo a passo (pode pedir cada bloco para a IA, um de cada vez — não peça tudo de uma vez):

1. Abra o terminal em C:\\laragon\\www e rode: git clone https://github.com/devMorais/portfolio-claudia.git
2. Entre na pasta e crie o Angular: npx @angular/cli@20 new frontend --style=scss --routing --skip-git
3. Crie o Laravel: composer create-project laravel/laravel backend
4. Peça para a IA: ''monte um .gitignore para um monorepo com Angular em frontend/ e Laravel em backend/''
5. Peça para a IA escrever o README.md a partir da descrição desta card
6. Teste os dois rodando ANTES de commitar
7. git add . && git commit && git push

Dica de prompt: sempre diga para a IA a versão exata (Angular 20, Laravel 13, PHP 8.3) — sem isso ela responde com código de versão antiga e você perde tempo.

Regra do projeto: nunca commitar arquivo .env. Se aparecer no `git status`, o .gitignore está errado — corrija antes de commitar.',
  1,
  NOW(), NOW()
);

-- PC-02
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint1,
  @fila,
  '[PC-02] Definir a identidade visual e centralizar os tokens',
  'Como Claudia, preciso definir a identidade visual do meu portfólio (paleta, tipografia, espaçamentos) e deixar tudo como variável CSS num arquivo único, para que o site inteiro fique coerente e eu consiga mudar uma cor num lugar só.

O portfólio precisa ser BONITO — é a primeira impressão de um recrutador. Mas bonito aqui significa limpo, com respiro, hierarquia clara e contraste legível, não cheio de efeito.

Critérios de aceite:
- Paleta definida com no máximo 5 cores: 1 fundo, 1 texto, 1 texto secundário, 1 cor de destaque, 1 cor de erro
- Escolhidas 2 fontes (1 para títulos, 1 para texto corrido), carregadas via Google Fonts ou arquivos locais
- TODOS os valores (cores, fontes, raios de borda, espaçamentos, sombras) declarados como variáveis CSS em frontend/src/styles.scss
- Nenhum componente do projeto usa cor escrita na mão (tipo #333) — sempre var(--nome)
- Escala de espaçamento definida (ex.: 4px, 8px, 16px, 24px, 48px, 96px) e usada nas seções
- Contraste de texto sobre fundo testado e aprovado (mínimo AA — dá para checar em webaim.org/resources/contrastchecker)
- Decisão registrada nesta card: colar aqui a paleta final em hex e o nome das fontes
- Validado com o Fernando antes de sair aplicando em tudo',
  'Alta',
  'Fundação',
  'Tarefa',
  'Como decidir sem travar:

1. Escolha UM caminho e vá: (a) claro e minimalista — fundo branco, texto quase preto, um destaque só; ou (b) escuro e tech — fundo grafite, texto claro, um destaque vibrante.
2. Para fonte, combinações que funcionam sempre: Space Grotesk + Inter, Sora + Inter, Poppins + Inter.
3. Peça para a IA: ''gere um styles.scss com tokens CSS em :root para esta paleta e estas fontes, incluindo escala de espaçamento e raios de borda''
4. Monte uma página de teste boba com um título, um parágrafo e um botão usando só os tokens. Se ficar bonito ali, vai ficar bonito no site.

Armadilha comum: escolher 3 cores de destaque. Uma só. O visual profissional vem do espaçamento e da tipografia, não da quantidade de cor.

Não copie a paleta do devmorais.com.br — aquele é preto e branco e é a marca do Fernando. O seu tem que ser seu.',
  2,
  NOW(), NOW()
);

-- PC-03
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint1,
  @fila,
  '[PC-03] Levantar todo o conteúdo real do portfólio (texto, fotos, CV)',
  'Como Claudia, preciso escrever e reunir TODO o conteúdo real do portfólio antes de programar as telas, para não perder tempo construindo layout com texto de mentira e ter que refazer depois.

Esta é a card mais importante do projeto. O site é bonito por causa do design, mas ele consegue emprego por causa do texto.

Critérios de aceite — entregar um arquivo CONTEUDO.md na raiz do repositório com:
- Nome completo e como quero ser chamada profissionalmente
- Título profissional de uma linha (ex.: ''Desenvolvedora web em transição da radiologia para a tecnologia'')
- Frase de abertura do hero: 2 a 3 linhas, escritas na primeira pessoa
- A história da migração de carreira, em 3 partes: (1) o que eu fazia na radiologia e por quanto tempo, (2) o que me fez decidir migrar e quando, (3) onde estou hoje e onde quero chegar
- Lista de habilidades técnicas com nível honesto de cada uma (nada de ''Angular 90%'' se não for verdade)
- Lista de habilidades da radiologia que ajudam em tecnologia, com uma frase explicando cada uma (ex.: seguir protocolo rígido, atenção a detalhe, trabalhar sob pressão, lidar com gente)
- Timeline de carreira com ano, título e descrição de cada etapa (radiologia, cursos, primeiros projetos, trabalho atual)
- Formação: cursos, certificados, instituição e ano
- Lista dos projetos que vou mostrar: nome, o que faz, tecnologias, meu papel nele, link do repositório e link do site se tiver
- Foto profissional em boa qualidade (mínimo 1000px de largura, boa luz, fundo limpo)
- Currículo em PDF atualizado, salvo em frontend/public/
- Links: LinkedIn, GitHub (marceline-mrq), Instagram e WhatsApp
- Revisado pelo Fernando antes de virar código',
  'Urgente',
  'Conteúdo',
  'Tarefa',
  'Como escrever sem travar:

1. Escreva primeiro em português corrido, como se estivesse contando para uma amiga. Depois enxugue. Não comece tentando escrever bonito.
2. Sobre a migração: NÃO esconda a radiologia e NÃO peça desculpa por ela. É o seu diferencial. Recrutador vê migração de área como sinal de coragem e capacidade de aprender — desde que a história esteja contada com clareza e sem vitimismo.
3. Use a IA para REVISAR, não para escrever do zero. Cole o seu texto e peça: ''revise a clareza e o tom deste texto mantendo a minha voz, sem deixar genérico e sem inventar fatos''. Texto 100% de IA é reconhecível na hora e queima a impressão.
4. Não invente nível de habilidade. Se a entrevista técnica cobrar o que está escrito no site, você quer ter sustentado.
5. Projetos: pode usar o que você fez nos PRs do Dolen (reels, carrosséis, correções de código) — combine antes com o Fernando o que pode ser mostrado publicamente.
6. Se não tiver projeto próprio suficiente, esta card gera uma consequência: fale com o Fernando sobre construir 1 ou 2 projetinhos só seus antes de publicar o site.

Entregue esta card ANTES de começar a Sprint 2. Layout com texto de mentira sempre vira retrabalho.',
  3,
  NOW(), NOW()
);

-- PC-04
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint1,
  @fila,
  '[PC-04] Modelar o banco e criar as migrations e o seeder',
  'Como Claudia, preciso modelar o banco MySQL com as tabelas do portfólio e populá-las com o meu conteúdo real, para que o site leia tudo do banco e eu consiga editar pelo painel depois, sem mexer em código.

Todo texto que aparece no site vem do banco. Nada hardcoded no Angular.

Critérios de aceite:
- Banco MySQL local criado com o nome portfolio_claudia (MySQL, não SQLite)
- .env do backend configurado e conectando (php artisan migrate roda sem erro)
- Migrations criadas para: secoes (controle de visibilidade e ordem de cada seção), secao_hero, secao_sobre, habilidades, habilidades_soft (as que vêm da radiologia), timeline, formacoes, projetos, contatos (mensagens recebidas), configuracoes_site (SEO, links de redes, caminho do CV)
- Cada tabela com os campos que a seção realmente precisa — sem coluna sobrando por precaução
- Tabelas de lista (habilidades, timeline, projetos, formacoes) têm campo de ordenação
- Models Eloquent criados para cada tabela
- PortfolioSeeder populando TUDO com o conteúdo real do CONTEUDO.md (PC-03), usando updateOrCreate para poder rodar mais de uma vez sem duplicar
- php artisan migrate:fresh --seed roda limpo do zero e deixa o banco pronto',
  'Alta',
  'Fundação',
  'Tarefa',
  'Passo a passo:

1. Crie o banco pelo phpMyAdmin do Laragon ou por linha de comando: CREATE DATABASE portfolio_claudia;
2. Ajuste o .env: DB_CONNECTION=mysql, DB_DATABASE=portfolio_claudia, DB_USERNAME=root, DB_PASSWORD= (em branco no Laragon)
3. Cole o CONTEUDO.md para a IA e peça: ''a partir deste conteúdo, proponha as migrations Laravel 13 destas tabelas, com os campos mínimos necessários''
4. Revise o que ela propôs ANTES de rodar. Se tiver coluna que você não sabe explicar para que serve, tire.
5. Rode php artisan migrate e confira as tabelas no phpMyAdmin
6. Peça o seeder depois, já com o conteúdo real dentro

Regra importante: use updateOrCreate no seeder (não create). Assim você roda o seeder de novo depois de mudar um texto, sem duplicar linha.

Armadilha: a IA adora sugerir SQLite porque é mais fácil. Aqui é MySQL — é o padrão de todos os projetos da casa e é o que vai rodar em produção.',
  4,
  NOW(), NOW()
);

-- PC-05
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint2,
  @fila,
  '[PC-05] Endpoint público único GET /api/portfolio',
  'Como Claudia, preciso de um endpoint público único que devolva todo o conteúdo do portfólio numa chamada só, para que o site carregue rápido e o Angular não precise fazer dez requisições diferentes.

Critérios de aceite:
- Rota GET /api/portfolio, pública (fora de qualquer middleware de autenticação)
- Controller em app/Http/Controllers/Api/PortfolioController.php
- Devolve um JSON com uma chave por seção: hero, sobre, habilidades, habilidades_soft, timeline, formacoes, projetos, configuracoes
- Só devolve seções marcadas como visíveis na tabela secoes
- Listas vêm já na ordem definida pelo campo de ordenação
- Não devolve nada sensível (senha, e-mail de admin, id interno de usuário)
- Testado no navegador ou no Postman: abre http://localhost:8000/api/portfolio e o JSON aparece completo
- CORS liberado para localhost:4200 em desenvolvimento',
  'Alta',
  'Site público',
  'Tarefa',
  'Por que um endpoint só e não vários: cada requisição HTTP custa tempo de carregamento. Um portfólio tem pouco conteúdo — cabe tudo numa resposta. É o mesmo padrão do GET /api/landing do projeto Dolen.

Passo a passo:
1. php artisan make:controller Api/PortfolioController
2. Registre a rota em routes/api.php, FORA do grupo auth:sanctum
3. No método, carregue cada model e monte o array de resposta
4. Teste no navegador antes de mexer no Angular

Dica de prompt: ''escreva um controller Laravel 13 que devolve num único JSON o conteúdo destas tabelas [cole os nomes], filtrando por seções visíveis e respeitando o campo de ordenação''

Se o Angular der erro de CORS, o problema é no backend (config/cors.php), não no frontend.',
  5,
  NOW(), NOW()
);

-- PC-06
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint2,
  @fila,
  '[PC-06] Layout público: header fixo, menu mobile e footer',
  'Como visitante do site, preciso de um cabeçalho que me acompanhe durante a rolagem e um rodapé com os canais de contato, para navegar entre as seções e saber como falar com a Claudia de qualquer ponto da página.

Critérios de aceite:
- Componente de layout público que envolve todas as seções da home
- Header fixo no topo com o nome/logo à esquerda e links de âncora à direita (Início, Minha história, Habilidades, Projetos, Contato)
- Header ganha fundo e sombra depois de rolar um pouco (no topo fica transparente)
- Clicar num link rola suavemente até a seção certa
- No mobile, os links viram um menu sanduíche que abre e fecha, e fecha sozinho ao clicar num link
- Footer com nome, uma linha de descrição, ícones de LinkedIn, GitHub, Instagram e WhatsApp (todos abrindo em nova aba), e o ano atual calculado automaticamente
- Botão fixo de WhatsApp visível no mobile
- Tudo usando os tokens do PC-02, sem cor escrita na mão
- Testado em 360px, 768px e 1440px de largura',
  'Alta',
  'Site público',
  'Tarefa',
  'Passo a passo:
1. Crie o componente de layout e coloque nele o header, o <router-outlet> (ou os componentes de seção) e o footer
2. Para o header mudar ao rolar: escute o scroll da janela e adicione uma classe quando passar de ~50px
3. Para o scroll suave: scroll-behavior: smooth no CSS resolve 90% dos casos
4. Atenção ao header fixo: ao rolar até uma âncora, o título fica escondido atrás do header. Corrija com scroll-margin-top na seção, do tamanho da altura do header.

Armadilha: ícone de rede social em SVG inline é melhor que fonte de ícone — carrega mais rápido e aceita cor via CSS. Peça os SVGs para a IA ou pegue no simpleicons.org.

Links externos: sempre com target="_blank" e rel="noopener".',
  6,
  NOW(), NOW()
);

-- PC-07
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint2,
  @fila,
  '[PC-07] Seção Hero: apresentação, foto e chamadas para ação',
  'Como recrutador entrando no site, preciso entender em 5 segundos quem é a Claudia, o que ela faz e como falo com ela, sem precisar rolar a página.

Esta é a seção mais importante do site. Se ela não prender, o resto não é lido.

Critérios de aceite:
- Ocupa a primeira tela inteira (ou quase) no desktop
- Mostra: título profissional curto, nome, frase de apresentação de 2 a 3 linhas e a foto profissional
- Botão principal: Baixar currículo (abre o PDF em nova aba)
- Botão secundário: Falar no WhatsApp (link wa.me com o número e uma mensagem já preenchida)
- Link para o LinkedIn visível
- Indicador de rolagem no rodapé da seção (seta ou texto) mostrando que tem mais conteúdo abaixo
- Todo o texto vem do GET /api/portfolio, nada escrito no HTML
- No mobile, a foto vai para cima ou diminui, e o texto continua legível sem rolagem horizontal
- Foto otimizada (WebP se possível, menos de 200KB) e com atributo alt descritivo',
  'Urgente',
  'Site público',
  'Tarefa',
  'O que faz um hero parecer profissional:
- Espaço em volta do texto. Aperto é o que denuncia site amador.
- Um título grande, um subtítulo médio, um parágrafo pequeno. Hierarquia clara de 3 níveis.
- Só DOIS botões. Três ou mais e o visitante não escolhe nenhum.

Link de WhatsApp: https://wa.me/55DDDNUMERO?text=Oi%20Claudia,%20vi%20seu%20portfolio

Dica: peça para a IA ''gere 3 variações de layout de hero para portfólio com foto'', escolha uma e refine. Não aceite a primeira coisa que vier.

A foto importa mais do que você imagina. Boa luz, fundo limpo, olhando para a câmera. Se a que você tem não está boa, tire outra com o celular perto de uma janela — fica melhor que foto antiga de má qualidade.',
  7,
  NOW(), NOW()
);

-- PC-08
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint2,
  @fila,
  '[PC-08] Seção Minha história: da radiologia para a tecnologia',
  'Como recrutador, preciso entender a história da migração de carreira da Claudia e por que ela é uma vantagem, não uma lacuna no currículo, para que a mudança de área vire um ponto a favor na minha avaliação.

Esta é a seção que diferencia este portfólio de qualquer outro portfólio de desenvolvedora iniciante. Ela tem que ser bem escrita e bem apresentada.

Critérios de aceite:
- Seção com a narrativa em 3 blocos: de onde eu vim (radiologia), por que mudei, onde estou e para onde vou
- Texto na primeira pessoa, direto, sem tom de desculpa pela mudança de área
- Apresentação visual que quebra o texto em partes legíveis — nada de um parágrafo gigante corrido
- Bloco destacando as habilidades trazidas da radiologia que valem em tecnologia (protocolo, precisão, pressão, trato com pessoas), vindo da tabela habilidades_soft
- Todo o conteúdo vem do banco pelo GET /api/portfolio
- Animação suave de entrada ao rolar (fade e leve subida), sem exagero
- Legível e bem espaçada no mobile
- Texto revisado pelo Fernando antes de publicar',
  'Urgente',
  'Site público',
  'Historia',
  'Como não errar o tom:

Errado: ''Apesar de eu não ter formação em tecnologia, estou tentando aprender...''
Certo: ''Passei X anos na radiologia, onde errar não era uma opção. Trouxe essa disciplina para o desenvolvimento.''

A diferença não é enfeite — é a leitura que o recrutador faz de você. Nunca se diminua na copy do próprio portfólio.

Sobre a apresentação visual: 3 cartões lado a lado, ou uma linha vertical ligando os 3 momentos, funcionam bem. Peça para a IA duas opções e escolha.

Cuidado com a animação ao rolar: se o conteúdo só aparece depois da animação e ela falha, o texto fica invisível. Garanta que o texto esteja visível por padrão e a animação só melhore a entrada.',
  8,
  NOW(), NOW()
);

-- PC-09
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint2,
  @fila,
  '[PC-09] Seção Habilidades técnicas',
  'Como recrutador técnico, preciso ver rapidamente quais tecnologias a Claudia domina e em que nível, para avaliar se ela encaixa na vaga que estou tentando preencher.

Critérios de aceite:
- Grade de habilidades vinda da tabela habilidades pelo GET /api/portfolio
- Cada habilidade mostra nome, ícone ou logo da tecnologia e o nível
- Nível representado de forma honesta e clara — pode ser rótulo (Básico, Intermediário, Avançado) ou barra, mas tem que refletir a verdade
- Habilidades agrupadas por categoria (ex.: Frontend, Backend, Ferramentas) se fizer sentido
- Ordem vem do campo de ordenação do banco (as mais fortes primeiro)
- Funciona bem com qualquer quantidade de itens — 5 ou 15 não quebram o layout
- No mobile vira 2 colunas ou 1, sem rolagem horizontal',
  'Alta',
  'Site público',
  'Tarefa',
  'Sobre porcentagem em barra: ''Angular 85%'' não significa nada e cria expectativa que a entrevista técnica vai cobrar. Rótulo (Básico/Intermediário/Avançado) é mais honesto e mais seguro. Se preferir barra por causa do visual, use 3 tamanhos fixos ligados aos mesmos rótulos.

Ícones de tecnologia: pegue em devicon.dev ou simpleicons.org (SVG, de graça).

Armadilha: listar tecnologia que você só ouviu falar, para a lista parecer maior. Uma lista curta e verdadeira passa mais confiança que uma longa e furada — e te protege na entrevista.',
  9,
  NOW(), NOW()
);

-- PC-10
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint2,
  @fila,
  '[PC-10] Seção Trajetória: linha do tempo da carreira e formação',
  'Como recrutador, preciso ver a sequência da carreira e da formação da Claudia numa linha do tempo, para entender o caminho que ela percorreu e há quanto tempo está em tecnologia.

Critérios de aceite:
- Linha do tempo em ordem cronológica, vinda da tabela timeline
- Cada item mostra período (ano ou intervalo), título e uma descrição curta
- Itens de áreas diferentes (saúde e tecnologia) são visualmente distinguíveis — cor, ícone ou rótulo
- Bloco de formação (cursos e certificados) com instituição e ano, vindo da tabela formacoes
- No desktop pode alternar os lados da linha; no mobile fica tudo de um lado só, alinhado à esquerda
- Ordem e conteúdo vêm do banco, nada hardcoded',
  'Media',
  'Site público',
  'Tarefa',
  'Linha do tempo alternando lados fica bonita no desktop e quebra feio no mobile se você não tratar. Faça o mobile primeiro (tudo de um lado), depois adicione a alternância só a partir de 768px com media query.

Dica de prompt: ''linha do tempo vertical responsiva em Angular e SCSS, um lado só no mobile e alternando lados a partir de 768px''

Marque claramente onde a tecnologia entra na história. É esse ponto que o recrutador procura na tela.',
  10,
  NOW(), NOW()
);

-- PC-11
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint2,
  @fila,
  '[PC-11] Seção Projetos: cartões com prova de trabalho',
  'Como recrutador técnico, preciso ver projetos reais que a Claudia construiu, com o código disponível, para julgar a capacidade dela por evidência e não por autodeclaração.

Esta seção é o que sustenta tudo o que o resto do site afirma.

Critérios de aceite:
- Grade de cartões de projeto vinda da tabela projetos
- Cada cartão mostra: imagem ou captura de tela, nome, descrição de 1 a 2 linhas, etiquetas de tecnologias usadas, e o meu papel no projeto
- Cada cartão tem link para o repositório no GitHub e, quando existir, link para o site no ar
- Imagens com carregamento tardio (loading="lazy") e alt descritivo
- Cartão inteiro é clicável ou tem botões claros — não deixe o visitante adivinhando onde clicar
- Layout aguenta de 2 a 8 projetos sem ficar estranho
- Ordem vem do banco (melhor projeto primeiro)
- No mobile vira 1 coluna',
  'Urgente',
  'Site público',
  'Tarefa',
  'Regras que valem mais que o código desta card:

1. Todo projeto listado precisa ter repositório público e README decente. Recrutador clica. Repositório sem README ou com commit ''teste teste'' derruba a impressão que o site construiu.
2. Melhor 3 projetos bem acabados que 8 pela metade.
3. Deixe explícito o seu papel: ''projeto do curso'', ''contribuição em projeto real'', ''projeto próprio'' — cada um vale, mas mentir sobre qual é queima.
4. Captura de tela: tire em tela cheia, sem aba do navegador com 40 guias abertas nem barra de tarefas aparecendo.

Combine com o Fernando o que pode ser mostrado do Dolen e de qualquer projeto de cliente ANTES de publicar.',
  11,
  NOW(), NOW()
);

-- PC-12
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint2,
  @fila,
  '[PC-12] Seção Contato: formulário que grava e avisa por e-mail',
  'Como recrutador interessado, preciso mandar uma mensagem para a Claudia direto pelo site, e ela precisa ser avisada na hora, para que uma oportunidade não fique esperando numa caixa que ninguém abre.

Critérios de aceite:
- Formulário com nome e e-mail obrigatórios, telefone e mensagem opcionais
- POST /api/contatos (rota pública) valida os campos e grava na tabela contatos com status inicial ''novo''
- Envia e-mail de aviso para o meu endereço, com responder-para apontando para o e-mail de quem escreveu
- Validação também no frontend, com mensagem de erro clara embaixo de cada campo
- Botão de enviar mostra estado de carregando e fica desabilitado durante o envio (sem envio duplicado por clique repetido)
- Mensagem de sucesso visível depois do envio e formulário limpo
- Se a API falhar, mostra erro e NÃO limpa o que a pessoa escreveu
- Ao lado do formulário: e-mail, WhatsApp, LinkedIn e GitHub como alternativas de contato
- Testado de ponta a ponta: enviar pelo site, conferir a linha no banco e conferir o e-mail recebido',
  'Alta',
  'Site público',
  'Tarefa',
  'Passo a passo:
1. Backend primeiro: migration (já feita no PC-04), rota, controller com validação, Mailable
2. Teste o POST no Postman antes de encostar no Angular
3. Para e-mail em desenvolvimento, use MAIL_MAILER=log — o e-mail cai em storage/logs/laravel.log e você confere lá, sem configurar SMTP agora
4. SMTP de verdade só na hora do deploy (PC-21)
5. Depois faça o formulário no Angular com Reactive Forms

Armadilha clássica: esquecer o estado de carregando. A pessoa clica 4 vezes e chegam 4 e-mails iguais.

Segurança mínima: valide no backend também, sempre. Validação só no frontend não é validação — qualquer um manda requisição direto na API.',
  12,
  NOW(), NOW()
);

-- PC-13
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint2,
  @fila,
  '[PC-13] Polimento visual: animações de entrada e estados de carregamento',
  'Como visitante, preciso que o site pareça vivo e bem acabado ao rolar e ao carregar, para ter a impressão de estar vendo trabalho de alguém cuidadoso.

Esta card é de acabamento. Só pegue depois que todas as seções estiverem funcionando.

Critérios de aceite:
- Seções entram com animação suave ao aparecer na tela (fade e leve subida), usando IntersectionObserver
- Animação acontece uma vez por seção, não toda vez que rola para cima e para baixo
- Enquanto o GET /api/portfolio não responde, aparece um esqueleto de carregamento ou indicador — nunca a tela branca piscando conteúdo
- Botões e cartões têm estado de foco e de mouse em cima visíveis
- Navegação por teclado funciona: dá para percorrer o site inteiro no Tab e o foco é sempre visível
- Respeita prefers-reduced-motion: quem configurou o sistema para menos animação recebe o site sem animação
- Nenhuma animação passa de 400ms — animação lenta parece travamento',
  'Baixa',
  'Site público',
  'Melhoria',
  'IntersectionObserver é a forma certa de animar ao rolar. Escutar o evento de scroll para isso deixa a página lenta.

prefers-reduced-motion não é enfeite de acessibilidade: tem gente que passa mal com animação. São 4 linhas de CSS:
@media (prefers-reduced-motion: reduce) { * { animation: none !important; transition: none !important; } }

Teste o Tab de verdade, do topo ao rodapé, sem tocar no mouse. Se você se perder na tela, um usuário de leitor de tela também se perde.

Saiba parar: esta card pode virar um poço sem fundo. Duas horas aqui é suficiente.',
  13,
  NOW(), NOW()
);

-- PC-14
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint3,
  @fila,
  '[PC-14] Autenticação do painel com Sanctum e tela de login',
  'Como Claudia, preciso entrar num painel protegido por login, para editar o conteúdo do meu portfólio sem que ninguém de fora consiga mexer.

Critérios de aceite:
- Laravel Sanctum instalado e configurado com autenticação por token
- POST /api/admin/login recebe e-mail e senha e devolve um token
- POST /api/admin/logout invalida o token
- Todas as rotas de administração ficam num grupo protegido por auth:sanctum
- Meu usuário criado por seeder (senha definida por variável de ambiente ou trocada no primeiro acesso — NUNCA senha em código commitado)
- Tela de login em /admin/login no Angular, com erro claro quando a senha está errada
- Token guardado no navegador e enviado automaticamente em toda chamada de administração por um interceptor
- Guard de rota: quem não está logado e tenta abrir /admin/qualquercoisa é mandado para o login
- Token expirado ou resposta 401 derruba a sessão e volta para o login
- Testado: entrar, recarregar a página e continuar logado; sair e não conseguir mais abrir o painel',
  'Alta',
  'Painel',
  'Tarefa',
  'Passo a passo:
1. composer require laravel/sanctum e rode as migrations dele
2. Crie o AuthController com login e logout
3. Teste no Postman: login devolve token, e uma rota protegida só responde com o cabeçalho Authorization: Bearer TOKEN
4. Só então faça a tela no Angular

Dois pontos onde quase todo mundo erra:
- Interceptor: sem ele você vai colar o token na mão em cada chamada e esquecer em alguma
- 401: sem tratar, o painel fica mostrando tela quebrada em vez de pedir login de novo

SENHA: nunca em código, nunca em commit. Use variável de ambiente no seeder. Se vazar uma vez, vazou para sempre — o histórico do Git guarda.',
  14,
  NOW(), NOW()
);

-- PC-15
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint3,
  @fila,
  '[PC-15] Layout do painel e painel inicial',
  'Como Claudia logada, preciso de um painel com menu lateral e uma tela inicial de resumo, para circular entre as áreas de edição e ver de relance se chegou mensagem nova.

Critérios de aceite:
- Layout de administração separado do layout público (menu lateral, área de conteúdo, botão de sair)
- Menu com: Início, Textos das seções, Habilidades, Trajetória, Projetos, Mensagens, Configurações
- Item do menu correspondente à tela atual fica destacado
- Tela inicial mostra números reais vindos da API: total de projetos, total de habilidades, mensagens não lidas
- Tela inicial lista as últimas 5 mensagens recebidas com link para a tela de mensagens
- Painel usável no celular (menu lateral recolhe)
- Nome da pessoa logada e botão de sair sempre visíveis',
  'Alta',
  'Painel',
  'Tarefa',
  'Faça o esqueleto do painel ANTES das telas de CRUD. Com o layout e o menu prontos, cada CRUD novo é só encaixar.

Os números da tela inicial devem vir de UM endpoint (GET /api/admin/dashboard) que já devolve tudo contado no backend. Não puxe as listas inteiras para contar no frontend.

O painel não precisa ser bonito como o site público — precisa ser rápido e claro. Não gaste tempo de design aqui.',
  15,
  NOW(), NOW()
);

-- PC-16
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint3,
  @fila,
  '[PC-16] Painel: editar os textos das seções',
  'Como Claudia, preciso editar os textos do hero, da minha história e do contato pelo painel, para atualizar a minha apresentação quando a minha situação profissional mudar, sem depender de ninguém e sem mexer em código.

Critérios de aceite:
- Tela com abas ou blocos, um por seção (Hero, Minha história, Contato)
- Campos de texto carregados com o conteúdo atual do banco
- GET /api/admin/conteudo e PUT /api/admin/conteudo/{secao} no backend, dentro do grupo autenticado
- Salvar mostra confirmação e, se der erro, mostra o erro sem perder o que eu digitei
- Aviso claro quando saio da tela com alteração não salva
- Campos com limite de tamanho coerente com o layout (título curto não pode aceitar 500 caracteres e estourar o design)
- Depois de salvar, recarregar o site público mostra o texto novo',
  'Alta',
  'Painel',
  'Tarefa',
  'Este é o primeiro CRUD — vale tratar como modelo. O padrão que você montar aqui (carregar, editar, salvar, confirmar, tratar erro) se repete em todas as outras telas do painel.

Dica de prompt: ''formulário Angular com Reactive Forms que carrega dados de um GET, envia num PUT, mostra estado de carregando, mensagem de sucesso e erros de validação por campo''

Aviso de alteração não salva: dá para resolver com um guard de saída de rota no Angular. Vale o esforço — perder texto escrito é frustrante e acontece.

Limite de caracteres não é burocracia: é o que impede o seu próprio texto de quebrar o layout que você construiu.',
  16,
  NOW(), NOW()
);

-- PC-17
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint3,
  @fila,
  '[PC-17] Painel: gerenciar habilidades e trajetória',
  'Como Claudia, preciso adicionar, editar, remover e reordenar as minhas habilidades, os itens da trajetória e as formações pelo painel, para manter o portfólio atualizado à medida que eu aprendo coisas novas.

Critérios de aceite:
- Tela de habilidades: listar, criar, editar, excluir e reordenar (técnicas e as trazidas da radiologia)
- Tela de trajetória: mesma coisa para os itens da linha do tempo e para as formações
- Reordenar de forma simples e que funcione no celular também — setas para cima e para baixo já resolvem, arrastar é opcional
- Excluir pede confirmação antes
- Rotas de administração completas para cada recurso, todas autenticadas
- Validação no backend: campo obrigatório não passa vazio
- Depois de mexer aqui, o site público reflete a ordem e o conteúdo novos',
  'Alta',
  'Painel',
  'Tarefa',
  'Sobre arrastar e soltar: é bonito e é armadilha de tempo. Setas para cima e para baixo levam 20 minutos e funcionam no celular. Faça as setas primeiro; se sobrar tempo no fim do projeto, troque por arrastar.

A ordenação é salva num campo numérico. Ao mover um item, envie a nova ordem da lista inteira para o backend numa chamada só — é mais simples e não deixa o banco inconsistente.

Confirmação antes de excluir: um window.confirm resolve. Sem isso, um clique errado apaga trabalho seu.',
  17,
  NOW(), NOW()
);

-- PC-18
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint3,
  @fila,
  '[PC-18] Painel: gerenciar projetos com envio de imagem',
  'Como Claudia, preciso cadastrar os meus projetos pelo painel, com captura de tela, tecnologias e links, para publicar um projeto novo assim que eu terminar, sem pedir ajuda.

Critérios de aceite:
- Listar, criar, editar, excluir e reordenar projetos
- Formulário com: nome, descrição, tecnologias, meu papel, link do repositório, link do site, imagem
- Envio de imagem funcionando: arquivo salvo no storage do Laravel e URL gravada no banco
- Valida tipo (jpg, png, webp) e tamanho máximo (4MB) — no frontend e no backend
- Pré-visualização da imagem escolhida antes de salvar
- Trocar a imagem de um projeto apaga a antiga do disco (sem lixo acumulando)
- Excluir projeto pede confirmação e apaga também a imagem
- Site público mostra a imagem enviada corretamente, em desenvolvimento e em produção',
  'Alta',
  'Painel',
  'Tarefa',
  'Envio de arquivo é onde mais gente trava. Ordem de ataque:
1. php artisan storage:link (sem isso a imagem salva mas não abre pelo navegador — erro nº 1)
2. Teste o envio pelo Postman primeiro
3. Só depois faça o formulário no Angular

No Angular, envio de arquivo vai como FormData, não como JSON. E não defina o Content-Type na mão — o navegador precisa montar o boundary sozinho.

Monte a URL da imagem com o domínio completo no backend. Se devolver só /storage/..., o Angular em localhost:4200 vai procurar a imagem nele mesmo e não no Laravel. Isso já aconteceu no projeto Avante e no Dolen.

Valide no backend também. Validação só no frontend não impede ninguém de enviar um arquivo de 80MB direto na API.',
  18,
  NOW(), NOW()
);

-- PC-19
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint3,
  @fila,
  '[PC-19] Painel: caixa de mensagens recebidas',
  'Como Claudia, preciso ver e acompanhar as mensagens que chegam pelo site dentro do painel, para não perder uma oportunidade de trabalho e saber quais eu já respondi.

Critérios de aceite:
- Lista de mensagens em ordem decrescente de data, com nome, e-mail, início da mensagem e data
- Mensagem não lida aparece destacada
- Clicar abre a mensagem completa e marca como lida
- Status editável: nova, lida, respondida, descartada
- Filtro por status
- Botão de responder que abre o e-mail (mailto) ou o WhatsApp com o contato já preenchido
- Excluir mensagem pede confirmação
- Contador de mensagens não lidas aparece no menu do painel e bate com a lista',
  'Media',
  'Painel',
  'Tarefa',
  'Comece simples: lista, abrir, marcar status. Filtro e contador vêm depois.

Marcar como lida ao abrir é o comportamento esperado — mas deixe uma forma de marcar como não lida de novo, para quando você abrir sem tempo de responder.

O padrão de status aqui é o mesmo do CRM de leads do Dolen (novo por padrão, e avança). Se quiser referência de como foi feito lá, pergunte ao Fernando.

Por que isso importa: o e-mail de aviso do PC-12 pode cair no spam ou se perder. Esta tela é a rede de segurança.',
  19,
  NOW(), NOW()
);

-- PC-20
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint3,
  @fila,
  '[PC-20] Painel: configurações do site e visibilidade das seções',
  'Como Claudia, preciso editar meus links de redes sociais, trocar o currículo em PDF e ligar ou desligar seções do site pelo painel, para ajustar o portfólio conforme a vaga que estou buscando.

Critérios de aceite:
- Tela de configurações com: links de LinkedIn, GitHub, Instagram e WhatsApp, e-mail de contato, cidade
- Envio de novo currículo em PDF, substituindo o anterior (valida que é PDF e o tamanho)
- Campos de SEO: título da página, descrição, imagem de compartilhamento
- Lista de seções do site com um botão de liga e desliga em cada
- Seção desligada desaparece do site público E do menu do header automaticamente
- Não deixa desligar o hero (sem ele o site não faz sentido)
- Mudanças aparecem no site público depois de recarregar',
  'Media',
  'Painel',
  'Tarefa',
  'Sobre a visibilidade: o GET /api/portfolio (PC-05) já filtra por seção visível. O menu do header (PC-06) precisa se montar a partir das seções que vieram na resposta, não de uma lista fixa no código — senão vai sobrar link apontando para seção que não existe mais e o site quebra ao clicar.

No projeto Dolen tem um detalhe elegante: as seções alternam a cor de fundo calculada em cima das seções VISÍVEIS, para nunca sobrarem duas do mesmo tom colado quando você desliga uma do meio. Se você usar fundos alternados, resolva isso na mesma lógica.

Troca do currículo: apague o PDF antigo ao subir o novo, ou o storage vai acumulando arquivo morto.',
  20,
  NOW(), NOW()
);

-- PC-21
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint4,
  @fila,
  '[PC-21] Revisar responsividade em todos os tamanhos de tela',
  'Como visitante usando celular, preciso que o site funcione perfeitamente na minha tela, porque é de celular que a maioria das pessoas vai abrir o link do meu portfólio.

Critérios de aceite:
- Site revisado e corrigido em 360px, 390px, 768px, 1024px e 1440px de largura
- ZERO rolagem horizontal em qualquer largura
- Nenhum texto cortado, sobreposto ou ilegível
- Todo botão e link com área de toque de no mínimo 44 por 44 pixels no mobile
- Imagens nunca estouram o contêiner
- Menu sanduíche abre, fecha e não deixa a página rolar por baixo quando está aberto
- Painel administrativo também usável no celular
- Testado num celular de verdade, não só no simulador do navegador',
  'Alta',
  'Qualidade & Publicação',
  'Tarefa',
  'Como testar de verdade: no Chrome, F12 e depois Ctrl+Shift+M liga o modo de dispositivo. Percorra as larguras uma a uma.

Depois teste no seu celular de verdade: rode ng serve --host 0.0.0.0 e abra pelo IP da sua máquina na mesma rede wi-fi. Sempre aparece algo que o simulador não mostrou.

As 3 causas mais comuns de rolagem horizontal:
1. Largura fixa em px onde devia ser max-width: 100%
2. Elemento com width: 100% mais padding, sem box-sizing: border-box
3. Texto longo sem espaço (URL, e-mail) — resolve com overflow-wrap: anywhere

Gotcha do projeto Dolen: testar layout mobile com Chrome headless e --window-size engana, porque ele renderiza num viewport maior e recorta, criando falso ''overflow''. Se precisar automatizar, embuta a página num iframe de 390px de largura — aí o viewport é o real.',
  21,
  NOW(), NOW()
);

-- PC-22
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint4,
  @fila,
  '[PC-22] SEO e compartilhamento: meta tags, JSON-LD, sitemap e favicon',
  'Como Claudia, preciso que o meu nome encontre o meu portfólio no Google e que o link fique bonito quando eu compartilhar no LinkedIn ou no WhatsApp, para que o site trabalhe por mim mesmo quando eu não estou mandando o link para ninguém.

Critérios de aceite:
- Título e descrição da página vindos das configurações do banco
- Open Graph completo (título, descrição, imagem, url, tipo) — link no WhatsApp e no LinkedIn mostra cartão com imagem
- Twitter Card configurado
- JSON-LD do tipo Person com meu nome, cargo, links de redes sociais e formação
- Favicon em vários tamanhos, incluindo ícone para celular
- robots.txt liberando o site e apontando o sitemap
- sitemap.xml com as páginas públicas
- Painel administrativo com noindex (não pode aparecer em busca)
- Idioma declarado no HTML: lang="pt-BR"
- Testado: colar a URL no validador de Open Graph do Facebook e no Post Inspector do LinkedIn, e o cartão aparece certo',
  'Alta',
  'Qualidade & Publicação',
  'Tarefa',
  'Só faz sentido depois do deploy (PC-23), porque os validadores precisam da URL no ar. Faça o código agora e a validação depois de publicar.

A imagem de compartilhamento deve ter 1200 por 630 pixels. Fora dessa proporção, o LinkedIn corta no lugar errado.

JSON-LD de Person é o que faz o Google entender que o site é sobre uma pessoa profissional. É um bloco de script no HTML — peça para a IA gerar com os seus dados.

O LinkedIn guarda em cache agressivamente. Se você compartilhar antes de acertar a imagem, use o Post Inspector para forçar a releitura.',
  22,
  NOW(), NOW()
);

-- PC-23
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint4,
  @fila,
  '[PC-23] Publicar o site: hospedagem, domínio e SMTP',
  'Como Claudia, preciso do portfólio no ar num endereço próprio, com o formulário de contato mandando e-mail de verdade, para poder colocar o link no meu currículo e no meu LinkedIn.

Esta card depende de decisões do Fernando (onde hospedar e qual domínio). NÃO execute sem falar com ele primeiro.

Critérios de aceite:
- Hospedagem definida com o Fernando
- Domínio definido com o Fernando
- Frontend compilado para produção (ng build) e publicado
- Backend publicado, com .env de produção (APP_ENV=production, APP_DEBUG=false)
- Banco de produção criado e migrations mais seeder rodados
- HTTPS funcionando e sem aviso de conteúdo misto no console
- SMTP real configurado e testado: enviar pelo formulário do site no ar e receber o e-mail
- Configuração do servidor redirecionando rotas do Angular para o index.html (recarregar uma rota interna não pode dar 404)
- CORS de produção liberando só o domínio do site, não o mundo todo
- Passo a passo do deploy escrito num arquivo DEPLOY.md, para o próximo deploy não ser descoberta de novo
- NENHUMA credencial de produção commitada no repositório',
  'Urgente',
  'Qualidade & Publicação',
  'Tarefa',
  'PARE e fale com o Fernando antes de começar esta card. Hospedagem, domínio e acesso ao servidor são decisões e credenciais dele.

Pontos onde deploy de Angular quebra sempre:
1. Rota interna dá 404 ao recarregar — falta a regra de reescrita para o index.html no servidor
2. Caminho base errado no build faz os arquivos não carregarem
3. A API continua apontando para localhost — confira o environment de produção do Angular

APP_DEBUG=false em produção não é frescura: com true, qualquer erro mostra na tela caminhos internos e trechos de configuração do servidor para qualquer visitante.

Credenciais de produção: nunca no Git. Se for preciso registrar, faça num arquivo fora do repositório (o padrão da casa é um DEPLOY.private.md não versionado) e combine isso com o Fernando.',
  23,
  NOW(), NOW()
);

-- PC-24
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint4,
  @fila,
  '[PC-24] Revisão final com o Fernando antes de divulgar',
  'Como Claudia, preciso de uma revisão crítica do site no ar antes de divulgar o link, para não descobrir um erro de português ou um link quebrado depois de mandar o portfólio para um recrutador.

Critérios de aceite:
- Site inteiro lido em voz alta para caçar erro de português e frase esquisita
- TODOS os links clicados um por um: redes sociais, repositórios, sites de projetos, download do currículo, WhatsApp
- Formulário de contato testado do site no ar e e-mail recebido
- Site aberto num celular, num notebook e num monitor grande
- Console do navegador sem erro em vermelho
- Testado em Chrome e em Firefox
- Nenhuma imagem quebrada, nenhum texto de exemplo esquecido (procurar por ''lorem'', ''teste'', ''exemplo'' no código)
- Fernando revisou e aprovou o conteúdo e o visual
- Lista de melhorias futuras anotada nesta card (o que ficou para depois, para não travar a publicação)
- Só depois de tudo isso: atualizar o link no LinkedIn e no currículo',
  'Media',
  'Qualidade & Publicação',
  'Tarefa',
  'Ler em voz alta parece bobagem e é o método mais eficiente que existe para achar frase ruim. Erro que o olho pula, a boca tropeça.

Checagem rápida de sujeira esquecida: procure no projeto inteiro por ''lorem'', ''teste'', ''TODO'', ''FIXME'', ''localhost'' e ''exemplo''. Sempre sobra alguma coisa.

Não espere estar perfeito para publicar. Um portfólio bom no ar vale infinitamente mais que um portfólio perfeito na sua máquina. Anote o que faltou e publique.

Depois de publicar: mande o link para 2 ou 3 pessoas de confiança e pergunte ''o que você entendeu que eu faço?''. Se a resposta não for o que você quis dizer, o problema está na copy, não em quem leu.',
  24,
  NOW(), NOW()
);

COMMIT;

-- Conferencia depois de rodar:
-- SELECT id, name FROM boards WHERE id = @board;
-- SELECT s.name, COUNT(t.id) FROM sprints s
--   LEFT JOIN tasks t ON t.sprint_id = s.id
--   WHERE s.board_id = @board GROUP BY s.id ORDER BY s.sort_order;
