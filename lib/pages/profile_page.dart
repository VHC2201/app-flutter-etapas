import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../services/user_prefs_service.dart';

/// Mostra o que está salvo no SharedPreferences (o último cadastro feito
/// neste aparelho).
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  String _formatarData(DateTime? data) {
    if (data == null) return '-';
    String dois(int n) => n.toString().padLeft(2, '0');
    return '${dois(data.day)}/${dois(data.month)}/${data.year} '
        '${dois(data.hour)}:${dois(data.minute)}';
  }

  String _formatarTelefone(String digitos) {
    if (digitos.isEmpty) return '-';
    if (digitos.length == 11) {
      return '(${digitos.substring(0, 2)}) ${digitos.substring(2, 7)}-${digitos.substring(7)}';
    }
    if (digitos.length == 10) {
      return '(${digitos.substring(0, 2)}) ${digitos.substring(2, 6)}-${digitos.substring(6)}';
    }
    return digitos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus dados')),
      body: FutureBuilder<AppUser?>(
        future: UserPrefsService().carregar(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final usuario = snapshot.data;
          if (usuario == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Nenhum cadastro salvo neste aparelho ainda.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Nome'),
                subtitle: Text(usuario.nome),
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: const Text('E-mail'),
                subtitle: Text(usuario.email),
              ),
              ListTile(
                leading: const Icon(Icons.phone_outlined),
                title: const Text('Telefone'),
                subtitle: Text(_formatarTelefone(usuario.telefone)),
              ),
              ListTile(
                leading: const Icon(Icons.event_outlined),
                title: const Text('Cadastrado em'),
                subtitle: Text(_formatarData(usuario.dataCadastro)),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Estes dados ficam salvos no aparelho com SharedPreferences. '
                  'Um novo cadastro substitui o anterior.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
