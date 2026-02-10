import 'package:flutter/material.dart'; // Importa os widgets do Material Design.
import 'app.dart'; // Importa o widget principal do aplicativo.
import 'stores/favorites_store.dart'; // Importa o store de favoritos.

Future<void> main() async { // Funcao principal que inicia o app.
  WidgetsFlutterBinding.ensureInitialized(); // Garante a inicializacao do Flutter.
  await FavoritesStore.load(); // Carrega favoritos salvos antes de iniciar.
  runApp(const PokedexApp()); // Executa o app com o widget raiz.
} // Fecha a funcao main.