<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

/**
 * Serviço plugável de envio de WhatsApp.
 *
 * Feito para o formato de payload comum a gateways brasileiros sem
 * verificação de empresa (Z-API, UltraMsg): POST { phone, message } com
 * um token na URL ou header. Configure via .env:
 *   WHATSAPP_API_URL=https://api.seuprovedor.com/instance/.../send-text
 *   WHATSAPP_API_TOKEN=seu-token
 *
 * Sem essas variáveis configuradas, apenas loga a mensagem (não quebra nada
 * nem falha silenciosamente sem deixar rastro) — pronto para plugar um
 * provedor real quando disponível.
 */
class WhatsAppGateway
{
    public function send(string $phone, string $message): bool
    {
        $url = config('services.whatsapp.url');
        $token = config('services.whatsapp.token');

        $phone = preg_replace('/\D/', '', $phone);

        if (!$url || !$phone) {
            Log::info('[WhatsAppGateway] Envio ignorado (não configurado ou sem telefone).', [
                'phone' => $phone,
                'message' => $message,
            ]);
            return false;
        }

        try {
            $response = Http::withHeaders($token ? ['Client-Token' => $token] : [])
                ->timeout(10)
                ->post($url, [
                    'phone' => $phone,
                    'message' => $message,
                ]);

            if (!$response->successful()) {
                Log::warning('[WhatsAppGateway] Falha ao enviar mensagem.', [
                    'phone' => $phone,
                    'status' => $response->status(),
                    'body' => $response->body(),
                ]);
                return false;
            }

            return true;
        } catch (\Throwable $e) {
            Log::error('[WhatsAppGateway] Erro ao enviar mensagem: ' . $e->getMessage());
            return false;
        }
    }
}
