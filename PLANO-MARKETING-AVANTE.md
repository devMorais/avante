# 📣 Plano de Marketing — Avante (vender assinaturas)

> Objetivo único: gerar **assinantes pagantes recorrentes** (MRR) para o Avante.
> Baseado na pesquisa de mercado de 30/06/2026: posicionamento nichado, não "mais um Trello".
> Fundador: Fernando Morais · Última atualização: 30/06/2026.

---

## 1. Por que NÃO competir de frente (resumo da pesquisa)

Trello, Jira, Asana, Monday e ClickUp dominam o mercado de gestão de tarefas, com free tier forte e marca estabelecida. Vender "quadro Kanban com sprint e status" sozinho, contra Trello grátis, não converte ninguém — é a mesma armadilha de commodity que vimos no EduCore.

**O Avante só faz sentido comercial nichado.** O nicho escolhido: **freelancers e pequenas agências de serviço no Brasil** (mesmo público do `PRIMEIROS-CLIENTES.md` — quem vende site, sistema, design, consultoria por projeto).

---

## 2. Diferencial real (o que Trello/Jira free não entregam pra esse nicho)

| Diferencial do Avante | Dor do freelancer/agência BR | Trello/Jira resolvem? |
|---|---|---|
| **Caderno de notas ricas por tarefa** (texto + até 5 imagens) | Guardar print de bug, referência visual, anotação de reunião junto da tarefa | Parcial, mais burocrático |
| **Timer de execução automático por tarefa** | Saber quanto tempo gastou em cada entrega pra cobrar certo | Não, é add-on pago em quase todos |
| **Export PDF da tarefa** (descrição + notas + imagens) | Prestar contas pro cliente ("veja o que foi feito") | Não nativo |
| **Preço em reais, PIX, sem cartão internacional** | Cartão em dólar trava recorrência pra autônomo/MEI brasileiro | Não — cobrança em USD |
| **Importação JSON em massa** | Migrar backlog de outra ferramenta ou planilha de uma vez | Raro, geralmente pago |

**Mensagem-âncora:** "Gestão de tarefas pensada pra quem vende projeto, não pra time de 50 pessoas. Em reais, com PIX, com caderno de notas e timer pra você cobrar certo do seu cliente."

---

## 3. Quem compra (segmentação)

| Segmento | Dor específica | Onde está | Prioridade |
|---|---|---|---|
| **Freelancer de tecnologia/design** (dev, designer, social media) | Perde controle de prazo/tempo entre vários clientes | Comunidades de freelancers, Instagram, grupos de WhatsApp | 🥇 1º foco |
| **Pequena agência/squad (2-10 pessoas)** | Precisa de board simples sem a complexidade do Jira | Indicação, LinkedIn | 🥈 2º foco |
| **Prestador de serviço não-tech** (consultor, contador, advogado autônomo) | Quer organizar entregas por cliente sem aprender ferramenta complexa | Grupos locais, indicação | 🥉 3º foco |

**Vantagem que você já tem:** o `PRIMEIROS-CLIENTES.md` já usa o Avante como pipeline de vendas da fábrica de software. Cada cliente atendido pela fábrica (sites, lojas, sistemas) já te vê usando o Avante na prática — é prova social embutida, sem custo extra.

---

## 4. Canais e o que fazer (90 dias)

### 4.1 Prova social embutida (motor de menor esforço — já está rodando)
- Toda entrega de projeto da fábrica (Votar, AGF, ShopX, sites) usa o Avante como ferramenta de gestão visível ao cliente.
- No fechamento de cada projeto: "Ah, e essa organização toda que você viu eu fazendo? É um sistema meu, o Avante — quer usar pro seu negócio também?"

### 4.2 Comunidades de freelancers (custo zero)
- Grupos de WhatsApp/Telegram/Discord de freelancers de tecnologia e design, comunidades de devs BR, fóruns de freelancer (Workana, 99Freelas — não vender lá dentro, mas identificar onde se reúnem fora da plataforma).
- Entrar ajudando, oferecer teste grátis quando fizer sentido.

### 4.3 Conteúdo orgânico (Instagram/LinkedIn)
- Posts mostrando o Caderno + Timer em uso real ("como cobro certo do cliente sabendo quanto tempo gastei").
- Comparação direta: "Trello não tem isso de graça, o Avante tem."
- Frequência mínima: 2-3 posts/semana.

### 4.4 Indicação (alavanca natural)
- Mesma lógica do `PRIMEIROS-CLIENTES.md`: cada cliente fechado pede indicação. Avante entra como oferta adicional na conversa de manutenção mensal.

### 4.5 Tráfego pago (só depois de validar conversão orgânica)
- Não ligar antes de ter 10-15 assinantes orgânicos confirmando que o funil converte.

---

## 5. Funil

```
Alcance (clientes da fábrica, comunidades, conteúdo, indicação)
   ↓
Cadastro (Free: 1 quadro, 2 usuários)
   ↓
Ativação — cria quadro + usa Caderno/Timer em pelo menos 1 tarefa
   ↓
Conversão — vira assinante Time (R$ 29) ou Empresa (R$ 99)
   ↓
Retenção — segue pagando mês 2, 3, 4...
   ↓
Indicação — traz outro assinante
```

**Métrica crítica:** Cadastro → Ativação. Se a pessoa cria conta e nunca usa o Caderno/Timer (o diferencial real), ela não vai ver motivo pra pagar — vai comparar com Trello grátis e ficar lá.

---

## 6. Pré-requisitos técnicos antes de vender (gap real, não estimado)

O Avante hoje é **single-tenant** (mapeamento do `PLANO-NEGOCIO.md`, item 6.1) — não tem cobrança nem planos implementados, diferente do EduCore que já tem o `MULTITENANT-BILLING.md` mapeado tecnicamente.

- [ ] Multi-tenancy (isolar dados por conta/empresa)
- [ ] Billing recorrente (reaproveitar Asaas, mesmo gateway do plano EduCore)
- [ ] Cadastro self-service + página `/precos`
- [ ] Enforcement dos limites do Free (1 quadro, 2 usuários) hoje não existe enforcement, é só tabela de preço no papel

> **Não faz sentido fazer marketing de aquisição de assinantes do Avante antes disso existir** — mesma regra do EduCore: tráfego sem checkout funcionando é dinheiro/tempo perdido.

---

## 7. Calendário de execução (90 dias)

**Mês 1 — Fundação (paralelo à implementação de multi-tenancy/billing)**
- [ ] Confirmar diferencial nichado (Caderno + Timer + PIX) testando contra Trello free, lado a lado
- [ ] Escrever mensagem-âncora e página `/precos` com foco em freelancer/agência BR
- [ ] Criar perfil Instagram/LinkedIn do Avante
- [ ] Entrar em 5-8 comunidades de freelancers

**Mês 2 — Beta com clientes da fábrica**
- [ ] Oferecer Avante grátis (trial estendido) para os clientes ativos da fábrica de software
- [ ] Coletar 3-5 depoimentos reais de quem usa o Caderno/Timer no dia a dia
- [ ] Publicar conteúdo mostrando esses casos reais
- [ ] Multi-tenancy + billing no ar (alinhado ao roteiro técnico)

**Mês 3 — Tração paga**
- [ ] Validar conversão orgânica (cadastro → ativação → pago)
- [ ] Programa de indicação ativo
- [ ] Meta: 15-25 assinantes pagos

---

## 8. O que NÃO fazer

- ❌ Vender "gestão de tarefas com Kanban" como diferencial isolado — é commodity grátis (Trello).
- ❌ Tentar competir em features genéricas com Jira/Asana/Monday — eles ganham em recursos, não em nicho.
- ❌ Fazer aquisição paga antes de multi-tenancy + billing existir.
- ❌ Ignorar a prova social gratuita que já existe (clientes da fábrica vendo o Avante em uso).
- ❌ Falar pra empresa grande/corporativa — o nicho certo é freelancer e pequena agência, não squad de 50 pessoas (aí sim Jira ganha disparado).

---

## 9. Indicadores a acompanhar

| Métrica | Meta mês 3 |
|---|---|
| Cadastros novos | 60+ |
| Taxa de ativação (usa Caderno ou Timer pelo menos 1x) | > 35% |
| Taxa de conversão Free → Pago | > 10% |
| MRR | R$ 500-1.000 |
| Churn mensal | < 8% |

---

## 10. Como isso entra no Avante (produção)

Use o quadro **"Marketing Avante"** com os épicos abaixo (ver `marketing-avante-tasks.json` no mesmo diretório, pronto pro importador JSON em massa):

- Validação & Diferencial
- Conteúdo & Prova Social
- Comunidades & Indicação
- Billing & Multi-tenancy (pré-requisito técnico)
- Métricas & Indicadores
