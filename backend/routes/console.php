<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

// Resumo diário de pendências via WhatsApp (requer WHATSAPP_API_URL configurado
// no .env; sem isso, só loga). Cron do hPanel deve rodar:
// * * * * * php artisan schedule:run
Schedule::command('app:notify-whatsapp-digest')->dailyAt('08:00');
