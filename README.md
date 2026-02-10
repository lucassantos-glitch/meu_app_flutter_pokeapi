# flutter_pokedex

<<<<<<< HEAD
A new Flutter project.Initial Flutter project setup and dependencies
=======
Aplicativo Flutter que consome a PokeAPI e exibe uma lista de pokemons com detalhes e favoritos.
>>>>>>> 35678f8 (Organização do projeto e novas estruturas (models, pages, services, stores))

## Estrutura do projeto

```
flutter_pokeApi/
├─ android/            # Projeto Android (Gradle, manifest, etc.)
├─ ios/                # Projeto iOS (Xcode, plist, etc.)
├─ linux/              # Projeto Linux
├─ macos/              # Projeto macOS
├─ web/                # Projeto Web
├─ windows/            # Projeto Windows
├─ build/              # Saidas de build (gerado pelo Flutter)
├─ lib/                # Codigo fonte do app
│  ├─ assets/          # Assets do app (imagens, etc.)
│  ├─ models/          # Modelos de dados (Pokemon)
│  ├─ pages/           # Telas do app
│  │  ├─ details/      # Tela de detalhes do Pokemon
│  │  ├─ favorites/    # Tela de favoritos
│  │  ├─ home/         # Tela inicial/lista de Pokemon
│  │  ├─ login/        # Tela de entrada
│  │  ├─ main_navigation/ # Navegacao principal (abas)
│  ├─ services/        # Servicos (chamadas a API)
│  ├─ stores/          # Gerenciamento de estado simples (favoritos)
│  ├─ app.dart         # Configuracao do MaterialApp
│  └─ main.dart        # Ponto de entrada do app
├─ test/               # Testes automatizados
├─ pubspec.yaml        # Dependencias e configuracoes do Flutter
└─ README.md           # Documentacao do projeto
```

## Como rodar o projeto (passo a passo)

1. Instale o Flutter SDK e configure o ambiente: https://docs.flutter.dev/get-started/install
2. No terminal, verifique se esta tudo ok:
	```
	flutter doctor
	```
3. Baixe as dependencias do projeto:
	```
	flutter pub get
	```
4. Conecte um dispositivo ou inicie um emulador/simulador.
5. Execute o app:
	```
	flutter run
	```

Opcional (rodar no navegador):

```
flutter run -d chrome
```
