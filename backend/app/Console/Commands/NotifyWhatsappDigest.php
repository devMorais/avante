<?php

namespace App\Console\Commands;

use App\Models\Task;
use App\Models\User;
use App\Services\WhatsAppGateway;
use Illuminate\Console\Command;

class NotifyWhatsappDigest extends Command
{
    protected $signature = 'app:notify-whatsapp-digest';

    protected $description = 'Envia por WhatsApp um resumo diário de tarefas pendentes/atrasadas para usuários que optaram por receber avisos';

    public function handle(WhatsAppGateway $gateway): int
    {
        $users = User::where('whatsapp_opt_in', true)
            ->whereNotNull('whatsapp_number')
            ->get();

        if ($users->isEmpty()) {
            $this->info('Nenhum usuário optou por receber avisos via WhatsApp.');
            return self::SUCCESS;
        }

        foreach ($users as $user) {
            $tasks = Task::whereHas('assignees', fn ($q) => $q->where('users.id', $user->id))
                ->with('status', 'sprint')
                ->get();

            $open = $tasks->filter(function ($task) {
                $name = strtolower($task->status?->name ?? '');
                return !in_array($name, ['concluído', 'concluido', 'done', 'finalizado']);
            });

            if ($open->isEmpty()) {
                continue;
            }

            $overdue = $open->filter(function ($task) {
                return $task->sprint
                    && !$task->sprint->finished_at
                    && $task->sprint->end_date
                    && now()->startOfDay()->gt($task->sprint->end_date);
            })->count();

            $message = "Olá {$user->name}! Você tem {$open->count()} demanda(s) em aberto no Avante.";

            if ($overdue > 0) {
                $message .= " {$overdue} delas estão em sprints vencidas — vale reforçar o ritmo por aí! 💪";
            } else {
                $message .= " Continue assim, tudo está sendo acompanhado de perto. 🚀";
            }

            $gateway->send($user->whatsapp_number, $message);
            $this->info("Digest enviado (ou logado) para {$user->name}.");
        }

        return self::SUCCESS;
    }
}
