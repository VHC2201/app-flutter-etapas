/// Funções de validação usadas nos campos dos formulários.
///
/// Cada função devolve `null` quando o valor está certo,
/// ou o texto do erro que aparece embaixo do campo.
class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

  static String? nome(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Informe seu nome';
    if (texto.length < 3) return 'O nome deve ter pelo menos 3 letras';
    return null;
  }

  static String? email(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Informe seu e-mail';
    if (!_emailRegex.hasMatch(texto)) return 'E-mail inválido';
    return null;
  }

  /// Telefone é opcional; se preenchido, precisa ter DDD + número.
  static String? telefone(String? valor) {
    final digitos = (valor ?? '').replaceAll(RegExp(r'\D'), '');
    if (digitos.isEmpty) return null;
    if (digitos.length < 10 || digitos.length > 11) {
      return 'Use DDD + número (10 ou 11 dígitos)';
    }
    return null;
  }

  /// O Firebase exige no mínimo 6 caracteres.
  static String? senha(String? valor) {
    final texto = valor ?? '';
    if (texto.isEmpty) return 'Informe sua senha';
    if (texto.length < 6) return 'A senha deve ter pelo menos 6 caracteres';
    return null;
  }

  static String? confirmarSenha(String? valor, String senhaOriginal) {
    if ((valor ?? '').isEmpty) return 'Confirme sua senha';
    if (valor != senhaOriginal) return 'As senhas não conferem';
    return null;
  }
}
