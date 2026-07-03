import { Component, Input, OnChanges, SimpleChanges, signal, computed } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApiService } from '../../services/api';

@Component({
  selector: 'app-analytics',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './analytics.html',
  styleUrl: './analytics.scss',
})
export class Analytics implements OnChanges {
  @Input() boardId!: number;
  @Input() boardName = '';

  loading = signal(true);
  data = signal<any>(null);

  constructor(private api: ApiService) {}

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['boardId'] && this.boardId) this.load();
  }

  load() {
    this.loading.set(true);
    this.api.getBoardAnalytics(this.boardId).subscribe({
      next: (d) => { this.data.set(d); this.loading.set(false); },
      error: () => this.loading.set(false),
    });
  }

  maxCount(items: { count: number }[]): number {
    return Math.max(1, ...items.map(i => i.count));
  }

  pct(value: number, max: number): number {
    return Math.round((value / max) * 100);
  }

  velocityMax = computed(() => {
    const v = this.data()?.velocity ?? [];
    return Math.max(1, ...v.map((s: any) => s.total));
  });

  workloadMax = computed(() => {
    const w = this.data()?.workload ?? [];
    return Math.max(1, ...w.map((u: any) => u.total));
  });

  // -------- Burndown (SVG line chart) --------

  private readonly chartW = 560;
  private readonly chartH = 180;

  burndownMax = computed(() => {
    const b = this.data()?.burndown;
    if (!b?.series?.length) return 1;
    return Math.max(1, ...b.series.map((s: any) => Math.max(s.remaining, s.ideal)));
  });

  burndownPoints(key: 'remaining' | 'ideal'): string {
    const series = this.data()?.burndown?.series ?? [];
    if (series.length < 2) return '';
    const max = this.burndownMax();
    return series.map((s: any, i: number) => {
      const x = (i / (series.length - 1)) * this.chartW;
      const y = this.chartH - (s[key] / max) * this.chartH;
      return `${x.toFixed(1)},${y.toFixed(1)}`;
    }).join(' ');
  }

  get svgViewBox(): string { return `0 0 ${this.chartW} ${this.chartH}`; }

  burndownDateLabel(iso: string): string {
    const d = new Date(iso);
    return d.toLocaleDateString('pt-BR', { day: '2-digit', month: '2-digit' });
  }

  // -------- Exportar --------

  exportCSV() {
    const d = this.data();
    if (!d) return;
    const lines: string[] = [];
    lines.push('Distribuição por Status');
    lines.push('Status,Quantidade');
    d.distribution.by_status.forEach((s: any) => lines.push(`${s.name},${s.count}`));
    lines.push('');
    lines.push('Distribuição por Prioridade');
    lines.push('Prioridade,Quantidade');
    d.distribution.by_priority.forEach((s: any) => lines.push(`${s.name},${s.count}`));
    lines.push('');
    lines.push('Velocidade por Sprint');
    lines.push('Sprint,Concluídas,Total');
    d.velocity.forEach((s: any) => lines.push(`${s.sprint_name},${s.completed},${s.total}`));
    lines.push('');
    lines.push('Carga por Responsável');
    lines.push('Responsável,Abertas,Total');
    d.workload.forEach((w: any) => lines.push(`${w.name},${w.open},${w.total}`));

    const blob = new Blob([lines.join('\n')], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `analytics-${this.boardName || this.boardId}.csv`;
    a.click();
    URL.revokeObjectURL(url);
  }

  exportPDF() {
    const d = this.data();
    if (!d) return;
    const now = new Date().toLocaleString('pt-BR');

    const rowsHtml = (items: { name: string; count: number }[]) =>
      items.map(i => `<tr><td>${i.name}</td><td>${i.count}</td></tr>`).join('');

    const win = window.open('', '_blank', 'width=820,height=700');
    if (!win) return;

    win.document.write(`<!DOCTYPE html>
<html lang="pt-BR"><head><meta charset="UTF-8"><title>Analytics — ${this.boardName}</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: system-ui, sans-serif; font-size: 13px; color: #1C1C1F; padding: 40px; }
h1 { font-size: 20px; margin-bottom: 4px; }
.sub { color: #6B6B70; margin-bottom: 24px; }
h2 { font-size: 13px; text-transform: uppercase; letter-spacing: .04em; color: #6B6B70; margin: 20px 0 8px; }
table { width: 100%; border-collapse: collapse; margin-bottom: 12px; }
td, th { padding: 6px 10px; border-bottom: 1px solid #E8E6E1; text-align: left; }
.stat { display: inline-block; margin-right: 24px; }
.stat b { display: block; font-size: 18px; }
</style></head><body>
<h1>Analytics — ${this.boardName}</h1>
<p class="sub">Exportado em ${now}</p>
<div class="stat"><span>Total de tarefas</span><b>${d.distribution.total}</b></div>
<div class="stat"><span>Cycle time médio</span><b>${d.cycle_time.avg_days ?? '—'} dias</b></div>
<h2>Distribuição por Status</h2>
<table>${rowsHtml(d.distribution.by_status)}</table>
<h2>Distribuição por Prioridade</h2>
<table>${rowsHtml(d.distribution.by_priority)}</table>
<h2>Velocidade por Sprint</h2>
<table><tr><th>Sprint</th><th>Concluídas</th><th>Total</th></tr>${d.velocity.map((s: any) => `<tr><td>${s.sprint_name}</td><td>${s.completed}</td><td>${s.total}</td></tr>`).join('')}</table>
<h2>Carga por Responsável</h2>
<table><tr><th>Responsável</th><th>Abertas</th><th>Total</th></tr>${d.workload.map((w: any) => `<tr><td>${w.name}</td><td>${w.open}</td><td>${w.total}</td></tr>`).join('')}</table>
<script>window.onload = function(){ window.print(); }<\/script>
</body></html>`);
    win.document.close();
  }
}
