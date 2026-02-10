import 'package:flutter/material.dart'; // Importa os widgets do Material Design.
import 'pages/login/login_page.dart'; // Importa a pagina de login/entrada.

class PokedexApp extends StatelessWidget { // Declara o widget principal do app.
  const PokedexApp({super.key}); // Construtor constante do app.

  @override // Indica a sobrescrita do metodo da classe base.
  Widget build(BuildContext context) { // Constroi a interface raiz do app.
    return MaterialApp( // Retorna o widget MaterialApp.
      title: 'PokeAPI', // Define o titulo do aplicativo.
      debugShowCheckedModeBanner: false, // Remove a faixa de debug.
      
      theme: ThemeData( // Define o tema do aplicativo.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent), // Define o esquema de cores.
        useMaterial3: true, // Ativa o Material 3.
      ), // Fecha o ThemeData.

      home: const EntryPage(), // Define a pagina inicial.

    ); // Fecha o MaterialApp.
  } // Fecha o metodo build.
} // Fecha a classe PokedexApp.
