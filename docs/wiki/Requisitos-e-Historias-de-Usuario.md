# Requisitos e Histórias de Usuário

## Informações levantadas

| Informação | Onde é usada | Obrigatória | Regra | Onde fica guardada |
|---|---|---|---|---|
| Nome completo | Cadastro, menu lateral, Meus dados | Sim | Mínimo 3 letras | Firebase (`displayName`) e SharedPreferences |
| E-mail | Cadastro, login, recuperação de senha | Sim | Formato válido; único no Firebase | Firebase e SharedPreferences |
| Telefone | Cadastro, Meus dados | Não | DDD + número (10 ou 11 dígitos) | SharedPreferences |
| Senha | Cadastro, login | Sim | Mínimo 6 caracteres (regra do Firebase) | **Somente no Firebase** |
| Confirmação de senha | Cadastro | Sim | Igual à senha | Não é guardada |
| Data do cadastro | Meus dados | Automática | Data/hora do aparelho | SharedPreferences |

## Requisitos funcionais
- **RF01** — Permitir cadastro com nome, e-mail, telefone (opcional) e senha.
- **RF02** — Permitir login com e-mail e senha pelo Firebase Authentication.
- **RF03** — Permitir recuperação de senha por e-mail.
- **RF04** — Manter o usuário logado ao reabrir o app até ele sair.
- **RF05** — Permitir sair da conta.
- **RF06** — Salvar os dados do último cadastro no aparelho (SharedPreferences), substituindo o anterior.
- **RF07** — Oferecer navegação por menu lateral (Drawer) a partir da tela principal.
- **RF08** — Exibir os dados salvos do usuário em "Meus dados".

## Requisitos não funcionais
- **RNF01** — Desenvolvido em Flutter (Dart), com autenticação pelo Firebase.
- **RNF02** — Mensagens de erro em português e fáceis de entender.
- **RNF03** — A senha nunca é salva no aparelho.
- **RNF04** — Código versionado no GitHub, com tag ao final de cada etapa.

---

## Histórias de usuário

### HU01 — Criar conta *(Etapa 1)*
**Como** visitante, **quero** me cadastrar com nome, e-mail e senha **para** ter acesso ao aplicativo.

Critérios de aceitação:
- [ ] Nome, e-mail, senha e confirmação são obrigatórios; telefone é opcional.
- [ ] O e-mail precisa ter formato válido e a senha ao menos 6 caracteres.
- [ ] Senha e confirmação precisam ser iguais.
- [ ] Se o e-mail já estiver cadastrado, aparece "Já existe uma conta com este e-mail."
- [ ] Após o cadastro, o usuário entra direto na tela principal.

### HU02 — Entrar no app *(Etapa 1)*
**Como** usuário cadastrado, **quero** entrar com e-mail e senha **para** acessar minha conta.

Critérios de aceitação:
- [ ] Campos vazios ou inválidos mostram o erro embaixo do campo, sem chamar o Firebase.
- [ ] Credenciais erradas mostram "E-mail ou senha incorretos."
- [ ] Sem internet, aparece "Sem conexão com a internet."
- [ ] O botão mostra carregamento e fica desabilitado enquanto espera o Firebase.

### HU03 — Recuperar senha *(Etapa 1)*
**Como** usuário que esqueceu a senha, **quero** receber um e-mail de redefinição **para** voltar a acessar minha conta.

Critérios de aceitação:
- [ ] Usa o e-mail digitado no campo da tela de login.
- [ ] Se o campo estiver vazio ou inválido, o app pede para digitar o e-mail.
- [ ] A mensagem de confirmação não revela se o e-mail existe ou não.

### HU04 — Continuar logado *(Etapa 1)*
**Como** usuário, **quero** continuar logado ao fechar e abrir o app **para** não precisar digitar a senha toda vez.

Critérios de aceitação:
- [ ] Ao abrir o app com sessão ativa, a tela principal aparece direto.

### HU05 — Guardar meus dados no aparelho *(Etapa 2)*
**Como** usuário, **quero** que meus dados de cadastro fiquem salvos no aparelho **para** que o app me reconheça.

Critérios de aceitação:
- [ ] Ao cadastrar, nome, e-mail, telefone e data do cadastro são salvos com SharedPreferences.
- [ ] Um novo cadastro substitui o anterior.
- [ ] A senha não é salva.
- [ ] Na tela de login, o e-mail do último cadastro já vem preenchido.

### HU06 — Navegar pelo menu lateral *(Etapa 2)*
**Como** usuário logado, **quero** um menu lateral **para** acessar as áreas do app.

Critérios de aceitação:
- [ ] A tela principal tem o ícone de menu na barra superior (ela fica em branco por enquanto).
- [ ] O menu mostra nome, e-mail e iniciais do usuário.
- [ ] Opções: Início, Meus dados, Sobre e Sair.

### HU07 — Ver meus dados *(Etapa 2)*
**Como** usuário, **quero** ver os dados salvos do meu cadastro **para** conferir se estão corretos.

Critérios de aceitação:
- [ ] Mostra nome, e-mail, telefone formatado e data do cadastro.
- [ ] Se não houver cadastro salvo, mostra um aviso.

### HU08 — Sair da conta *(Etapa 1 / Etapa 2)*
**Como** usuário, **quero** sair da minha conta **para** proteger meu acesso em um aparelho compartilhado.

Critérios de aceitação:
- [ ] Na Etapa 2, "Sair" fica no menu lateral e pede confirmação.
- [ ] Depois de sair, o app volta para a tela de login.
