import 'dart:convert'; // Importa funcoes para converter JSON.
import 'package:http/http.dart' as http; // Importa o cliente HTTP com alias.
import '../models/pokemon_model.dart'; // Importa os modelos de dados.

class PokemonApiService { // Declara o servico de acesso a PokeAPI.
  static const String _baseUrl = 'https://pokeapi.co/api/v2'; // Define a URL base da API.

  Future<List<PokemonListItem>> fetchPokemonList({int limit = 50}) async { // Busca lista de Pokemon com limite.
    final uri = Uri.parse('$_baseUrl/pokemon?limit=$limit'); // Monta a URL com o limite.
    final response = await http.get(uri); // Faz a requisicao HTTP GET.

    if (response.statusCode != 200) { // Verifica se a resposta nao foi sucesso.
      throw Exception('Erro ao carregar lista de pokemons'); // Lanca erro em caso de falha.
    } // Fecha o bloco do if.

    final jsonBody = jsonDecode(response.body) as Map<String, dynamic>; // Converte o corpo JSON em mapa.
    final results = jsonBody['results'] as List<dynamic>; // Extrai a lista de resultados.

    return results // Retorna a lista convertida.
        .map((item) => PokemonListItem.fromJson(item as Map<String, dynamic>)) // Converte cada item em modelo.
        .toList(); // Converte o iteravel em lista.
  } // Fecha o metodo fetchPokemonList.

  Future<PokemonDetail> fetchPokemonDetail(String name) async { // Busca detalhes de um Pokemon pelo nome.
    final uri = Uri.parse('$_baseUrl/pokemon/$name'); // Monta a URL com o nome.
    final response = await http.get(uri); // Faz a requisicao HTTP GET.

    if (response.statusCode != 200) { // Verifica se a resposta nao foi sucesso.
      throw Exception('Erro ao carregar detalhes do pokemon'); // Lanca erro em caso de falha.
    } // Fecha o bloco do if.

    final jsonBody = jsonDecode(response.body) as Map<String, dynamic>; // Converte o corpo JSON em mapa.
    return PokemonDetail.fromJson(jsonBody); // Converte o JSON em modelo de detalhes.
  } // Fecha o metodo fetchPokemonDetail.
} // Fecha a classe PokemonApiService.
