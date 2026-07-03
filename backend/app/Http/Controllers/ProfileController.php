<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;

class ProfileController extends Controller
{
    public function show(Request $request)
    {
        return response()->json(
            $this->withAbsoluteAvatar($request->user()->toArray())
        );
    }

    public function update(Request $request)
    {
        $user = $request->user();

        $validated = $request->validate([
            'name'             => 'sometimes|required|string|max:100',
            'email'            => ['sometimes', 'required', 'email', Rule::unique('users')->ignore($user->id)],
            'bio'              => 'nullable|string|max:300',
            'position'         => 'nullable|string|max:100',
            'whatsapp_number'  => 'nullable|string|max:20',
            'whatsapp_opt_in'  => 'nullable|boolean',
        ]);

        $user->update($validated);

        return response()->json(
            $this->withAbsoluteAvatar($user->fresh()->toArray())
        );
    }

    public function updatePassword(Request $request)
    {
        $request->validate([
            'current_password' => 'required|string',
            'password'         => 'required|string|min:8|confirmed',
        ]);

        $user = $request->user();

        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json(['message' => 'Senha atual incorreta.'], 422);
        }

        $user->update(['password' => $request->password]);

        return response()->json(['message' => 'Senha atualizada com sucesso.']);
    }

    public function uploadAvatar(Request $request)
    {
        $request->validate([
            'avatar' => 'required|image|mimes:jpg,jpeg,png,webp|max:2048',
        ]);

        $user = $request->user();

        // Remove avatar antigo se existir
        if ($user->avatar_url) {
            $oldPath = ltrim(str_replace('/storage', '', parse_url($user->avatar_url, PHP_URL_PATH)), '/');
            Storage::disk('public')->delete($oldPath);
        }

        $path = $request->file('avatar')->store('avatars', 'public');

        $user->update(['avatar_url' => '/storage/' . $path]);

        return response()->json([
            'avatar_url' => url('storage/' . $path), // já absoluta
        ]);
    }

    private function withAbsoluteAvatar(array $user): array
    {
        if (!empty($user['avatar_url']) && !str_starts_with($user['avatar_url'], 'http')) {
            $user['avatar_url'] = url($user['avatar_url']);
        }
        return $user;
    }
}
