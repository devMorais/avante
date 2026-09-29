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

-- Passo 3: as 3 sprints
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Sprint 1 — Conteúdo real', '2026-09-30', '2026-10-11', 1, NOW(), NOW());
SET @sprint1 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Sprint 2 — Painel administrativo', '2026-10-12', '2026-11-08', 2, NOW(), NOW());
SET @sprint2 := LAST_INSERT_ID();
INSERT INTO sprints (board_id, name, start_date, end_date, sort_order, created_at, updated_at)
VALUES (@board, 'Sprint 3 — Qualidade & Publicação', '2026-11-09', '2026-11-29', 3, NOW(), NOW());
SET @sprint3 := LAST_INSERT_ID();

-- Passo 4: as 12 cards, todas em 'Em Fila'
-- PC-01
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint1,
  @fila,
  '[PC-01] Rodar o projeto na sua máquina',
  'Como Claudia, preciso subir na minha máquina o projeto que o Fernando já montou, para conseguir mexer nele e ver o resultado no navegador.

O projeto está em https://github.com/devMorais/portfolio-claudia e JÁ ESTÁ FUNCIONANDO — o site público inteiro renderiza, o painel tem login. Esta card é só colocar para rodar.

Critérios de aceite:
- Repositório clonado na minha máquina
- composer install e npm install rodados sem erro
- .env criado a partir do .env.example, com APP_KEY gerada
- Banco MySQL portfolio_claudia criado e o .env apontando para ele
- ADMIN_EMAIL e ADMIN_PASSWORD definidos no meu .env (é daí que o seeder cria o meu usuário do painel — sem isso ele não cria e avisa)
- php artisan migrate --seed rodou limpo
- npm run build rodou sem erro
- php artisan serve sobe e o site abre em http://127.0.0.1:8000
- Consigo entrar no painel em /admin com o meu e-mail e senha
- Li o README.md inteiro antes de mexer em qualquer arquivo',
  'Urgente',
  'Fundação',
  'Tarefa',
  'O passo a passo completo está no README.md do repositório. Siga ele.

Os 3 erros mais comuns nesta etapa:
1. Esquecer de criar o banco antes de rodar migrate. O MySQL não cria sozinho: CREATE DATABASE portfolio_claudia;
2. Não definir ADMIN_PASSWORD no .env. O seeder AVISA no terminal quando isso acontece, mas é fácil não ler e depois não conseguir entrar no painel.
3. Esquecer o npm run build. Sem ele não existe CSS compilado e o site abre sem estilo nenhum — parece que quebrou, mas é só isso.

Enquanto estiver editando SCSS ou JS, use npm run dev em vez de npm run build: ele fica rodando e recompila a cada arquivo salvo.

NUNCA commite o seu .env. Se ele aparecer no git status, para tudo e avisa o Fernando.',
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
  '[PC-02] Escrever a sua história e reunir o conteúdo real',
  'Como Claudia, preciso escrever o texto de verdade do meu portfólio, para o site parar de mostrar [PREENCHER] e virar uma apresentação minha.

Esta é a card mais importante do projeto inteiro. O site é bonito por causa do design, mas ele consegue emprego por causa do texto.

O banco já está montado com todos os campos — você só precisa do conteúdo. Ele entra pelo seeder agora (PortfolioSeeder.php) e depois pelo painel, quando as telas dele existirem.

Critérios de aceite — escrever um CONTEUDO.md na raiz do repositório com:
- Nome completo e como quero ser chamada profissionalmente
- Título profissional de uma linha
- Texto do hero: 2 a 3 linhas na primeira pessoa, dizendo o que faço hoje, de onde vim e o que procuro
- A história da migração em 3 atos: (1) o que eu fazia na radiologia e por quanto tempo, (2) o que me fez decidir migrar e quando, (3) onde estou hoje e o que procuro
- As 4 habilidades trazidas da radiologia, cada uma com uma frase ligando ao trabalho de desenvolvimento (protocolo sem atalho, atenção a detalhe, pressão, falar com quem não é da área)
- Lista de habilidades técnicas com nível honesto de cada uma
- Timeline de carreira: ano, título e descrição de cada etapa, marcando se é de saúde ou de tecnologia
- Formação: cursos, certificados, instituição e ano
- Projetos: nome, o que faz, tecnologias, o meu papel, link do repositório e do site
- Foto profissional em boa qualidade (mínimo 1000px de largura)
- Currículo em PDF salvo em public/curriculo.pdf
- Links de LinkedIn, GitHub, Instagram e o número do WhatsApp
- Todo esse conteúdo colocado no PortfolioSeeder.php no lugar dos [PREENCHER], e php artisan db:seed rodado
- Nenhum [PREENCHER] sobrando no site (abrir e conferir)
- Revisado pelo Fernando antes de seguir',
  'Urgente',
  'Conteúdo',
  'Tarefa',
  'Como escrever sem travar:

1. Escreva primeiro em português corrido, como se estivesse contando para uma amiga. Depois enxugue. Não comece tentando escrever bonito.

2. Sobre a migração: NÃO esconda a radiologia e NÃO peça desculpa por ela. É o seu diferencial.
   Errado: ''Apesar de não ter formação em tecnologia, estou tentando aprender...''
   Certo: ''Passei X anos na radiologia, onde errar não era uma opção. Trouxe essa disciplina para o desenvolvimento.''
   A diferença não é enfeite — é a leitura que o recrutador faz de você.

3. Use a IA para REVISAR, não para escrever do zero. Cole o seu texto e peça: ''revise a clareza mantendo a minha voz, sem deixar genérico e sem inventar fatos''. Texto 100% de IA é reconhecível na hora.

4. Não invente nível de habilidade. A entrevista técnica cobra o que está escrito no site.

5. O seeder é updateOrCreate: pode rodar quantas vezes quiser sem duplicar nada.

6. A foto importa mais do que parece. Boa luz, fundo limpo, olhando para a câmera. Se a que você tem não está boa, tire outra com o celular perto de uma janela.

Entregue esta card ANTES de começar o painel. Site com texto de mentira não pode ser mostrado para ninguém.',
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
  '[PC-03] Decidir e ajustar a identidade visual',
  'Como Claudia, preciso que o portfólio tenha a MINHA cara e não a paleta que o Fernando escolheu como ponto de partida, para o site parecer meu.

A paleta atual (papel quente, tinta quase preta, um verde profundo de destaque) é um ponto de partida que funciona. Se você gostar, mantenha e feche a card. Se quiser mudar, é fácil: está tudo num arquivo só.

Critérios de aceite:
- Li o resources/scss/_tokens.scss inteiro e entendi o que cada grupo de variável controla
- Decidi se mantenho ou troco a paleta e as fontes
- Se trocar: mexi SÓ no _tokens.scss, em nenhum outro arquivo
- Contraste do texto sobre o fundo testado e aprovado no webaim.org/resources/contrastchecker (mínimo AA)
- O site continua legível e bonito depois da mudança, em claro e em escuro de tela
- A decisão final (hex das cores e nome das fontes) anotada nesta card
- Nenhum #hex escrito na mão fora do _tokens.scss (procurar no projeto por ''#'' para conferir)
- Validado com o Fernando',
  'Alta',
  'Conteúdo',
  'Tarefa',
  'A regra que faz esse arquivo valer a pena: NENHUM outro arquivo do projeto escreve cor, fonte ou espaçamento na mão — tudo é var(--nome). Então trocar a paleta inteira do site é editar um arquivo.

Se for trocar, o caminho seguro:
- UMA cor de destaque só. O visual profissional vem do espaçamento e da tipografia, não da quantidade de cor. Três cores de destaque é o erro mais comum.
- Fontes que funcionam sempre: Sora + Inter (a atual), Space Grotesk + Inter, Poppins + Inter.
- Mude uma coisa por vez e olhe o site. Trocar tudo de uma vez e não gostar te deixa sem saber o que causou.

Se trocar a fonte, troque também o link do Google Fonts nos layouts (layouts/publico.blade.php, layouts/admin.blade.php e admin/login.blade.php).

Saiba parar: esta card pode virar um poço sem fundo. Uma hora é suficiente. A paleta atual já funciona.',
  3,
  NOW(), NOW()
);

-- PC-04
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint2,
  @fila,
  '[PC-04] Painel: editar os textos do hero e da minha história',
  'Como Claudia, preciso editar pelo painel o texto da minha apresentação e os 3 atos da minha história, para atualizar a minha apresentação quando a minha situação mudar, sem mexer em código.

Esta é a primeira tela de edição do painel. Trate como modelo: o padrão que você montar aqui (carregar, editar, salvar, confirmar, tratar erro) se repete em todas as outras.

Critérios de aceite:
- Rota, controller e view novos, dentro do grupo admin já existente em routes/web.php (o roteiro está comentado lá)
- Item ''Textos'' do menu do painel deixa de estar apagado e vira link
- Tela com dois blocos: Apresentação (secao_hero) e Minha história (secao_sobre)
- Campos carregados com o conteúdo atual do banco
- Salvar grava e mostra confirmação na tela
- Se der erro de validação, mostra o erro embaixo do campo e NÃO perde o que eu digitei
- Campos com maxlength coerente com o layout (título curto não pode aceitar 500 caracteres e estourar o design)
- Depois de salvar, recarregar o site público mostra o texto novo
- CSRF em todo formulário (@csrf)',
  'Alta',
  'Painel',
  'Tarefa',
  'Ordem de ataque:
1. Rota GET e PUT no grupo admin de routes/web.php
2. Controller: um método para mostrar, um para salvar
3. View Blade estendendo layouts.admin
4. Só depois mexa no menu do layout do painel

As classes de CSS já existem: .campo, .campo__rotulo, .campo__entrada, .campo__erro, .aviso--sucesso, .btn--principal. Olhe o resources/views/admin/login.blade.php para ver como usar — é o mesmo padrão.

Dica de prompt: ''formulário Blade em Laravel 13 que carrega os dados de um model, salva num PUT, mostra mensagem de sucesso com session flash e erros de validação por campo com @error''

Use $request->validate() no controller. Validação só no navegador não é validação.

maxlength não é burocracia: é o que impede o seu próprio texto de quebrar o layout que já está pronto.',
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
  '[PC-05] Painel: gerenciar habilidades',
  'Como Claudia, preciso adicionar, editar, remover e reordenar as minhas habilidades pelo painel, para manter o portfólio atualizado conforme eu aprendo coisas novas.

São dois tipos na mesma tabela: tipo = tecnica (PHP, Laravel, Git...) e tipo = humana (as trazidas da radiologia). A tela precisa dar conta dos dois.

Critérios de aceite:
- Listar, criar, editar e excluir habilidades, separadas por tipo na tela
- Campos: nome, tipo, categoria, nível, descrição, ícone, ordem
- Reordenar de forma simples e que funcione no celular (setas para cima e para baixo já resolvem)
- Excluir pede confirmação antes
- Validação no backend: nome é obrigatório, tipo só aceita tecnica ou humana
- Item ''Habilidades'' do menu deixa de estar apagado
- Depois de mexer aqui, o site público reflete a ordem e o conteúdo novos
- A seção de habilidades do site continua bonita com 5 ou com 15 itens',
  'Alta',
  'Painel',
  'Tarefa',
  'Sobre arrastar e soltar: é bonito e é armadilha de tempo. Setas para cima e para baixo levam 20 minutos e funcionam no celular. Faça as setas; se sobrar tempo no fim do projeto, troque.

Ao mover um item, envie a nova ordem da lista inteira numa chamada só — é mais simples e não deixa o banco inconsistente.

O campo icone guarda o slug do devicon (php, laravel, mysql, html5...). A view monta a URL do CDN a partir dele. Veja resources/views/secoes/habilidades.blade.php. A lista de slugs está em devicon.dev.

Confirmação antes de excluir: um onclick="return confirm(''Tem certeza?'')" no botão resolve. Sem isso, um clique errado apaga trabalho seu.',
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
  '[PC-06] Painel: gerenciar trajetória e formação',
  'Como Claudia, preciso editar pelo painel os itens da minha linha do tempo e as minhas formações, para registrar curso novo e mudança de trabalho sem depender de ninguém.

Critérios de aceite:
- CRUD completo de trajetorias: período, título, subtítulo, descrição, área, ordem
- CRUD completo de formacoes: título, instituição, ano, carga horária, link do certificado, ordem
- O campo area só aceita saude ou tecnologia (é o que muda a cor do item no site)
- Reordenar os dois, com o mesmo padrão de setas da card PC-05
- Excluir pede confirmação
- Item ''Trajetoria'' do menu deixa de estar apagado
- A linha do tempo do site continua correta depois de mexer, inclusive as cores por área',
  'Media',
  'Painel',
  'Tarefa',
  'Reaproveite o que você fez na PC-05. Se você teve que escrever tudo de novo aqui, provavelmente dá para extrair uma parcial Blade compartilhada dos formulários — mas não force: duplicar um pouco é melhor que abstrair cedo demais.

O campo area é o que faz a migração de carreira ficar visível na tela: itens de saúde ficam roxos, de tecnologia ficam verdes. É um detalhe pequeno que faz o recrutador entender a sua história de relance. Não deixe passar nenhum item com a área errada.

Use um <select> para area, não um campo de texto livre. Digitar ''Saude'' com maiúscula quebra a classe CSS.',
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
  '[PC-07] Painel: gerenciar projetos, com envio de imagem',
  'Como Claudia, preciso cadastrar os meus projetos pelo painel, com captura de tela, para publicar um projeto novo assim que eu terminar.

A seção de projetos é o que sustenta tudo o que o resto do site afirma.

Critérios de aceite:
- CRUD completo: nome, resumo, descrição, papel, tecnologias, links de repositório e de site, imagem, destaque, ordem
- Envio de imagem funcionando: arquivo no storage do Laravel e URL no banco
- Valida tipo (jpg, png, webp) e tamanho máximo (4MB), no navegador E no backend
- Pré-visualização da imagem escolhida antes de salvar
- Trocar a imagem de um projeto apaga a antiga do disco
- Excluir projeto pede confirmação e apaga a imagem junto
- Item ''Projetos'' do menu deixa de estar apagado
- A imagem aparece certo no site público',
  'Alta',
  'Painel',
  'Tarefa',
  'Envio de arquivo é onde mais gente trava. Ordem:
1. php artisan storage:link — SEM ISSO a imagem salva mas não abre pelo navegador. É o erro número 1, e a mensagem de erro não ajuda em nada.
2. Salve com $request->file(''imagem'')->store(''projetos'', ''public'')
3. Monte a URL com Storage::url() e teste abrindo direto no navegador

O .env já está com FILESYSTEM_DISK=public.

Regras que valem mais que o código desta card:
- Todo projeto listado precisa de repositório público com README decente. O recrutador clica. Repositório sem README derruba a impressão que o site construiu.
- Melhor 3 projetos bem acabados que 8 pela metade.
- Deixe explícito o seu papel: ''projeto próprio'', ''projeto de curso'', ''contribuição em projeto real''. Cada um vale — mentir sobre qual é queima.
- Captura de tela em tela cheia, sem 40 abas abertas no navegador aparecendo.

Combine com o Fernando o que pode ser mostrado do Dolen e de qualquer projeto de cliente ANTES de publicar.',
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
  '[PC-08] Painel: configurações e visibilidade das seções',
  'Como Claudia, preciso editar meus links, trocar o currículo e ligar ou desligar seções do site pelo painel, para ajustar o portfólio conforme a vaga que eu estiver buscando.

Critérios de aceite:
- Tela de configurações lendo e gravando a tabela configuracoes, agrupada por grupo (geral, redes, seo)
- Cada campo mostra o rótulo que já está no banco, não um texto escrito na view
- Envio de novo currículo em PDF, substituindo o anterior (valida que é PDF e o tamanho)
- Envio da imagem de compartilhamento (og), avisando que o tamanho certo é 1200x630
- Lista das seções do site com um liga/desliga em cada
- Não deixa desligar o hero (sem ele o site não faz sentido)
- Seção desligada some do site E do menu do header automaticamente
- Item ''Configuracoes'' do menu deixa de estar apagado',
  'Media',
  'Painel',
  'Tarefa',
  'A parte de ligar/desligar JÁ FUNCIONA no site público — o HomeController filtra por Secao::visiveis() e o header e as bandas de fundo se montam em cima disso. Você só precisa da tela que edita o campo visivel. Teste mudando direto no banco antes de construir a tela: desligue a seção ''trajetoria'' no phpMyAdmin e recarregue o site. Ela some do menu junto. É assim que tem que continuar funcionando.

A tabela configuracoes é chave/valor com um campo rotulo. Monte a tela em cima disso, num loop: assim, adicionar uma configuração nova no futuro não exige mexer na view.

Troca do currículo: apague o PDF antigo ao subir o novo, ou o storage vai acumulando arquivo morto.

Ordem sugerida: comece pelas configurações de texto (mais simples), depois os uploads, depois o liga/desliga.',
  8,
  NOW(), NOW()
);

-- PC-09
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint3,
  @fila,
  '[PC-09] Revisar a responsividade em todos os tamanhos de tela',
  'Como visitante usando celular, preciso que o site funcione perfeitamente na minha tela, porque é de celular que a maioria das pessoas vai abrir o link do portfólio.

O site já foi feito responsivo, mas ainda não foi testado num celular de verdade nem com o conteúdo real — texto real tem tamanho diferente de texto de exemplo e é aí que as coisas quebram.

Critérios de aceite:
- Site revisado e corrigido em 360px, 390px, 768px, 1024px e 1440px
- ZERO rolagem horizontal em qualquer largura
- Nenhum texto cortado, sobreposto ou ilegível
- Todo botão e link com área de toque de no mínimo 44x44 pixels no mobile
- Menu sanduíche abre, fecha, fecha ao clicar num link e não deixa a página rolar por baixo
- Painel administrativo também usável no celular
- Testado num celular de verdade, não só no simulador
- Console do navegador sem erro em vermelho',
  'Alta',
  'Qualidade & Publicação',
  'Tarefa',
  'Como testar de verdade: no Chrome, F12 e depois Ctrl+Shift+M liga o modo de dispositivo. Percorra as larguras uma a uma.

Depois teste no seu celular: rode php artisan serve --host=0.0.0.0 e abra pelo IP da sua máquina, no mesmo wi-fi. Sempre aparece algo que o simulador não mostrou.

As 3 causas mais comuns de rolagem horizontal:
1. Largura fixa em px onde devia ser max-width: 100%
2. Elemento com width: 100% mais padding sem box-sizing: border-box (o projeto já tem o box-sizing global, então não deve acontecer)
3. Texto longo sem espaço (URL, e-mail) — resolve com overflow-wrap: anywhere

Gotcha conhecido: testar layout mobile com navegador headless e --window-size engana, porque ele renderiza num viewport maior e recorta, criando falso ''overflow''. Se precisar automatizar, embuta a página num iframe de 390px — aí o viewport é o real.',
  9,
  NOW(), NOW()
);

-- PC-10
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint3,
  @fila,
  '[PC-10] Fechar o SEO: favicon, sitemap, robots e validação',
  'Como Claudia, preciso que o meu nome encontre o meu portfólio no Google e que o link fique bonito quando eu compartilhar no LinkedIn, para o site trabalhar por mim mesmo quando eu não estou mandando o link para ninguém.

A parte de código já está feita: meta tags, Open Graph e JSON-LD do tipo Person estão no layout, lendo das configurações. Falta o que não dá para fazer sem o site no ar e sem as imagens.

Critérios de aceite:
- Imagem de compartilhamento de 1200x630 criada e cadastrada nas configurações
- Favicon em vários tamanhos, incluindo ícone para celular
- robots.txt liberando o site e apontando o sitemap
- sitemap.xml com a home
- Título e descrição de SEO preenchidos com texto real (sem [PREENCHER])
- Depois do deploy: URL testada no validador de Open Graph do Facebook e no Post Inspector do LinkedIn, e o cartão aparece certo
- Painel continua com noindex (já está, só conferir que não saiu)',
  'Media',
  'Qualidade & Publicação',
  'Tarefa',
  'A validação só funciona depois do deploy (PC-11), porque os validadores precisam da URL no ar. Faça o que dá agora e volte para validar depois de publicar.

A imagem de compartilhamento tem que ter 1200x630. Fora dessa proporção o LinkedIn corta no lugar errado. Pode ser simples: seu nome, seu título profissional e a sua foto.

O LinkedIn guarda cache agressivo. Se você compartilhar antes de acertar a imagem, use o Post Inspector para forçar a releitura.

O JSON-LD já está montado no HomeController (não no Blade — as chaves do schema.org começam com arroba e o Blade tentaria compilar como diretiva). Se precisar adicionar campo, é lá.',
  10,
  NOW(), NOW()
);

-- PC-11
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint3,
  @fila,
  '[PC-11] Publicar o site: hospedagem, domínio e HTTPS',
  'Como Claudia, preciso do portfólio no ar num endereço próprio, para colocar o link no meu currículo e no meu LinkedIn.

Esta card depende de decisões do Fernando (onde hospedar e qual domínio). NÃO execute sem falar com ele primeiro.

Critérios de aceite:
- Hospedagem definida com o Fernando
- Domínio definido com o Fernando
- Código publicado no servidor, com .env de produção (APP_ENV=production, APP_DEBUG=false)
- npm run build rodado e os assets publicados
- Banco de produção criado, migrations e seeder rodados
- storage:link feito no servidor (senão as imagens dos projetos não abrem)
- Permissões de storage/ e bootstrap/cache/ corretas
- HTTPS funcionando, sem aviso de conteúdo misto no console
- Passo a passo do deploy escrito num DEPLOY.md, para o próximo deploy não ser descoberta de novo
- NENHUMA credencial de produção commitada no repositório',
  'Urgente',
  'Qualidade & Publicação',
  'Tarefa',
  'PARE e fale com o Fernando antes de começar. Hospedagem, domínio e acesso ao servidor são decisões e credenciais dele.

APP_DEBUG=false em produção não é frescura: com true, qualquer erro mostra caminhos internos e trechos de configuração do servidor para qualquer visitante.

Pontos onde deploy de Laravel quebra sempre:
1. Esquecer o storage:link — imagem enviada pelo painel não abre
2. Permissão em storage/ e bootstrap/cache/ — dá erro 500 sem explicação
3. Rodar php artisan config:cache com o .env errado e o site ficar apontando para o banco local
4. Versão do PHP do CLI diferente da do site (já mordeu a gente no projeto Dolen: o composer instalou dependência quebrada porque o CLI era outra versão)

Credenciais de produção nunca no Git. O padrão da casa é um arquivo DEPLOY.private.md fora do versionamento — combine isso com o Fernando.',
  11,
  NOW(), NOW()
);

-- PC-12
INSERT INTO tasks (board_id, area, sprint_id, status_id, titulo, description,
                   priority, epic, type, notes, sort_order, created_at, updated_at)
VALUES (
  @board, 'programming',
  @sprint3,
  @fila,
  '[PC-12] Revisão final com o Fernando antes de divulgar',
  'Como Claudia, preciso de uma revisão crítica do site no ar antes de divulgar o link, para não descobrir um erro de português ou um link quebrado depois de já ter mandado o portfólio para um recrutador.

Critérios de aceite:
- Site inteiro lido em voz alta, caçando erro de português e frase esquisita
- TODOS os links clicados um por um: redes sociais, repositórios, sites de projetos, download do currículo, WhatsApp
- Site aberto num celular, num notebook e num monitor grande
- Console do navegador sem erro em vermelho
- Testado em Chrome e em Firefox
- Nenhuma imagem quebrada e nenhum texto de exemplo esquecido (procurar no projeto por PREENCHER, lorem, teste, exemplo, localhost)
- Fernando revisou e aprovou o conteúdo e o visual
- Lista de melhorias futuras anotada nesta card, para não travar a publicação
- Só depois de tudo isso: atualizar o link no LinkedIn e no currículo',
  'Alta',
  'Qualidade & Publicação',
  'Tarefa',
  'Ler em voz alta parece bobagem e é o método mais eficiente que existe para achar frase ruim. Erro que o olho pula, a boca tropeça.

Checagem de sujeira esquecida: procure no projeto inteiro por PREENCHER, lorem, TODO, FIXME, localhost e exemplo. Sempre sobra alguma coisa.

Não espere estar perfeito para publicar. Um portfólio bom no ar vale infinitamente mais que um portfólio perfeito na sua máquina. Anote o que faltou e publique.

Depois de publicar: mande o link para 2 ou 3 pessoas de confiança e pergunte ''o que você entendeu que eu faço?''. Se a resposta não for o que você quis dizer, o problema está no texto, não em quem leu.',
  12,
  NOW(), NOW()
);

COMMIT;

-- Conferencia depois de rodar:
-- SELECT id, name FROM boards WHERE id = @board;
-- SELECT s.name, COUNT(t.id) FROM sprints s
--   LEFT JOIN tasks t ON t.sprint_id = s.id
--   WHERE s.board_id = @board GROUP BY s.id ORDER BY s.sort_order;
