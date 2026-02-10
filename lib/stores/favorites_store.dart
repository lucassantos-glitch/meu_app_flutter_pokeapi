import 'package:flutter/foundation.dart'; // Importa tipos basicos do Flutter, incluindo ValueNotifier.
import 'package:shared_preferences/shared_preferences.dart'; // Importa o pacote de persistencia.

class FavoritesStore { // Declara o store que gerencia favoritos.
  static const String _storageKey = 'favorites'; // Chave usada para salvar favoritos.
  static final ValueNotifier<Set<String>> favorites = ValueNotifier<Set<String>>({}); // Notificador com o conjunto de favoritos.

  static Future<void> load() async { // Carrega favoritos salvos do dispositivo.
    final prefs = await SharedPreferences.getInstance(); // Obtem a instancia de preferencia.
    final saved = prefs.getStringList(_storageKey) ?? <String>[]; // Le a lista salva ou usa vazia.
    favorites.value = saved.toSet(); // Atualiza o notificador com os favoritos salvos.
  } // Fecha o metodo load.

  static Future<void> _saveFavorites(Set<String> values) async { // Salva os favoritos no dispositivo.
    final prefs = await SharedPreferences.getInstance(); // Obtem a instancia de preferencia.
    await prefs.setStringList(_storageKey, values.toList()); // Persiste a lista de favoritos.
  } // Fecha o metodo _saveFavorites.

  static void toggle(String name) { // Alterna o estado de favorito do nome.
    final updated = Set<String>.from(favorites.value); // Cria uma copia mutavel do conjunto.

    if (updated.contains(name)) { // Verifica se ja esta favoritado.
      updated.remove(name); // Remove do conjunto.
    } else { // Caso contrario.
      updated.add(name); // Adiciona ao conjunto.
    } // Fecha o bloco do if/else.

    favorites.value = updated; // Atualiza o ValueNotifier com o novo conjunto.
    _saveFavorites(updated); // Persiste a nova lista de favoritos.
  } // Fecha o metodo toggle.

  static void remove(String name) { // Remove um nome dos favoritos.
    final updated = Set<String>.from(favorites.value); // Cria uma copia mutavel do conjunto.
    updated.remove(name); // Remove o nome do conjunto.
    favorites.value = updated; // Atualiza o ValueNotifier com o novo conjunto.
    _saveFavorites(updated); // Persiste a nova lista de favoritos.
  } // Fecha o metodo remove.
} // Fecha a classe FavoritesStore.
