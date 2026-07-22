import { Component, Input, OnChanges, SimpleChanges, signal, computed } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api';

type MarketingTab = 'pipeline' | 'ideas' | 'campaigns' | 'performance' | 'agenda';

const CHANNELS = [
  { value: 'instagram', label: 'Instagram' },
  { value: 'facebook', label: 'Facebook' },
  { value: 'linkedin', label: 'LinkedIn' },
  { value: 'tiktok', label: 'TikTok' },
  { value: 'whatsapp', label: 'WhatsApp' },
  { value: 'outro', label: 'Outro' },
];

const CHANNEL_COLORS: Record<string, string> = {
  instagram: '#DB2777',
  facebook: '#0284C7',
  linkedin: '#4F46E5',
  tiktok: '#1C1C1F',
  whatsapp: '#059669',
  outro: '#D97706',
};

const STAGES = [
  { value: 'novo', label: 'Novo Lead', color: '#6B6B70' },
  { value: 'contato', label: 'Em Contato', color: '#0284C7' },
  { value: 'proposta', label: 'Proposta', color: '#D97706' },
  { value: 'ganho', label: 'Ganho', color: '#059669' },
  { value: 'perdido', label: 'Perdido', color: '#DC2626' },
];

// ========== Agenda: parsing + heurística de horário ==========

type ConteudoTipo = 'reels' | 'carrossel' | 'story' | 'post';

interface ItemAgenda {
  id: number;
  codigo: string; // ex: "S1-R02"
  titulo: string; // texto curto extraído da description
  tipo: ConteudoTipo;
  statusNome: string;
  statusCor: string;
  sprintNome: string;
  scheduledAt: string | null; // ISO local (datetime-local) já existente na task, se houver
  diaSugerido: string;
  horaSugerida: string; // "HH:mm"
  legenda: string | null; // texto pronto pra colar no post (com hashtags), extraído da description — null quando o tipo não tem (Reels, Story)
}

const TIPO_ROTULO: Record<ConteudoTipo, string> = {
  reels: 'Reels',
  carrossel: 'Carrossel',
  story: 'Story',
  post: 'Post único',
};

// Dia da semana já embutido no título de cada Story (rodízio fixo, não é sugestão nossa).
const DIA_POR_STORY: Record<string, string> = {
  'S3-S01': 'Segunda',
  'S3-S02': 'Terça',
  'S3-S03': 'Quarta',
  'S3-S04': 'Quinta',
  'S3-S05': 'Sexta',
  'S3-S06': 'Sábado',
  'S3-S07': 'Domingo',
};

// Reels: guia da sprint fixa "4/semana" — distribuídos em ter/qui/sáb/dom, alternando
// dentro dos 20 vídeos. Carrosséis e Posts únicos já têm o padrão de dias no próprio
// nome da sprint ("ter/qui" e "ter/dom"). Horários seguem picos conhecidos do Instagram
// Brasil (meio-dia e noite em dias úteis, tarde em fim de semana), com sábado puxado
// pro fim da tarde porque é o único horário com sinal real forte (post de sábado 17h
// teve alcance de 365, ~3x a média dos outros 7 posts).
const DIAS_REELS = ['Terça', 'Quinta', 'Sábado', 'Domingo'];
const DIAS_CARROSSEL = ['Terça', 'Quinta'];
const DIAS_POST = ['Terça', 'Domingo'];

const HORA_POR_DIA: Record<string, string> = {
  Segunda: '19:30',
  Terça: '12:15',
  Quarta: '19:30',
  Quinta: '12:15',
  Sexta: '19:00',
  Sábado: '17:00', // único horário com sinal real forte (alcance 365 no post de sábado 17h)
  Domingo: '18:30',
};

function extrairCodigo(description: string): string | null {
  const m = description.match(/^\[(S[1-4]-[A-Z]\d{2})\]/);
  return m ? m[1] : null;
}

function tipoPorCodigo(codigo: string): ConteudoTipo {
  if (codigo.startsWith('S1-R')) return 'reels';
  if (codigo.startsWith('S2-C')) return 'carrossel';
  if (codigo.startsWith('S3-S')) return 'story';
  return 'post';
}

// O texto após "[CÓDIGO] " segue formato diferente por tipo:
//   Reels:      "Título · Pilar: X"        -> título vem ANTES do ·
//   Carrossel:  "Título" (sem ·)           -> a linha inteira é o título
//   Story/Post: "Story · Título real"      -> título vem DEPOIS do primeiro · (o
//               texto antes do · é só o rótulo genérico do formato, não o tema real)
function extrairTitulo(description: string, codigo: string, tipo: ConteudoTipo): string {
  const semCodigo = description.slice(codigo.length + 2).trim();
  const primeiraLinha = semCodigo.split('\n')[0];
  const partes = primeiraLinha.split('·').map(p => p.trim());

  if (partes.length === 1) return partes[0]; // carrossel, sem separador
  if (tipo === 'story' || tipo === 'post') return partes.slice(1).join(' · ');
  return partes[0]; // reels
}

// Distribui os itens de um tipo pelos dias do rodízio, em ordem — ex: os 20 Reels
// caem em Terça, Quinta, Sábado, Domingo, Terça, Quinta... na ordem do código (R01, R02...).
function diaPorIndice(dias: string[], indice: number): string {
  return dias[indice % dias.length];
}

// Legenda pronta pra colar no post — só existe em Carrossel ("✍️ LEGENDA PRONTA (colar
// no post): "...") e Post único ("Legenda: "..."" dentro do bloco 🎯 CONTEXTO). Reels
// e Story não têm campo de legenda no roteiro (Reels só tem o texto falado no vídeo,
// Stories não usam legenda no Instagram) — retorna null nesses casos.
function extrairLegenda(description: string, tipo: ConteudoTipo): string | null {
  if (tipo === 'carrossel') {
    const m = description.match(/LEGENDA PRONTA[^:]*:\s*\n?\s*["“]([\s\S]*?)["”]/i);
    return m ? m[1].trim() : null;
  }
  if (tipo === 'post') {
    const m = description.match(/\bLegenda:\s*["“]([\s\S]*?)["”]/i);
    return m ? m[1].trim() : null;
  }
  return null;
}

@Component({
  selector: 'app-marketing',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './marketing.html',
  styleUrl: './marketing.scss',
})
export class Marketing implements OnChanges {
  @Input() boardId!: number;
  @Input() activeTab: MarketingTab = 'pipeline';

  channels = CHANNELS;
  stages = STAGES;
  channelColor(v: string) { return CHANNEL_COLORS[v] || '#6B6B70'; }
  stageInfo(v: string) { return this.stages.find(s => s.value === v) ?? this.stages[0]; }

  loading = signal(true);

  leads = signal<any[]>([]);
  ideas = signal<any[]>([]);
  campaigns = signal<any[]>([]);
  metrics = signal<any[]>([]);
  agendaItens = signal<ItemAgenda[]>([]);
  agendaSalvando = signal<Set<number>>(new Set());
  agendaLegendaAberta = signal<number | null>(null);
  agendaLegendaRascunho = '';

  constructor(private api: ApiService) {}

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['boardId'] && this.boardId) {
      this.loadAll();
    }
  }

  private loadAll() {
    this.loading.set(true);
    this.loadAgenda();
    this.api.getMarketingLeads(this.boardId).subscribe(d => this.leads.set(d));
    this.api.getMarketingIdeas(this.boardId).subscribe(d => this.ideas.set(d));
    this.api.getMarketingCampaigns(this.boardId).subscribe(d => this.campaigns.set(d));
    this.api.getMarketingMetrics(this.boardId).subscribe(d => { this.metrics.set(d); this.loading.set(false); });
  }

  // ========== Leads / Pipeline ==========

  leadForm = { name: '', contact: '', value: null as number | null, notes: '' };
  savingLead = signal(false);
  leadFormOpen = signal(false);

  openLeadForm() { this.leadFormOpen.set(true); }
  closeLeadForm() {
    this.leadFormOpen.set(false);
    this.leadForm = { name: '', contact: '', value: null, notes: '' };
  }

  saveLead() {
    if (!this.leadForm.name.trim()) return;
    this.savingLead.set(true);
    this.api.createMarketingLead({ board_id: this.boardId, stage: 'novo', ...this.leadForm }).subscribe({
      next: (l) => { this.leads.set([...this.leads(), l]); this.savingLead.set(false); this.closeLeadForm(); },
      error: () => this.savingLead.set(false),
    });
  }

  setLeadStage(lead: any, stage: string) {
    this.api.updateMarketingLead(lead.id, { stage }).subscribe(updated => {
      this.leads.set(this.leads().map(l => l.id === lead.id ? updated : l));
    });
  }

  deleteLead(id: number) {
    this.api.deleteMarketingLead(id).subscribe(() => this.leads.set(this.leads().filter(l => l.id !== id)));
  }

  leadsByStage(stage: string) {
    return this.leads().filter(l => l.stage === stage);
  }

  pipelineValue = computed(() => {
    return this.leads()
      .filter(l => l.stage !== 'perdido')
      .reduce((sum, l) => sum + (Number(l.value) || 0), 0);
  });

  // ========== Ideias ==========

  ideaForm = { title: '', description: '', tags: '' };
  savingIdea = signal(false);
  ideaFormOpen = signal(false);

  openIdeaForm() { this.ideaFormOpen.set(true); }
  closeIdeaForm() {
    this.ideaFormOpen.set(false);
    this.ideaForm = { title: '', description: '', tags: '' };
  }

  saveIdea() {
    if (!this.ideaForm.title.trim()) return;
    this.savingIdea.set(true);
    this.api.createMarketingIdea({ board_id: this.boardId, ...this.ideaForm }).subscribe({
      next: (i) => { this.ideas.set([i, ...this.ideas()]); this.savingIdea.set(false); this.closeIdeaForm(); },
      error: () => this.savingIdea.set(false),
    });
  }

  upvoteIdea(idea: any) {
    this.api.upvoteMarketingIdea(idea.id).subscribe(updated => {
      this.ideas.set(this.ideas().map(i => i.id === idea.id ? updated : i)
        .sort((a, b) => b.votes - a.votes));
    });
  }

  deleteIdea(id: number) {
    this.api.deleteMarketingIdea(id).subscribe(() => this.ideas.set(this.ideas().filter(i => i.id !== id)));
  }

  ideaTagList(tags: string | null): string[] {
    return (tags ?? '').split(',').map(t => t.trim()).filter(Boolean);
  }

  // ========== Campanhas ==========

  campaignForm = { name: '', channels: '', budget: null as number | null, start_date: '', end_date: '', goal: '', status: 'planejada' as 'planejada' | 'ativa' | 'concluida' };
  savingCampaign = signal(false);
  campaignFormOpen = signal(false);

  openCampaignForm() { this.campaignFormOpen.set(true); }
  closeCampaignForm() {
    this.campaignFormOpen.set(false);
    this.campaignForm = { name: '', channels: '', budget: null, start_date: '', end_date: '', goal: '', status: 'planejada' };
  }

  saveCampaign() {
    if (!this.campaignForm.name.trim()) return;
    this.savingCampaign.set(true);
    this.api.createMarketingCampaign({ board_id: this.boardId, ...this.campaignForm }).subscribe({
      next: (c) => { this.campaigns.set([c, ...this.campaigns()]); this.savingCampaign.set(false); this.closeCampaignForm(); },
      error: () => this.savingCampaign.set(false),
    });
  }

  setCampaignStatus(campaign: any, status: string) {
    this.api.updateMarketingCampaign(campaign.id, { status }).subscribe(updated => {
      this.campaigns.set(this.campaigns().map(c => c.id === campaign.id ? updated : c));
    });
  }

  deleteCampaign(id: number) {
    this.api.deleteMarketingCampaign(id).subscribe(() => this.campaigns.set(this.campaigns().filter(c => c.id !== id)));
  }

  // ========== Desempenho / Métricas ==========

  metricForm = { channel: 'instagram', period_date: '', reach: null as number | null, engagement: null as number | null, conversions: null as number | null };
  savingMetric = signal(false);
  metricFormOpen = signal(false);

  openMetricForm() { this.metricFormOpen.set(true); }
  closeMetricForm() {
    this.metricFormOpen.set(false);
    this.metricForm = { channel: 'instagram', period_date: '', reach: null, engagement: null, conversions: null };
  }

  saveMetric() {
    if (!this.metricForm.period_date) return;
    this.savingMetric.set(true);
    this.api.createMarketingMetric({ board_id: this.boardId, ...this.metricForm }).subscribe({
      next: (m) => { this.metrics.set([m, ...this.metrics()]); this.savingMetric.set(false); this.closeMetricForm(); },
      error: () => this.savingMetric.set(false),
    });
  }

  deleteMetric(id: number) {
    this.api.deleteMarketingMetric(id).subscribe(() => this.metrics.set(this.metrics().filter(m => m.id !== id)));
  }

  // Agregado por canal para o gráfico de barras (soma de reach por canal, últimas entradas)
  metricsByChannel = computed(() => {
    const byChannel = new Map<string, { reach: number; engagement: number; conversions: number }>();
    for (const m of this.metrics()) {
      const cur = byChannel.get(m.channel) ?? { reach: 0, engagement: 0, conversions: 0 };
      cur.reach += Number(m.reach) || 0;
      cur.engagement += Number(m.engagement) || 0;
      cur.conversions += Number(m.conversions) || 0;
      byChannel.set(m.channel, cur);
    }
    return Array.from(byChannel.entries()).map(([channel, v]) => ({ channel, ...v }));
  });

  maxReach = computed(() => Math.max(1, ...this.metricsByChannel().map(m => m.reach)));

  barWidthPct(value: number): number {
    return Math.round((value / this.maxReach()) * 100);
  }

  // ========== Agenda ==========

  tipoRotulo = TIPO_ROTULO;
  agendaTipos: ConteudoTipo[] = ['reels', 'carrossel', 'story', 'post'];

  private loadAgenda() {
    this.api.getTasks(this.boardId, { area: 'marketing' }).subscribe({
      next: (tasks: any[]) => this.agendaItens.set(this.montarAgenda(tasks)),
      error: () => this.agendaItens.set([]),
    });
  }

  private montarAgenda(tasks: any[]): ItemAgenda[] {
    // contadores por tipo para distribuir cada item pelo rodízio de dias na ordem certa
    const indicePorTipo: Record<ConteudoTipo, number> = { reels: 0, carrossel: 0, story: 0, post: 0 };

    const itens: ItemAgenda[] = [];
    for (const t of tasks) {
      const codigo = extrairCodigo(t.description ?? '');
      if (!codigo) continue; // ignora tarefas de marketing que não são peças de conteúdo (ex: guias, planos gerais)

      const tipo = tipoPorCodigo(codigo);
      const indice = indicePorTipo[tipo]++;

      let dia: string;
      if (tipo === 'story') {
        dia = DIA_POR_STORY[codigo] ?? 'Segunda';
      } else if (tipo === 'reels') {
        dia = diaPorIndice(DIAS_REELS, indice);
      } else if (tipo === 'carrossel') {
        dia = diaPorIndice(DIAS_CARROSSEL, indice);
      } else {
        dia = diaPorIndice(DIAS_POST, indice);
      }

      itens.push({
        id: t.id,
        codigo,
        titulo: extrairTitulo(t.description ?? '', codigo, tipo),
        tipo,
        statusNome: t.status?.name ?? '—',
        statusCor: t.status?.color ?? '#6B6B70',
        sprintNome: t.sprint?.name ?? '—',
        scheduledAt: t.scheduled_at ?? null,
        diaSugerido: dia,
        horaSugerida: HORA_POR_DIA[dia] ?? '19:00',
        legenda: extrairLegenda(t.description ?? '', tipo),
      });
    }

    // ordena pelo código (S1-R01, S1-R02... S2-C01...) pra ficar previsível na tela
    return itens.sort((a, b) => a.codigo.localeCompare(b.codigo));
  }

  agendaPorTipo(tipo: ConteudoTipo) {
    return this.agendaItens().filter(i => i.tipo === tipo);
  }

  // Converte "Terça" + "12:15" numa data real (próxima ocorrência daquele dia da
  // semana a partir de hoje) no formato que <input type="datetime-local"> aceita.
  private proximaDataParaSugestao(diaSemana: string, hora: string): string {
    const DIAS = ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'];
    const alvo = DIAS.indexOf(diaSemana);
    const [h, m] = hora.split(':').map(Number);

    const hoje = new Date();
    let diff = (alvo - hoje.getDay() + 7) % 7;
    // se cair hoje mas o horário já passou, joga pra semana que vem
    if (diff === 0 && (hoje.getHours() > h || (hoje.getHours() === h && hoje.getMinutes() >= m))) {
      diff = 7;
    }
    const data = new Date(hoje);
    data.setDate(hoje.getDate() + diff);
    data.setHours(h, m, 0, 0);

    const pad = (n: number) => String(n).padStart(2, '0');
    return `${data.getFullYear()}-${pad(data.getMonth() + 1)}-${pad(data.getDate())}T${pad(data.getHours())}:${pad(data.getMinutes())}`;
  }

  sugestaoComoDatetimeLocal(item: ItemAgenda): string {
    return this.proximaDataParaSugestao(item.diaSugerido, item.horaSugerida);
  }

  // valor pronto pro [value] do <input type="datetime-local"> — o agendamento real
  // se existir, senão a sugestão calculada
  agendaValorCampo(item: ItemAgenda): string {
    if (item.scheduledAt) {
      return item.scheduledAt.slice(0, 16); // "2026-07-28T19:00:00.000000Z" -> "2026-07-28T19:00"
    }
    return this.sugestaoComoDatetimeLocal(item);
  }

  aplicarSugestao(item: ItemAgenda) {
    this.salvarAgendamento(item, this.sugestaoComoDatetimeLocal(item));
  }

  onAgendaDataChange(item: ItemAgenda, valor: string) {
    if (!valor) return;
    this.salvarAgendamento(item, valor);
  }

  private salvarAgendamento(item: ItemAgenda, valorLocal: string) {
    const emAndamento = new Set(this.agendaSalvando());
    emAndamento.add(item.id);
    this.agendaSalvando.set(emAndamento);

    this.api.updateTask(item.id, { scheduled_at: valorLocal }).subscribe({
      next: (updated) => {
        this.agendaItens.set(this.agendaItens().map(i =>
          i.id === item.id ? { ...i, scheduledAt: updated.scheduled_at } : i,
        ));
        const novo = new Set(this.agendaSalvando());
        novo.delete(item.id);
        this.agendaSalvando.set(novo);
      },
      error: () => {
        const novo = new Set(this.agendaSalvando());
        novo.delete(item.id);
        this.agendaSalvando.set(novo);
      },
    });
  }

  aplicarSugestaoEmMassa(tipo: ConteudoTipo) {
    const itens = this.agendaPorTipo(tipo).filter(i => !i.scheduledAt);
    if (!itens.length) return;

    const emAndamento = new Set(this.agendaSalvando());
    for (const i of itens) emAndamento.add(i.id);
    this.agendaSalvando.set(emAndamento);

    // scheduled_at por item é diferente (dias/horas distintos), então bulk-update de
    // um valor único não serve aqui — dispara um update por item, mas em paralelo.
    for (const item of itens) {
      const valor = this.sugestaoComoDatetimeLocal(item);
      this.api.updateTask(item.id, { scheduled_at: valor }).subscribe({
        next: (updated) => {
          this.agendaItens.set(this.agendaItens().map(i =>
            i.id === item.id ? { ...i, scheduledAt: updated.scheduled_at } : i,
          ));
          const novo = new Set(this.agendaSalvando());
          novo.delete(item.id);
          this.agendaSalvando.set(novo);
        },
        error: () => {
          const novo = new Set(this.agendaSalvando());
          novo.delete(item.id);
          this.agendaSalvando.set(novo);
        },
      });
    }
  }

  // Legenda: exibida/editável só em memória (não grava de volta na description do
  // card no Avante — evita regex de escrita mexendo no texto fonte do roteiro).
  toggleLegenda(item: ItemAgenda) {
    if (this.agendaLegendaAberta() === item.id) {
      this.agendaLegendaAberta.set(null);
      return;
    }
    this.agendaLegendaAberta.set(item.id);
    this.agendaLegendaRascunho = item.legenda ?? '';
  }

  salvarLegendaLocal(item: ItemAgenda) {
    this.agendaItens.set(this.agendaItens().map(i =>
      i.id === item.id ? { ...i, legenda: this.agendaLegendaRascunho } : i,
    ));
    this.agendaLegendaAberta.set(null);
  }

  copiarLegenda(legenda: string) {
    navigator.clipboard?.writeText(legenda);
  }
}
