// Configuração do Firebase do projeto "app-flutter-etapas".
// Equivale ao arquivo que o comando `flutterfire configure` gera.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    throw UnsupportedError(
      'Por enquanto o app está configurado só para Web. '
      'Rode `flutterfire configure` para adicionar Android/iOS.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    // Copie o valor de "apiKey" em: Console do Firebase > Configurações do
    // projeto > Seus apps > app_etapas_web > Configuração do SDK.
    apiKey: 'COLE_AQUI_A_API_KEY',
    appId: '1:722692136953:web:1f9eccaab91340e18c6728',
    messagingSenderId: '722692136953',
    projectId: 'app-flutter-etapas',
    authDomain: 'app-flutter-etapas.firebaseapp.com',
    storageBucket: 'app-flutter-etapas.firebasestorage.app',
  );
}
