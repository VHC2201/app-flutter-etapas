import 'package:firebase_auth/firebase_auth.dart';

/// Concentra todas as chamadas ao Firebase Auth (login por e-mail e senha).
///
/// As telas não falam direto com o Firebase: elas chamam este serviço.
/// Assim, se a forma de autenticar mudar, só este arquivo muda.
class AuthService {
  AuthService._();

  /// Instância única (singleton) usada pelo app inteiro.
  static final AuthService instance = AuthService._();

  FirebaseAuth get _auth => FirebaseAuth.instance;

  /// Emite o usuário atual sempre que o estado de login muda.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get usuarioAtual => _auth.currentUser;

  Future<void> entrar({required String email, required String senha}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: senha);
  }

  /// Cria a conta no Firebase e grava o nome no perfil do usuário.
  Future<void> cadastrar({
    required String nome,
    required String email,
    required String senha,
  }) async {
    final credencial = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
    await credencial.user?.updateDisplayName(nome);
    await credencial.user?.reload();
  }

  Future<void> enviarEmailRedefinicao(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> sair() async {
    await _auth.signOut();
  }
}
