<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\User;
use App\Models\Task;

/**
 * InglesSeeder
 *
 * O que faz:
 *  1. Limpa tarefas, sprints e statuses do quadro "Inglês" (sem apagar usuários nem o quadro)
 *  2. Cria os 4 status do plano
 *  3. Cria os 4 sprints semanais
 *  4. Para cada tarefa do JSON: cria UMA para Claudia e UMA para Fernando
 *
 * Como rodar (uma única vez):
 *   php artisan db:seed --class=InglesSeeder
 *
 * Ou via rota protegida (ver routes/api.php abaixo).
 */
class InglesSeeder extends Seeder
{
    // ── Altere aqui se os IDs mudarem ──────────────────────────────────────
    private int $boardId = 3; // ID do quadro "Inglês"

    // Emails dos usuários (para buscar os IDs dinamicamente)
    private string $emailClaudia  = 'claudia59331166@edu.df.senac.br';
    private string $emailFernando = 'fernando33201976@edu.df.senac.br';
    // ───────────────────────────────────────────────────────────────────────

    public function run(): void
    {
        // ── 1. Busca os usuários ────────────────────────────────────────────
        $claudia  = User::where('email', $this->emailClaudia)->firstOrFail();
        $fernando = User::where('email', $this->emailFernando)->firstOrFail();

        // ── 2. Limpa dados anteriores do quadro (sem apagar board/users) ───
        $taskIds = Task::where('board_id', $this->boardId)->withTrashed()->pluck('id');
        DB::table('task_user')->whereIn('task_id', $taskIds)->delete();
        Task::where('board_id', $this->boardId)->withTrashed()->forceDelete();
        DB::table('sprints')->where('board_id', $this->boardId)->delete();
        DB::table('statuses')->where('board_id', $this->boardId)->delete();

        // ── 3. Cria os Status ───────────────────────────────────────────────
        $statusMap = [];
        $statusDefs = [
            ['name' => 'Backlog',       'color' => '#6B6B70', 'order' => 1],
            ['name' => 'Em andamento',  'color' => '#0284C7', 'order' => 2],
            ['name' => 'Para revisar',  'color' => '#EA580C', 'order' => 3],
            ['name' => 'Concluído',     'color' => '#059669', 'order' => 4],
        ];
        foreach ($statusDefs as $def) {
            $id = DB::table('statuses')->insertGetId([
                'board_id'   => $this->boardId,
                'name'       => $def['name'],
                'color'      => $def['color'],
                'order'      => $def['order'],
                'created_at' => now(),
                'updated_at' => now(),
            ]);
            $statusMap[$def['name']] = $id;
        }

        // ── 4. Definição das Sprints e Tarefas ──────────────────────────────
        $sprints = [

            // ════════════════════════════════════════════════════════════════
            // SPRINT 01 — 01/07 a 07/07/2026
            // ════════════════════════════════════════════════════════════════
            [
                'name'       => 'Sprint 01',
                'start_date' => '2026-07-01',
                'end_date'   => '2026-07-07',
                'tarefas'    => [
                    ['📵 Ritual de foco: celular fora da sala de estudo', 'Antes de cada sessão de inglês, deixem o celular em outro cômodo ou no modo avião. É fácil se distrair durante o listening — o foco total faz toda diferença na absorção do idioma.', 'Backlog', 'Alta'],
                    ['🧘 Pausa ativa a cada 50 minutos de estudo', 'Alonguem pescoço, ombros e pulsos. Bebam água e descansem a vista olhando para longe. Isso evita fadiga mental, especialmente em aulas mais longas como os podcasts.', 'Backlog', 'Média'],
                    ['🇬🇧 1. English Class - Welcome', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 21min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 2. English Alphabet', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 15min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 3. Verb to Be', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 27min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 4. Personal Pronouns and Possessive Pronouns', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 6min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 5. Sentence Structure', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 6min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 6. Greetings and Introductions', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 15min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 7. Numbers', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 14min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 8. Colors', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 7min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 9. Days, Months, Years', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 13min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 10. Time Exercise', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 3min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 11. Time FlashCards', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 2min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 Teste 1: TESTE I', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 Teste 2: TESTE II', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 Teste 3: TESTE III', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 12. Articles', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 11min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 13. Positions of Place', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 6min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 14. Basic Questions with Wh', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 7min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 15. Vocabulary Family', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 20min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 16. Vocabulary words', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 4min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 17. Vocabulary Places', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 8min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 18. Time Exercise explain', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 2min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 19. Time Exercise', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 3min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 20. Time Mind Map', "Curso Udemy — login: cursodjango@devmorais.com.br. Duração: 3min. Depois de assistir, recriem o mapa mental num papel à mão — isso fixa muito mais que só ler.", 'Backlog', 'Média'],
                    ['🇬🇧 Teste 4: TESTE I', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 Teste 5: TESTE II', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 21. Introduction to Past Simple Tense', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 21min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 22. Forms in the Past', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 7min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 23. Time Expressions in the Past', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 6min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 24. Vocabulary Hobbies Activities', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 3min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 25. Time Exercise', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 3min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 26. Time FlashCards', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 1min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 Teste 6: TESTE I', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 Teste 7: TESTE II', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 Teste 8: TESTE III', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                ],
            ],

            // ════════════════════════════════════════════════════════════════
            // SPRINT 02 — 08/07 a 14/07/2026
            // ════════════════════════════════════════════════════════════════
            [
                'name'       => 'Sprint 02',
                'start_date' => '2026-07-08',
                'end_date'   => '2026-07-14',
                'tarefas'    => [
                    ['📵 Ritual de foco: celular fora da sala de estudo', 'Antes de cada sessão de inglês, deixem o celular em outro cômodo ou no modo avião. É fácil se distrair durante o listening — o foco total faz toda diferença na absorção do idioma.', 'Backlog', 'Alta'],
                    ['🧘 Pausa ativa a cada 50 minutos de estudo', 'Alonguem pescoço, ombros e pulsos. Bebam água e descansem a vista olhando para longe. Isso evita fadiga mental, especialmente em aulas mais longas como os podcasts.', 'Backlog', 'Média'],
                    ['🇬🇧 27. Introduction to Present Continuous', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 14min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 28. Frequency Adverbs', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 5min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 29. Vocabulary Parts of Body I', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 7min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 30. Vocabulary Transportation', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 7min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 31. Time Exercise', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 3min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 32. Time Mind Map', "Curso Udemy — login: cursodjango@devmorais.com.br. Duração: 3min. Depois de assistir, recriem o mapa mental num papel à mão — isso fixa muito mais que só ler.", 'Backlog', 'Média'],
                    ['🇬🇧 33. Podcast Review Fundamentals of English (A1-A2 Level)', "Curso Udemy — login: cursodjango@devmorais.com.br. Duração: 5min. Ouçam sem legenda primeiro, depois com legenda para conferir o que entenderam.", 'Backlog', 'Média'],
                    ['🇬🇧 Teste 9: TESTE I', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 Teste 10: TESTE II', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 Teste 11: TESTE III', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 34. Introduction Future Simple Tense', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 4min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 35. Modal Verbs', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 7min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 36. Reflexive Pronouns', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 4min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 37. Vocabulary Travel Shopping Health', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 14min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 38. Time Exercise Explain', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 1min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 39. Time Exercise', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 3min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 40. Time Exercise', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 3min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 Teste 12: TESTE I', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 Teste 13: TESTE II', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 41. Introduction Present Perfect Tense', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 7min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 42. Verb Tense Table', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 6min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 43. Have Been and Have Done', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 4min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 44. Comparative and Superlatives', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 8min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 45. Vocabulary Opinions and Experience & Parts of Body II', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 9min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 46. Time Exercise', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 3min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 47. Time MindMap', "Curso Udemy — login: cursodjango@devmorais.com.br. Duração: 3min. Depois de assistir, recriem o mapa mental num papel à mão — isso fixa muito mais que só ler.", 'Backlog', 'Média'],
                    ['🇬🇧 Teste 14: TESTE I', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 Teste 15: TESTE II', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                ],
            ],

            // ════════════════════════════════════════════════════════════════
            // SPRINT 03 — 15/07 a 21/07/2026
            // ════════════════════════════════════════════════════════════════
            [
                'name'       => 'Sprint 03',
                'start_date' => '2026-07-15',
                'end_date'   => '2026-07-21',
                'tarefas'    => [
                    ['📵 Ritual de foco: celular fora da sala de estudo', 'Antes de cada sessão de inglês, deixem o celular em outro cômodo ou no modo avião. É fácil se distrair durante o listening — o foco total faz toda diferença na absorção do idioma.', 'Backlog', 'Alta'],
                    ['🧘 Pausa ativa a cada 50 minutos de estudo', 'Alonguem pescoço, ombros e pulsos. Bebam água e descansem a vista olhando para longe. Isso evita fadiga mental, especialmente em aulas mais longas como os podcasts.', 'Backlog', 'Média'],
                    ['🇬🇧 48. Adjectives and Adverbs', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 9min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 49. Conditional Sentences', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 6min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 50. Passive Voice', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 4min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 51. Vocabulary for Debates and Arguments', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 3min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 52. Time Exercise', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 3min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 53. Time Flash Card', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 1min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 Teste 16: TESTE I', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 Teste 17: TESTE II', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 54. Introduction to Indirect Speech', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 8min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 55. Subordinate Clauses', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 5min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 56. Vocabulary for Academic Texts', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 8min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 57. Time Exercise', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 3min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 58. Time Mind Map', "Curso Udemy — login: cursodjango@devmorais.com.br. Duração: 3min. Depois de assistir, recriem o mapa mental num papel à mão — isso fixa muito mais que só ler.", 'Backlog', 'Média'],
                    ['🇬🇧 59. Podcast Review about Mastering in English (B1-B2 Level)', "Curso Udemy — login: cursodjango@devmorais.com.br. Duração: 30min. Ouçam sem legenda primeiro, depois com legenda para conferir o que entenderam.", 'Backlog', 'Média'],
                    ['🇬🇧 Teste 18: TESTE I', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 Teste 19: TESTE II', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                ],
            ],

            // ════════════════════════════════════════════════════════════════
            // SPRINT 04 — 22/07 a 28/07/2026
            // ════════════════════════════════════════════════════════════════
            [
                'name'       => 'Sprint 04',
                'start_date' => '2026-07-22',
                'end_date'   => '2026-07-28',
                'tarefas'    => [
                    ['📵 Ritual de foco: celular fora da sala de estudo', 'Antes de cada sessão de inglês, deixem o celular em outro cômodo ou no modo avião. É fácil se distrair durante o listening — o foco total faz toda diferença na absorção do idioma.', 'Backlog', 'Alta'],
                    ['🧘 Pausa ativa a cada 50 minutos de estudo', 'Alonguem pescoço, ombros e pulsos. Bebam água e descansem a vista olhando para longe. Isso evita fadiga mental, especialmente em aulas mais longas como os podcasts.', 'Backlog', 'Média'],
                    ['🇬🇧 60. Modal Verbs to Politeness', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 8min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 61. Curriculum Vitae or Resume', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 10min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 62. Interview Vocabulary', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 10min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 63. Formal Expressions for E-mail and Meetings', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 19min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 64. Vocabulary Negotiations, Reports and Positions', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 10min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Alta'],
                    ['🇬🇧 65. Useful Phrases for Presentation Decision-Making', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 3min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 66. Business English - Part 7 - Time Exercise', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 3min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 67. Business English - Part 8 - Time Podcast', "Curso Udemy — login: cursodjango@devmorais.com.br. Duração: 7min. Ouçam sem legenda primeiro, depois com legenda para conferir o que entenderam.", 'Backlog', 'Média'],
                    ['🇬🇧 Teste 20: TESTE I', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 Teste 21: TESTE II', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                    ['🇬🇧 68. Review and Final Practice - Part 1', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 18min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 69. Review and Final Practice - Part 2', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes' — login: cursodjango@devmorais.com.br. Duração: 14min. Assistam juntos e pausem para repetir frases em voz alta.", 'Backlog', 'Média'],
                    ['🇬🇧 Testes 22 a 71: Bateria final de testes (verbos, gramática, vocabulário e business English)', "Curso Udemy 'INGLÊS: Curso de Inglês para Iniciantes (FORMAÇÃO COMPLETA)' — login: cursodjango@devmorais.com.br. Façam o teste juntos e discutam cada questão errada antes de seguir.", 'Backlog', 'Alta'],
                ],
            ],
        ];

        // ── 5. Insere sprints e tarefas ─────────────────────────────────────
        $totalTarefas = 0;

        foreach ($sprints as $sprintData) {
            $sprintId = DB::table('sprints')->insertGetId([
                'board_id'   => $this->boardId,
                'name'       => $sprintData['name'],
                'start_date' => $sprintData['start_date'],
                'end_date'   => $sprintData['end_date'],
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            foreach ($sprintData['tarefas'] as [$atividade, $descricao, $statusNome, $prioridade]) {
                $statusId = $statusMap[$statusNome];

                // Cria UMA tarefa para Claudia
                $taskClaudia = Task::create([
                    'board_id'    => $this->boardId,
                    'sprint_id'   => $sprintId,
                    'status_id'   => $statusId,
                    'description' => "[Claudia] {$atividade}\n\n{$descricao}",
                    'priority'    => $prioridade,
                ]);
                $taskClaudia->assignees()->sync([$claudia->id]);

                // Cria UMA tarefa idêntica para Fernando
                $taskFernando = Task::create([
                    'board_id'    => $this->boardId,
                    'sprint_id'   => $sprintId,
                    'status_id'   => $statusId,
                    'description' => "[Fernando] {$atividade}\n\n{$descricao}",
                    'priority'    => $prioridade,
                ]);
                $taskFernando->assignees()->sync([$fernando->id]);

                $totalTarefas += 2;
            }
        }

        $this->command->info("✅ Quadro Inglês populado com sucesso!");
        $this->command->info("   Sprints criadas : " . count($sprints));
        $this->command->info("   Tarefas criadas : {$totalTarefas} (metade Claudia, metade Fernando)");
        $this->command->info("   Status criados  : " . count($statusDefs));
    }
}
