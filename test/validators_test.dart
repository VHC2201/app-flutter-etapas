import 'package:flutter_test/flutter_test.dart';
import 'package:app_etapas/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('aceita e-mail válido', () {
      expect(Validators.email('aluno@unipar.br'), isNull);
    });
    test('recusa vazio e formato errado', () {
      expect(Validators.email(''), isNotNull);
      expect(Validators.email('aluno@'), isNotNull);
      expect(Validators.email('aluno.unipar.br'), isNotNull);
    });
  });

  group('Validators.senha', () {
    test('exige pelo menos 6 caracteres', () {
      expect(Validators.senha('12345'), isNotNull);
      expect(Validators.senha('123456'), isNull);
    });
    test('confirmação precisa ser igual', () {
      expect(Validators.confirmarSenha('abc123', 'abc123'), isNull);
      expect(Validators.confirmarSenha('abc124', 'abc123'), isNotNull);
    });
  });

  group('Validators.telefone', () {
    test('é opcional', () {
      expect(Validators.telefone(''), isNull);
    });
    test('aceita 10 ou 11 dígitos com máscara', () {
      expect(Validators.telefone('(44) 99999-9999'), isNull);
      expect(Validators.telefone('(44) 3333-3333'), isNull);
      expect(Validators.telefone('9999'), isNotNull);
    });
  });

  group('Validators.nome', () {
    test('exige pelo menos 3 letras', () {
      expect(Validators.nome('Al'), isNotNull);
      expect(Validators.nome('Ana'), isNull);
    });
  });
}
