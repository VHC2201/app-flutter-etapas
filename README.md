# App Etapas — Flutter + Firebase

Aplicativo construído por etapas na disciplina de desenvolvimento mobile (UNIPAR — Sistemas de Informação), com cadastro e login de usuários usando **Firebase Authentication (e-mail e senha)**.

**Aluno:** Vinicius Cordeiro — RA 60002252

**Wiki do projeto (requisitos e histórias de usuário):** `https://github.com/VHC2201/app-flutter-etapas/wiki`

---

## Como rodar o projeto

Pré-requisitos: Flutter SDK (canal stable), Firebase CLI (`npm install -g firebase-tools`) e FlutterFire CLI (`dart pub global activate flutterfire_cli`).

```bash
git clone https://github.com/VHC2201/app-flutter-etapas.git
cd app-flutter-etapas
flutter create . --project-name app_etapas --org br.unipar   # gera android/, ios/, web/... (só na 1ª vez)
flutter pub get
flutterfire configure      # escolha o projeto do Firebase; gera lib/firebase_options.dart
flutter run
```

No [Console do Firebase](https://console.firebase.google.com), em **Authentication → Método de login**, o provedor **E-mail/senha** precisa estar ativado.

Testes automatizados (validações e SharedPreferences):

```bash
flutter test
```

## Estrutura

```
lib/
├── main.dart                     # inicializa o Firebase e abre o app
├── firebase_options.dart         # gerado pelo flutterfire configure
├── models/app_user.dart          # dados do usuário salvos no aparelho
├── services/
│   ├── auth_service.dart         # chamadas ao Firebase Auth
│   └── user_prefs_service.dart   # leitura/escrita no SharedPreferences
├── pages/
│   ├── auth_gate.dart            # decide entre Login e Home
│   ├── login_page.dart
│   ├── register_page.dart
│   ├── home_page.dart            # tela principal (em branco) com Drawer
│   ├── profile_page.dart         # "Meus dados" (lidos do SharedPreferences)
│   └── about_page.dart
├── widgets/app_drawer.dart       # menu lateral
└── utils/
    ├── validators.dart           # validação dos formulários
    └── firebase_erros.dart       # mensagens de erro em português
test/
├── validators_test.dart
└── user_prefs_test.dart
```

---

## Etapa 0 — Organização do projeto

**O que foi feito**
- Criação do repositório no GitHub e do projeto Flutter (`flutter create`).
- `.gitignore` para Flutter/Android/iOS.
- README como documentação única do projeto, com uma seção por etapa.
- Padrão de trabalho: commits pequenos com mensagens em português, no imperativo, explicando o que mudou, e uma tag por etapa (`etapa-1`, `etapa-2`...).

---

## Etapa 1 — Login e Cadastro

**Tag:** `etapa-1`

**O que foi feito**
- Projeto ligado ao Firebase com `firebase_core` e `flutterfire configure`.
- Autenticação por e-mail e senha com `firebase_auth`, seguindo o modelo da documentação do Firebase Auth.
- **Tela de login:** e-mail, senha (com botão de mostrar/ocultar), "Esqueci minha senha" (envia e-mail de redefinição) e link para o cadastro.
- **Tela de cadastro:** nome, e-mail, telefone (opcional), senha e confirmação de senha. O nome é gravado no perfil do Firebase (`displayName`).
- Validação de todos os campos antes de chamar o Firebase e tradução dos erros do Firebase para português (e-mail já usado, senha fraca, credenciais inválidas, sem internet...).
- `AuthGate`: um `StreamBuilder` escuta `authStateChanges()` e troca sozinho entre a tela de login e a tela principal.
- Levantamento de requisitos e histórias de usuário na **wiki** do projeto.

**Prints**

| Login | Cadastro | Erro de validação |
|---|---|---|
| ![Login](docs/prints/etapa1-login.png) | ![Cadastro](docs/prints/etapa1-cadastro.png) | ![Erro](docs/prints/etapa1-erro.png) |

**Vídeo:** https://youtu.be/LINK-ETAPA-1

**Declaração de uso de IA (Etapa 1)**
> PREENCHER COM SUAS PALAVRAS. Exemplo de estrutura:
> - **Usei IA?** Sim — Claude (Anthropic), modelo Claude Opus 5.5, em 23/11/2026.
> - **Para quê:** gerar uma base para as telas de login e cadastro e para o serviço de autenticação, e tirar dúvidas sobre o Firebase Auth.
> - **O que ela sugeriu:** separar o acesso ao Firebase em um `AuthService`, usar um `AuthGate` com `authStateChanges()`, validar os campos com `Form`/`validator` e traduzir os códigos de erro (incluindo `invalid-credential`).
> - **O que alterei / aprendi:** (descrever o que você mudou, testou e entendeu — ex.: por que o cadastro já deixa o usuário logado, o que é um `Stream`, por que verificar `mounted` depois de um `await`).
