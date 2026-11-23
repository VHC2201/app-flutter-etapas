import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/firebase_erros.dart';
import '../utils/validators.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();

  bool _carregando = false;
  bool _ocultarSenha = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _senhaCtrl.dispose();
    super.dispose();
  }

  void _mostrarMensagem(String texto) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(texto)));
  }

  Future<void> _entrar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _carregando = true);
    try {
      await AuthService.instance.entrar(
        email: _emailCtrl.text.trim(),
        senha: _senhaCtrl.text,
      );
      // Não precisa navegar: o AuthGate percebe o login e mostra a Home.
    } on FirebaseAuthException catch (e) {
      _mostrarMensagem(mensagemErroFirebase(e));
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  Future<void> _recuperarSenha() async {
    if (Validators.email(_emailCtrl.text) != null) {
      _mostrarMensagem('Digite seu e-mail no campo acima para recuperar a senha.');
      return;
    }
    try {
      await AuthService.instance.enviarEmailRedefinicao(_emailCtrl.text.trim());
      _mostrarMensagem(
        'Se o e-mail estiver cadastrado, você vai receber um link para criar uma nova senha.',
      );
    } on FirebaseAuthException catch (e) {
      _mostrarMensagem(mensagemErroFirebase(e));
    }
  }

  void _abrirCadastro() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(Icons.lock_outline,
                        size: 64, color: tema.colorScheme.primary),
                    const SizedBox(height: 16),
                    Text('Entrar',
                        textAlign: TextAlign.center,
                        style: tema.textTheme.headlineMedium),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailCtrl,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _senhaCtrl,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: const Icon(Icons.key_outlined),
                        suffixIcon: IconButton(
                          tooltip: _ocultarSenha ? 'Mostrar senha' : 'Ocultar senha',
                          icon: Icon(_ocultarSenha
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () =>
                              setState(() => _ocultarSenha = !_ocultarSenha),
                        ),
                      ),
                      obscureText: _ocultarSenha,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _entrar(),
                      validator: Validators.senha,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _carregando ? null : _recuperarSenha,
                        child: const Text('Esqueci minha senha'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: _carregando ? null : _entrar,
                      child: _carregando
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Entrar'),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: _carregando ? null : _abrirCadastro,
                      child: const Text('Não tem conta? Cadastre-se'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
