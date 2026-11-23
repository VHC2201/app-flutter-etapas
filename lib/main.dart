import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Gerado pelo comando `flutterfire configure` (veja o README).
import 'firebase_options.dart';
import 'pages/auth_gate.dart';

Future<void> main() async {
  // Garante que o Flutter está pronto antes de chamar código nativo (Firebase).
  WidgetsFlutterBinding.ensureInitialized();

  // Conecta o app ao projeto do Firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Etapas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      // O AuthGate decide qual tela mostrar: login ou principal.
      home: const AuthGate(),
    );
  }
}
