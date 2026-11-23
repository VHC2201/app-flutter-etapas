import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_user.dart';

/// Salva e lê os dados do usuário com SharedPreferences.
///
/// Tudo fica em UMA chave só ("usuario_atual"), como um JSON.
/// Por isso, a cada novo cadastro o valor anterior é substituído:
/// o SharedPreferences é um armazenamento simples (chave -> valor),
/// pensado para pouca informação, e não um banco de dados.
class UserPrefsService {
  static const String chave = 'usuario_atual';

  Future<void> salvar(AppUser usuario) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(chave, jsonEncode(usuario.toMap()));
  }

  /// Retorna o usuário salvo, ou `null` se ainda não houver nenhum.
  Future<AppUser?> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    final texto = prefs.getString(chave);
    if (texto == null) return null;
    try {
      return AppUser.fromMap(jsonDecode(texto) as Map<String, dynamic>);
    } catch (_) {
      // Dado corrompido: ignoramos em vez de travar o app.
      return null;
    }
  }

  Future<void> limpar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(chave);
  }
}
