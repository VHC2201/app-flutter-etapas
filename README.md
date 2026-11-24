# App Etapas — Flutter + Firebase

Aplicativo construído por etapas na disciplina de desenvolvimento mobile (UNIPAR — Sistemas de Informação), com cadastro e login de usuários usando **Firebase Authentication (e-mail e senha)**.

**Aluno:** Vinicius Cordeiro — RA 60002252

**Wiki do projeto (requisitos e histórias de usuário):** `https://github.com/VHC2201/app-flutter-etapas/wiki`

---

## Como rodar o projeto

O app está configurado para rodar na **Web** (navegador), já conectado ao projeto `app-flutter-etapas` do Firebase (Authentication com e-mail/senha ativado).

Pré-requisito: Flutter SDK (canal stable).

```bash
git clone https://github.com/VHC2201/app-flutter-etapas.git
cd app-flutter-etapas
flutter pub get
flutter run -d chrome
```

No VS Code também é possível rodar pela aba **Executar e Depurar**, com a configuração "App Etapas (navegador - porta 8080)" (abre em http://localhost:8080).

Testes automatizados (validações e SharedPreferences):

```bash
flutter test
```

## Estrutura

```
lib/
├── main.dart                     # inicializa o Firebase e abre o app
├── firebase_options.dart         # configuração do Firebase (Web)
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
web/                              # index.html e manifest do app web
```

---

## Etapa 0 — Organização do projeto

**O que foi feito**
- Criação do repositório no GitHub e da estrutura do projeto Flutter.
- `.gitignore` para Flutter/Android/iOS.
- README como documentação única do projeto, com uma seção por etapa.
- Padrão de trabalho: commits pequenos com mensagens em português, no imperativo, explicando o que mudou, e uma tag por etapa (`etapa-1`, `etapa-2`...).

---

## Etapa 1 — Login e Cadastro

**Tag:** `etapa-1`

**O que foi feito**
- Projeto ligado ao Firebase com `firebase_core` (configuração em `lib/firebase_options.dart`).
- Autenticação por e-mail e senha com `firebase_auth`, seguindo o modelo da documentação do Firebase Auth.
- **Tela de login:** e-mail, senha (com botão de mostrar/ocultar), "Esqueci minha senha" (envia e-mail de redefinição) e link para o cadastro.
- **Tela de cadastro:** nome, e-mail, telefone (opcional), senha e confirmação de senha. O nome é gravado no perfil do Firebase (`displayName`).
- Validação de todos os campos antes de chamar o Firebase e tradução dos erros do Firebase para português (e-mail já usado, senha fraca, credenciais inválidas, sem internet...).
- `AuthGate`: um `StreamBuilder` escuta `authStateChanges()` e troca sozinho entre a tela de login e a tela principal.
- Levantamento de requisitos e histórias de usuário na **wiki** do projeto: https://github.com/VHC2201/app-flutter-etapas/wiki

**Declaração de uso de IA (Etapa 1)**
- **Usei IA?** Sim — Claude (Anthropic), modelo Claude Opus 5.5, em 23/11/2026.
- **Para quê:** gerar a base das telas de login e cadastro e do serviço de autenticação, tirar dúvidas sobre o Firebase Auth e organizar os commits e o README.
- **O que ela sugeriu:** separar o acesso ao Firebase em um `AuthService`; usar um `AuthGate` com `authStateChanges()` para trocar sozinho entre login e tela inicial; validar os campos com `Form`/`validator` antes de chamar o Firebase; traduzir os códigos de erro do Firebase (incluindo `invalid-credential`).
- **O que alterei:** defini que o trabalho é individual e que os commits seriam em português; criei e configurei o projeto no Firebase; rodei o app e os testes no meu computador para conferir o funcionamento.

---

## Etapa 2 — Tela principal

**Tag:** `etapa-2`

**O que foi feito**
- **SharedPreferences** (`shared_preferences`) para salvar os dados do usuário no aparelho: nome, e-mail, telefone e data do cadastro, guardados como JSON em uma única chave (`usuario_atual`). **A cada novo cadastro o registro anterior é substituído**, já que esse armazenamento é simples e limitado.
- A senha **não** é salva no aparelho: o SharedPreferences não é criptografado e quem confere a senha é o Firebase.
- A tela de login preenche automaticamente o e-mail do último cadastro salvo.
- **Drawer navigation** (menu lateral) com cabeçalho mostrando nome, e-mail e iniciais do usuário, e as opções *Início*, *Meus dados*, *Sobre* e *Sair* (com confirmação).
- **Tela principal em branco**, acessada após o login, com o menu lateral.
- *Meus dados* mostra o que está salvo no SharedPreferences.
- Testes automatizados para as validações e para o serviço de SharedPreferences (incluindo o teste "novo cadastro substitui o anterior").

**Declaração de uso de IA (Etapa 2)**
- **Usei IA?** Sim — Claude (Anthropic), modelo Claude Opus 5.5, em 23/11/2026.
- **Para quê:** estruturar o salvamento com SharedPreferences, o menu lateral (Drawer) e os testes automatizados.
- **O que ela sugeriu:** guardar o usuário como JSON em uma chave só (assim um novo cadastro substitui o anterior), não salvar a senha no aparelho, montar o Drawer com `UserAccountsDrawerHeader` e testar com `SharedPreferences.setMockInitialValues`.
- **O que alterei:** conferi o resultado rodando o app no navegador e executando os testes (`flutter test`: 10 de 10 passando).

Referência (ABNT): ANTHROPIC. *Claude Opus 5.5*. [Modelo de linguagem]. San Francisco: Anthropic, 2026. Disponível em: https://claude.ai. Acesso em: 23 nov. 2026.
