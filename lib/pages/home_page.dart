import 'package:flutter/material.dart';

import '../services/auth_service.dart';

/// Tela provisória da Etapa 1: só confirma que o login funcionou.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = AuthService.instance.usuarioAtual;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
        actions: [
          IconButton(
            tooltip: 'Sair',
            icon: const Icon(Icons.logout),
            onPressed: () => AuthService.instance.sair(),
          ),
        ],
      ),
      body: Center(
        child: Text('Olá, ${usuario?.displayName ?? usuario?.email ?? ''}!'),
      ),
    );
  }
}
