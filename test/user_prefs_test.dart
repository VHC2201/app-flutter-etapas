import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_etapas/models/app_user.dart';
import 'package:app_etapas/services/user_prefs_service.dart';

void main() {
  setUp(() {
    // Simula um SharedPreferences vazio, sem precisar de celular.
    SharedPreferences.setMockInitialValues({});
  });

  test('sem cadastro, carregar devolve null', () async {
    expect(await UserPrefsService().carregar(), isNull);
  });

  test('salva e lê o usuário', () async {
    final servico = UserPrefsService();
    final data = DateTime(2026, 11, 23, 20, 0);
    await servico.salvar(AppUser(
      nome: 'Vinicius',
      email: 'vinicius@email.com',
      telefone: '44999999999',
      dataCadastro: data,
    ));

    final lido = await servico.carregar();
    expect(lido?.nome, 'Vinicius');
    expect(lido?.email, 'vinicius@email.com');
    expect(lido?.telefone, '44999999999');
    expect(lido?.dataCadastro, data);
  });

  test('novo cadastro substitui o anterior', () async {
    final servico = UserPrefsService();
    await servico.salvar(const AppUser(nome: 'Primeiro', email: 'a@a.com'));
    await servico.salvar(const AppUser(nome: 'Segundo', email: 'b@b.com'));

    final lido = await servico.carregar();
    expect(lido?.nome, 'Segundo');
    expect(lido?.email, 'b@b.com');
  });
}
