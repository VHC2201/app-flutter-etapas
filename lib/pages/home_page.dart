import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

/// Tela principal. Por enquanto fica em branco (pedido da Etapa 2);
/// a navegação acontece pelo menu lateral (Drawer).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Início')),
      drawer: const AppDrawer(),
      body: const SizedBox.expand(),
    );
  }
}
