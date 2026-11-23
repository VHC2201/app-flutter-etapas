import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../pages/about_page.dart';
import '../pages/profile_page.dart';
import '../services/auth_service.dart';
import '../services/user_prefs_service.dart';

/// Menu lateral (Drawer navigation).
///
/// O Scaffold só constrói o Drawer quando ele é aberto, então o initState
/// roda a cada abertura e os dados lidos do SharedPreferences estão sempre
/// atualizados.
class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late final Future<AppUser> _usuario;

  @override
  void initState() {
    super.initState();
    _usuario = _carregarUsuario();
  }

  /// Usa os dados salvos no aparelho. Se eles forem de outra conta
  /// (o aparelho guarda só o último cadastro), usa os dados do Firebase.
  Future<AppUser> _carregarUsuario() async {
    final salvo = await UserPrefsService().carregar();
    final logado = AuthService.instance.usuarioAtual;
    final emailLogado = (logado?.email ?? '').toLowerCase();

    if (salvo != null &&
        (logado == null || salvo.email.toLowerCase() == emailLogado)) {
      return salvo;
    }
    return AppUser(
      nome: logado?.displayName ?? 'Usuário',
      email: logado?.email ?? '',
    );
  }

  String _iniciais(String nome) {
    final partes = nome.trim().split(RegExp(r'\s+'))
      ..removeWhere((p) => p.isEmpty);
    if (partes.isEmpty) return '?';
    if (partes.length == 1) return partes.first[0].toUpperCase();
    return (partes.first[0] + partes.last[0]).toUpperCase();
  }

  void _abrir(Widget pagina) {
    final navegador = Navigator.of(context);
    navegador.pop(); // fecha o drawer
    navegador.push(MaterialPageRoute(builder: (_) => pagina));
  }

  Future<void> _sair() async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (contexto) => AlertDialog(
        title: const Text('Sair'),
        content: const Text('Deseja mesmo sair da sua conta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(contexto).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(contexto).pop(true),
            child: const Text('Sair'),
          ),
        ],
      ),
    );
    if (confirmou != true || !mounted) return;

    Navigator.of(context).pop(); // fecha o drawer
    // O AuthGate percebe a saída e volta para a tela de login.
    await AuthService.instance.sair();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<AppUser>(
        future: _usuario,
        builder: (context, snapshot) {
          final usuario = snapshot.data;
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(usuario?.nome ?? 'Carregando...'),
                accountEmail: Text(usuario?.email ?? ''),
                currentAccountPicture: CircleAvatar(
                  child: Text(
                    _iniciais(usuario?.nome ?? ''),
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Início'),
                selected: true,
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Meus dados'),
                onTap: () => _abrir(const ProfilePage()),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Sobre'),
                onTap: () => _abrir(const AboutPage()),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sair'),
                onTap: _sair,
              ),
            ],
          );
        },
      ),
    );
  }
}
