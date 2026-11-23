import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text('App Etapas', style: tema.textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('Projeto por etapas com Flutter + Firebase.'),
          const SizedBox(height: 24),
          Text('Desenvolvido por', style: tema.textTheme.titleMedium),
          const SizedBox(height: 4),
          const Text('Vinicius Cordeiro - RA 60002252'),
          const SizedBox(height: 24),
          Text('Instituição', style: tema.textTheme.titleMedium),
          const SizedBox(height: 4),
          const Text('Universidade Paranaense (UNIPAR) - Sistemas de Informação'),
        ],
      ),
    );
  }
}
