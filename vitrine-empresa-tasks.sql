-- ============================================================
-- Vitrine da Empresa — sprints + tarefas (board_id = 14)
-- Gerado a partir de vitrine-empresa-tasks.json
-- ATENÇÃO: script não é idempotente — rodar mais de uma vez duplica as linhas.
-- ============================================================

-- Passo 0 (conferência): confirme que o board é mesmo este antes de continuar
SELECT id, name FROM boards WHERE id = 14;

-- Passo 1: criar as 3 sprints
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
VALUES (14, 'Sprint 1 — Marca & Landing Page', '2026-07-01', '2026-07-14', NOW(), NOW());
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
VALUES (14, 'Sprint 2 — Redes & Preparação Comercial', '2026-07-15', '2026-07-28', NOW(), NOW());
INSERT INTO sprints (board_id, name, start_date, end_date, created_at, updated_at)
VALUES (14, 'Sprint 3 — Execução de Vendas & Tráfego', '2026-07-29', '2026-08-18', NOW(), NOW());

-- Passo 2: criar as 28 tarefas, já ligadas à sprint certa e status "Em Fila"
INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 1 — Marca & Landing Page' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como fundador, preciso decidir o nome comercial definitivo e a frase-âncora da empresa que vai unificar Avante, EduCore, Numen, ShopX, Votar, AGF e CRC como um portfólio único de produtos e serviços, posicionando a marca como uma casa de tecnologia e IA que constrói e vende sistemas — puxando o diferencial real do EduCore (IA generativa de verdade) como prova de capacidade técnica, em vez de soar como ''mais uma agência de site''.

Critérios de aceite:
- Escolher entre as opções já levantadas em PLANO-NEGOCIO.md (Morais Labs, devMorais Studio, Avante Software, Núcleo Dev) ou validar um nome novo, testando se soa como empresa de tecnologia/IA e não como agência genérica
- Testar a frase em voz alta: ''Eu sou da/o [Nome], a gente cria tecnologia e sistemas com IA...'' — se travar ou soar estranho, revisar
- Confirmar que o @nome está disponível no Instagram e no Facebook antes de bater o martelo (evita ter que trocar depois)
- Registrar a decisão final neste board e atualizar PLANO-NEGOCIO.md com o nome escolhido
- Escrever a frase-âncora de 1 linha que vai abrir a bio das redes e o topo da landing page, deixando claro o foco em tecnologia/IA + venda de sistemas',
  'Alta',
  'Marca & Posicionamento',
  1,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 1 — Marca & Landing Page' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como fundador, preciso consolidar uma identidade visual preto e branco, moderna e minimalista (logo, paleta monocromática, tipografia) reaproveitando o domínio devmorais.com.br que já é meu, para que a landing page, o ícone do quadro no Avante e os perfis de redes sociais transmitam a mesma estética ''tech'' em todos os lugares.

Critérios de aceite:
- Logo em preto, branco e tons de cinza (sem cores saturadas), estilo minimalista/moderno — pode ser um wordmark simples, não precisa de designer caro pra começar
- Paleta 100% monocromática (preto, branco, 1-2 tons de cinza) aplicada de forma consistente em site e redes, garantindo contraste legível em mobile
- Escolher 1 fonte para títulos e 1 para texto corrido, ambas com estética tech/moderna (ex.: sans-serif geométrica)
- Aplicar a mesma logo/paleta no favicon da landing page, na foto de perfil do Instagram e do Facebook, e no ícone do board ''Marketing | Plano de vendas'' no Avante
- Salvar os arquivos de logo (PNG com fundo transparente, pelo menos 512x512) num local acessível pra reuso',
  'Alta',
  'Marca & Posicionamento',
  2,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 1 — Marca & Landing Page' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como fundador, preciso consolidar o catálogo de produtos e serviços da empresa numa única lista de referência, reunindo o que já está espalhado em PLANO-NEGOCIO.md e PRIMEIROS-CLIENTES.md, para que essa lista vire a fonte única de verdade que alimenta a landing page, os posts das redes e as conversas de venda.

Critérios de aceite:
- Para cada produto (Avante, EduCore, Numen, ShopX, Votar, AGF, CRC): nome, 1 frase do problema que resolve, público-alvo, link de demo/produção quando existir, categoria (SaaS recorrente vs. projeto sob encomenda)
- Ordenar por prioridade comercial: o que vender primeiro (site institucional/CRC e loja virtual/ShopX, conforme PRIMEIROS-CLIENTES.md item 3) vem no topo
- Validar que todos os links funcionam antes de usar em qualquer material público',
  'Alta',
  'Marca & Posicionamento',
  3,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 1 — Marca & Landing Page' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como fundador, preciso resolver a base legal mínima pra vender oficialmente (MEI ou CNPJ, chave PIX empresarial), para poder emitir nota fiscal e passar profissionalismo já no primeiro cliente fechado, conforme já recomendado em PRIMEIROS-CLIENTES.md item 12.

Critérios de aceite:
- Decidir entre MEI (mais simples, custo ~R$0 de abertura) ou outra forma jurídica, considerando o volume esperado de faturamento
- Abrir o CNPJ (se ainda não existir) antes ou logo após o primeiro fechamento
- Configurar chave PIX vinculada ao CNPJ/MEI pra receber a entrada de 50% dos projetos
- Confirmar se é necessário emitir nota fiscal de serviço e como fazer isso (app do MEI ou equivalente)',
  'Média',
  'Marca & Posicionamento',
  4,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 1 — Marca & Landing Page' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como visitante que chega pela primeira vez na landing page, preciso entender em poucos segundos quem é a empresa, o que ela vende e como entrar em contato — por isso a estrutura da página (wireframe de seções) precisa ser definida antes de qualquer linha de código, evitando retrabalho.

Critérios de aceite:
- Seção Hero: frase-âncora (da história de Marca & Posicionamento, com foco em tecnologia/IA) + botão de CTA para WhatsApp em destaque
- Seção Sobre: 2-3 frases explicando o que é a empresa (casa de tecnologia especializada em IA e sistemas sob medida, não apenas ''agência de site'')
- Seção Produtos/Serviços: grid com os itens do catálogo consolidado, cada card com nome, frase, link de demo e botão ''saiba mais'' ou ''peça o seu'' — destacando o EduCore como prova de capacidade real em IA
- Seção Como funciona: 3 passos simples (conversa → proposta → entrega), refletindo o roteiro de vendas do PRIMEIROS-CLIENTES.md
- Seção Prova social: espaço para depoimentos/cases (mesmo que vazio no início, com placeholder claro)
- Seção Contato: formulário simples + WhatsApp + links de Instagram e Facebook
- Rodapé com CNPJ/razão social quando disponível
- Toda a página seguindo a identidade preto e branco/moderna definida no épico Marca & Posicionamento, sem cores fora da paleta monocromática',
  'Alta',
  'Landing Page',
  5,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 1 — Marca & Landing Page' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa, preciso ter a landing page one-page desenvolvida e publicada em produção (subdomínio ou domínio raiz de devmorais.com.br), responsiva e rápida, para poder mandar um único link em qualquer abordagem de venda a partir de agora.

Critérios de aceite:
- Implementação mobile-first, testada em pelo menos 2 tamanhos de tela diferentes
- Botão de WhatsApp fixo/flutuante visível em qualquer ponto de rolagem da página
- Tempo de carregamento leve — evitar frameworks pesados desnecessários numa página de uma seção só
- Formulário de contato funcional, entregando a mensagem por e-mail ou redirecionando para WhatsApp
- Publicada com HTTPS e sem erros de console no navegador',
  'Alta',
  'Landing Page',
  6,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 1 — Marca & Landing Page' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como visitante avaliando se contrato ou não a empresa, preciso ver prova real de que os sistemas funcionam — não mockups — por isso a landing page precisa mostrar prints e links de demo reais dos produtos já em produção (Avante, EduCore, ShopX, Votar, AGF, CRC), conforme a lógica de vitrine já descrita em PRIMEIROS-CLIENTES.md item 7.

Critérios de aceite:
- Capturar pelo menos 1 print de tela real (não ilustração) de cada produto em produção
- Linkar demos públicos onde já existirem (ex.: subdomínios demo-*.devmorais.com.br quando estiverem no ar)
- Se ainda não houver depoimento de cliente, usar uma frase de posicionamento no lugar do placeholder (''em breve: veja o que nossos clientes dizem'')
- Garantir que nenhum print exponha dado sensível de cliente real (mascarar nomes/e-mails se necessário)',
  'Média',
  'Landing Page',
  7,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 1 — Marca & Landing Page' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa que vai investir em tráfego pago no futuro, preciso ter analytics e rastreamento de conversão configurados na landing page desde o lançamento, para medir visitas, cliques no botão de WhatsApp e envios do formulário com dados reais — sem isso, a decisão de investir em anúncios (épico Tráfego Pago) fica no achismo.

Critérios de aceite:
- Instalar Google Analytics (ou equivalente) na página
- Instalar o Pixel do Meta (Facebook/Instagram Ads) assim que a conta de anúncios existir
- Configurar eventos de conversão: clique no botão WhatsApp, envio de formulário, clique em cada card de produto
- Validar que os eventos disparam corretamente antes de considerar a tarefa concluída',
  'Média',
  'Landing Page',
  8,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 1 — Marca & Landing Page' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como fundador, preciso revisar a landing page publicada como se fosse um cliente frio vendo pela primeira vez, testando em mobile real e corrigindo qualquer texto genérico, para garantir que a página realmente converte antes de divulgar em massa.

Critérios de aceite:
- Ler a frase-âncora e perguntar: isso convence em 3 segundos?
- Confirmar que o CTA principal aparece sem precisar rolar demais a página (acima da dobra em mobile)
- Testar todos os links (WhatsApp, Instagram, Facebook, formulário, cards de produto) em pelo menos 2 celulares diferentes
- Corrigir qualquer texto que pareça genérico demais (''soluções inovadoras'') por linguagem direta e concreta
- Pedir feedback de 1-2 pessoas de fora do projeto antes de considerar pronta',
  'Média',
  'Landing Page',
  9,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 2 — Redes & Preparação Comercial' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa, preciso criar o perfil comercial do Instagram já usando o nome/marca decidido e a estética preto e branco definida na identidade visual, com biografia focada em tecnologia e IA, foto de perfil e link para a landing page configurados corretamente, para ter um canal de conteúdo e contato direto com potenciais clientes.

Critérios de aceite:
- Nome de usuário alinhado à marca escolhida (Marca & Posicionamento)
- Foto de perfil = logo em preto e branco, alta resolução
- Biografia com a frase-âncora (foco em tecnologia/IA + sistemas) + link para a landing page
- Grid do feed planejado para manter consistência visual preto e branco (fotos/prints tratados em P&B ou alto contraste sempre que possível)
- Conta configurada como perfil comercial/empresa, com categoria e botão de contato (WhatsApp) habilitados
- Criar 3 destaques (Stories em destaque) vazios: ''Produtos'', ''Depoimentos'', ''Bastidores'', prontos para receber conteúdo',
  'Alta',
  'Instagram',
  1,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 2 — Redes & Preparação Comercial' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa, preciso montar um calendário editorial inicial de 2-3 posts por semana ao longo de 4 semanas, cobrindo pilares de conteúdo que reforcem o posicionamento de tecnologia/IA (não só ''fazemos site''), para atrair um público interessado em tech e ao mesmo tempo gerar demanda de venda de sistemas.

Critérios de aceite:
- 1 post por produto (Avante, EduCore, Numen, ShopX, Votar, AGF, CRC) explicando o que ele resolve, com destaque especial pro EduCore como prova de capacidade real em IA
- Pilar de ''curiosidades de tecnologia e IA'' (fatos curtos, tendências, bastidores de como a IA é usada nos produtos) — constrói autoridade e atrai seguidor interessado em tech, não só cliente frio
- Posts de bastidores mostrando código/tela rodando de verdade (constrói confiança e autoridade técnica)
- Ao menos 1 post comparando um diferencial real contra a alternativa gratuita mais óbvia (ex.: Avante vs. Trello free)
- Espaço reservado no calendário para prova social assim que os primeiros depoimentos chegarem (épico Vendas & Primeiros Clientes)
- Todo o conteúdo visual seguindo a estética preto e branco definida na identidade (tratamento de imagem consistente)
- Calendário registrado em planilha ou documento simples, com data e status de cada post (rascunho/gravado/publicado)',
  'Média',
  'Instagram',
  2,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 2 — Redes & Preparação Comercial' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como potencial cliente navegando pelo Instagram, preciso ver os sistemas funcionando de verdade, não só prints estáticos — por isso a empresa precisa gravar e publicar vídeos curtos (Reels de 15-30s) demonstrando cada produto, priorizando os que já têm demo pronta (CRC, ShopX, Avante).

Critérios de aceite:
- Gravar pelo menos 3 vídeos demo (um por produto prioritário) mostrando a tela em uso real, sem edição complexa
- Incluir legenda com o problema que o produto resolve e um CTA (link na bio / WhatsApp)
- Publicar como Reels (maior alcance orgânico) e fixar os melhores no perfil
- Reaproveitar os mesmos vídeos no Facebook (epico Facebook) sem precisar regravar',
  'Alta',
  'Instagram',
  3,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 2 — Redes & Preparação Comercial' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como potencial cliente interessado, preciso conseguir falar com a empresa direto pelo Instagram sem sair do app, para reduzir o atrito entre ver o conteúdo e iniciar uma conversa de venda — por isso o botão de contato e o link de WhatsApp direto precisam estar ativos no perfil.

Critérios de aceite:
- Botão de ''Enviar mensagem'' ou ''WhatsApp'' visível no topo do perfil
- Testar o fluxo completo como se fosse um estranho: do feed até a primeira mensagem enviada
- Garantir que as mensagens recebidas caem num número que é monitorado ativamente (não um WhatsApp esquecido)
- Definir tempo máximo de resposta (ex.: até 2h em horário comercial) como padrão de atendimento',
  'Média',
  'Instagram',
  4,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 2 — Redes & Preparação Comercial' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa, preciso criar a página comercial do Facebook com a mesma marca do Instagram e vinculá-la via Meta Business Suite, para gerenciar as duas redes num só painel e já deixar a base pronta para futuras campanhas pagas (épico Tráfego Pago).

Critérios de aceite:
- Página criada com nome, logo, categoria correta (ex.: ''Empresa de software'' ou ''Agência de marketing digital''), horário de atendimento e WhatsApp/telefone preenchidos
- Vinculação da página ao perfil do Instagram dentro do Meta Business Suite
- Confirmar que é possível publicar/agendar posts para as duas redes a partir do mesmo painel
- Preencher a seção ''Sobre'' da página com a mesma frase-âncora usada na landing page e no Instagram',
  'Alta',
  'Facebook',
  5,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 2 — Redes & Preparação Comercial' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa que pretende rodar tráfego pago, preciso configurar o Gerenciador de Negócios (Business Manager) da Meta com verificação de domínio, conta de anúncios e método de pagamento, pois sem esse setup nenhuma campanha paga pode ser criada — este é um pré-requisito técnico, não opcional.

Critérios de aceite:
- Domínio da landing page verificado no Business Manager
- Conta de anúncios criada e método de pagamento cadastrado
- Pixel do Meta (criado no épico Landing Page) associado corretamente à conta de anúncios
- Acessos de administrador concedidos apenas às pessoas necessárias, revisando permissões',
  'Média',
  'Facebook',
  6,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 2 — Redes & Preparação Comercial' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa buscando alcançar público de PMEs e comércio local (público mais forte no Facebook do que no Instagram), preciso publicar o mesmo conteúdo do calendário editorial na página e participar ativamente de grupos locais/comerciais, seguindo os canais já mapeados em PRIMEIROS-CLIENTES.md item 8.

Critérios de aceite:
- Publicar 1-2x por semana espelhando os posts do Instagram, mantendo a mesma estética preto e branco (reaproveitar mídia, sem duplicar esforço de criação)
- Mapear e entrar em pelo menos 3-5 grupos de comércio/empreendedorismo/bairro relevantes
- Participar ajudando antes de vender, conforme regra já validada no plano anterior de comunidades
- Oferecer o serviço de forma natural quando fizer sentido na conversa do grupo, nunca como spam',
  'Baixa',
  'Facebook',
  7,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 3 — Execução de Vendas & Tráfego' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa que ainda não validou o funil orgânico, preciso definir orçamento, público-alvo e objetivo da primeira campanha de anúncios antes de gastar qualquer valor, para não repetir o erro de tráfego pago sem funil funcionando (regra já registrada em PLANO-MARKETING-AVANTE.md item 4.5).

Critérios de aceite:
- Orçamento inicial pequeno e controlado (ex.: R$10-20/dia por 2 semanas, não mais que isso no teste)
- Objetivo da campanha = mensagens no WhatsApp ou cliques na landing page — nunca ''reconhecimento de marca'' nesta fase
- Público segmentado por localização (cidade/região de atuação) + interesses compatíveis com quem contrata site/sistema (donos de pequeno comércio, autônomos, freelancers)
- Só iniciar esta campanha depois de ter ao menos a landing page e o Instagram funcionando (épicos anteriores)',
  'Baixa',
  'Tráfego Pago',
  1,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 3 — Execução de Vendas & Tráfego' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa rodando a primeira campanha paga, preciso criar ao menos 2-3 variações de criativo (imagem estática vs. vídeo demo, textos com foco diferente) para descobrir o que converte melhor antes de escalar qualquer verba.

Critérios de aceite:
- Pelo menos 2 criativos visuais diferentes (ex.: print do produto vs. vídeo demo já gravado no Instagram)
- Pelo menos 2 textos de anúncio diferentes (ex.: foco em ''site profissional'' vs. foco em ''sistema sob medida'')
- Campanha configurada nas duas redes (Instagram + Facebook) a partir do Business Manager
- Rodar por período mínimo definido na story anterior antes de tirar qualquer conclusão precipitada',
  'Baixa',
  'Tráfego Pago',
  2,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 3 — Execução de Vendas & Tráfego' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa investindo em tráfego pago, preciso acompanhar as métricas da campanha (custo por clique, custo por mensagem/lead) e decidir com dados se continuo, ajusto ou pauso, documentando o aprendizado para não repetir erro de verba mal gasta.

Critérios de aceite:
- Definir ANTES de rodar quais números seriam considerados sucesso (ex.: custo por lead abaixo de X reais)
- Revisar os resultados após a primeira semana completa de veiculação
- Registrar neste board a decisão tomada (continuar/ajustar/pausar) e o motivo
- Se os números não baterem a meta, identificar se o problema é criativo, público ou oferta antes de simplesmente pausar tudo',
  'Baixa',
  'Tráfego Pago',
  3,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 3 — Execução de Vendas & Tráfego' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa buscando alternativas de baixo custo ao tráfego pago, preciso mapear campanhas locais gratuitas ou baratas (grupos de bairro, classificados locais, parcerias de indicação cruzada com outros pequenos negócios) para rodar em paralelo aos anúncios, multiplicando canais sem multiplicar custo.

Critérios de aceite:
- Listar pelo menos 3 grupos/classificados locais relevantes para o público-alvo
- Identificar 2-3 negócios parceiros em potencial para troca de indicação (ex.: contador indica cliente que precisa de site, e vice-versa)
- Definir uma mensagem padrão de divulgação adaptada para cada canal (grupos têm tom diferente de classificados)
- Registrar os resultados de cada canal para saber quais vale manter',
  'Baixa',
  'Tráfego Pago',
  4,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 2 — Redes & Preparação Comercial' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa começando do zero, preciso montar a lista inicial de 30 contatos quentes para abordagem direta, reaproveitando o método já validado em PRIMEIROS-CLIENTES.md item 6, pois o primeiro cliente nunca vem de estranho frio — vem de quem já confia.

Critérios de aceite:
- Preencher por categoria: família e amigos próximos (5), ex-colegas de trabalho/faculdade (5), comércios que frequento (oficina, academia, mercado, salão, farmácia, pet) (8), conhecidos com negócio próprio/MEI (7), grupos/comunidades (igreja, condomínio, WhatsApp, bairro) (5)
- Ao lado de cada nome, anotar o que essa pessoa/negócio provavelmente precisaria (site? loja? sistema?) e o quão quente é o contato (escala 1-3)
- Meta mínima: 30 nomes preenchidos antes de começar a abordar
- Esta lista pode e deve ser montada em paralelo aos épicos de Landing Page/Redes, sem esperar tudo pronto',
  'Alta',
  'Vendas & Primeiros Clientes',
  8,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 2 — Redes & Preparação Comercial' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa vendendo serviço pela primeira vez, preciso definir os 2 pacotes/ofertas de entrada e a tabela de preços oficial, reaproveitando a estrutura já detalhada em PRIMEIROS-CLIENTES.md item 4 (3 níveis por oferta, ancoragem no pacote do meio).

Critérios de aceite:
- Site institucional (base CRC): pacotes Essencial / Profissional (âncora) / Premium com preços e o que inclui cada um
- Loja virtual (base ShopX): pacotes Start / Pro (âncora) / Plus com preços e o que inclui cada um
- Condição padrão de pagamento: 50% de entrada via PIX antes de começar, 50% na entrega
- Desconto de ''cliente fundador'' (-20%) para os 3 primeiros clientes, em troca de depoimento + autorização de uso no portfólio + 1 indicação
- Tabela de manutenção mensal recorrente (Básico/Cuidado/Gestão) definida e pronta para oferecer em toda entrega',
  'Alta',
  'Vendas & Primeiros Clientes',
  9,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 2 — Redes & Preparação Comercial' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa prestes a abordar os 30 contatos, preciso ter os scripts de abordagem e o roteiro da conversa de venda prontos para copiar e colar, adaptando o material já validado em PRIMEIROS-CLIENTES.md itens 9 e 10, para não precisar reinventar a mensagem a cada conversa (e não travar na hora de abordar).

Critérios de aceite:
- Script de rede quente, script de comércio local, script frio-mas-educado e script de follow-up, todos adaptados com o nome/marca definido
- Roteiro de 15 minutos da conversa de venda: conexão (1min) → descoberta (5min, perguntas prontas) → demo (3min) → proposta (3min) → preço com âncora (1min) → fechamento (2min)
- Respostas prontas para as objeções mais comuns (''tá caro'', ''vou pensar'', ''tenho um sobrinho que faz'', etc.), conforme tabela do item 11
- Frase padrão de pedido de indicação para usar ao final de toda conversa, mesmo quando não fecha',
  'Alta',
  'Vendas & Primeiros Clientes',
  10,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 2 — Redes & Preparação Comercial' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa fechando os primeiros contratos, preciso ter um contrato de 1 página pronto e a cobrança via PIX configurada, para evitar mal-entendido de escopo (''achei que tava incluso'') e formalizar o recebimento da entrada de 50%.

Critérios de aceite:
- Documento de 1 página cobrindo: escopo do que será entregue, prazo, valor total, condições de pagamento (50/50), número de rodadas de revisão incluídas e o que NÃO está incluso
- Chave PIX configurada (vinculada ao CNPJ/MEI definido no épico Marca & Posicionamento) pronta para receber
- Processo definido: sem entrada paga, o projeto não começa
- Registro de todo acordo por escrito no WhatsApp como reforço do contrato formal',
  'Média',
  'Vendas & Primeiros Clientes',
  11,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 2 — Redes & Preparação Comercial' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa que vai gerenciar múltiplos leads simultaneamente, preciso criar o pipeline de vendas dentro do próprio Avante e registrar cada contato da lista de 30 como uma tarefa, para não perder nenhum lead e ainda usar o Avante como case real de venda (''a gente usa o próprio produto'').

Critérios de aceite:
- Criar (ou reaproveitar) um quadro/board com status: Contato feito → Conversando → Proposta enviada → Fechado → Em produção → Entregue → Manutenção
- Migrar os 30 nomes da lista para tarefas neste pipeline, cada um com o que precisa e o nível de ''quão quente'' já anotado
- Atualizar o status de cada tarefa conforme a conversa avança, mantendo o pipeline sempre fiel à realidade
- Usar este próprio uso do Avante como argumento de venda/prova social em conversas futuras',
  'Média',
  'Vendas & Primeiros Clientes',
  12,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 3 — Execução de Vendas & Tráfego' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa com a lista, os scripts e o pipeline prontos, preciso efetivamente abordar os 30 contatos e registrar o resultado de cada abordagem, pois é a execução real — não o planejamento — que gera caixa; a matemática esperada (PRIMEIROS-CLIENTES.md item 16) é de ~9 conversas e ~5 propostas a partir dos 30 contatos.

Critérios de aceite:
- Abordar os 30 contatos da lista, usando o script apropriado para cada categoria (rede quente, comércio local, frio educado)
- Fazer follow-up em quem não respondeu em até 3 dias, usando o script de follow-up
- Atualizar o pipeline no Avante a cada resposta recebida (avançar ou descartar o lead)
- Não desanimar com os primeiros ''nãos'' — a meta é abordar os 30, não parar em 5',
  'Alta',
  'Vendas & Primeiros Clientes',
  5,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 3 — Execução de Vendas & Tráfego' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa buscando o primeiro dinheiro na conta, preciso fechar os 3 primeiros clientes e, ao final de cada entrega, coletar depoimento e autorização de uso no portfólio, fechando o ciclo que alimenta de volta a landing page e as redes sociais com prova social real.

Critérios de aceite:
- 3 clientes fechados com entrada de 50% recebida e contrato assinado
- Entrega realizada seguindo o processo (briefing → escopo fechado → etapas com aprovação → entrega final com treinamento de 15min)
- Depoimento (texto, print de conversa ou vídeo curto) coletado e autorizado por escrito para uso público
- Depoimentos publicados na seção de prova social da landing page e em pelo menos 1 post nas redes sociais',
  'Alta',
  'Vendas & Primeiros Clientes',
  6,
  NOW(), NOW()
);

INSERT INTO tasks (board_id, sprint_id, status_id, description, priority, epic, sort_order, created_at, updated_at)
VALUES (
  14,
  (SELECT id FROM sprints WHERE board_id = 14 AND name = 'Sprint 3 — Execução de Vendas & Tráfego' LIMIT 1),
  (SELECT id FROM statuses WHERE board_id = 14 AND name = 'Em Fila' LIMIT 1),
  'Como empresa buscando receita recorrente (não só projetos pontuais), preciso oferecer manutenção mensal em toda entrega fechada, consolidando a base de faturamento previsível que sustenta a empresa entre um projeto novo e outro.

Critérios de aceite:
- Oferecer a tabela de manutenção (Básico R$100 / Cuidado R$250 / Gestão R$500) no momento da entrega final de cada projeto, nunca depois
- Pelo menos 1 dos 3 primeiros clientes fechando algum plano de manutenção
- Incluir custo de hospedagem dentro do plano cobrado, mantendo margem sobre o que é pago à Hostinger
- Registrar cada contrato de manutenção ativo (cliente, plano, valor, data de renovação) para acompanhamento simples de receita mensal',
  'Média',
  'Vendas & Primeiros Clientes',
  7,
  NOW(), NOW()
);

