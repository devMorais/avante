import { Component, Input, OnChanges, SimpleChanges, signal, computed } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api';

type MarketingTab = 'calendar' | 'pipeline' | 'ideas' | 'campaigns' | 'performance';

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

@Component({
  selector: 'app-marketing',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './marketing.html',
  styleUrl: './marketing.scss',
})
export class Marketing implements OnChanges {
  @Input() boardId!: number;

  tab = signal<MarketingTab>('calendar');
  channels = CHANNELS;
  stages = STAGES;
  channelColor(v: string) { return CHANNEL_COLORS[v] || '#6B6B70'; }
  stageInfo(v: string) { return this.stages.find(s => s.value === v) ?? this.stages[0]; }

  loading = signal(true);

  posts = signal<any[]>([]);
  leads = signal<any[]>([]);
  ideas = signal<any[]>([]);
  campaigns = signal<any[]>([]);
  metrics = signal<any[]>([]);

  constructor(private api: ApiService) {}

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['boardId'] && this.boardId) {
      this.loadAll();
    }
  }

  setTab(t: MarketingTab) { this.tab.set(t); }

  private loadAll() {
    this.loading.set(true);
    this.api.getMarketingPosts(this.boardId).subscribe(d => this.posts.set(d));
    this.api.getMarketingLeads(this.boardId).subscribe(d => this.leads.set(d));
    this.api.getMarketingIdeas(this.boardId).subscribe(d => this.ideas.set(d));
    this.api.getMarketingCampaigns(this.boardId).subscribe(d => this.campaigns.set(d));
    this.api.getMarketingMetrics(this.boardId).subscribe(d => { this.metrics.set(d); this.loading.set(false); });
  }

  // ========== Posts / Calendário ==========

  postForm = { title: '', caption: '', channel: 'instagram', scheduled_at: '', status: 'idea' as 'idea' | 'scheduled' | 'published' };
  savingPost = signal(false);
  postFormOpen = signal(false);

  openPostForm() { this.postFormOpen.set(true); }
  closePostForm() {
    this.postFormOpen.set(false);
    this.postForm = { title: '', caption: '', channel: 'instagram', scheduled_at: '', status: 'idea' };
  }

  savePost() {
    if (!this.postForm.title.trim()) return;
    this.savingPost.set(true);
    this.api.createMarketingPost({ board_id: this.boardId, ...this.postForm }).subscribe({
      next: (p) => { this.posts.set([...this.posts(), p]); this.savingPost.set(false); this.closePostForm(); },
      error: () => this.savingPost.set(false),
    });
  }

  setPostStatus(post: any, status: string) {
    this.api.updateMarketingPost(post.id, { status }).subscribe(updated => {
      this.posts.set(this.posts().map(p => p.id === post.id ? updated : p));
    });
  }

  deletePost(id: number) {
    this.api.deleteMarketingPost(id).subscribe(() => this.posts.set(this.posts().filter(p => p.id !== id)));
  }

  postsByStatus(status: string) {
    return this.posts().filter(p => p.status === status)
      .sort((a, b) => (a.scheduled_at ?? '').localeCompare(b.scheduled_at ?? ''));
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
}
