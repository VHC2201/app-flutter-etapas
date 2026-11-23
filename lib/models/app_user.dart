/// Dados do usuário que guardamos no aparelho (SharedPreferences).
///
/// A senha NÃO fica aqui: quem guarda e confere a senha é o Firebase.
/// SharedPreferences salva texto puro, sem criptografia.
class AppUser {
  final String nome;
  final String email;
  final String telefone;
  final DateTime? dataCadastro;

  const AppUser({
    required this.nome,
    required this.email,
    this.telefone = '',
    this.dataCadastro,
  });

  /// Converte o objeto em Map para depois virar JSON.
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'dataCadastro': dataCadastro?.toIso8601String(),
    };
  }

  /// Cria o objeto a partir do Map lido do JSON.
  factory AppUser.fromMap(Map<String, dynamic> map) {
    final data = map['dataCadastro'];
    return AppUser(
      nome: map['nome'] as String? ?? '',
      email: map['email'] as String? ?? '',
      telefone: map['telefone'] as String? ?? '',
      dataCadastro: data is String ? DateTime.tryParse(data) : null,
    );
  }
}
