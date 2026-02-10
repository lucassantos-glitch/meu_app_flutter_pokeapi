class PokemonListItem { // Declara a classe que representa um item simples da lista de Pokemon.
  final String name; // Define o campo imutavel para o nome do Pokemon.
  final String url; // Define o campo imutavel para a URL associada ao Pokemon.

  const PokemonListItem({required this.name, required this.url}); // Construtor constante exigindo nome e URL.

  factory PokemonListItem.fromJson(Map<String, dynamic> json) { // Fabrica que cria a instancia a partir de JSON.
    return PokemonListItem( // Retorna uma nova instancia de PokemonListItem.
      name: json['name'] as String, // Extrai o nome do JSON e faz cast para String.
      url: json['url'] as String, // Extrai a URL do JSON e faz cast para String.
    ); // Fecha a chamada do construtor da instancia.
  } // Fecha o metodo factory.
} // Fecha a classe PokemonListItem.

class PokemonDetail { // Declara a classe que representa os detalhes de um Pokemon.
  final int id; // Define o campo imutavel para o ID do Pokemon.
  final String name; // Define o campo imutavel para o nome do Pokemon.
  final int height; // Define o campo imutavel para a altura do Pokemon.
  final int weight; // Define o campo imutavel para o peso do Pokemon.
  final List<String> types; // Define o campo imutavel para a lista de tipos do Pokemon.
  final String imageUrl; // Define o campo imutavel para a URL da imagem do Pokemon.

  const PokemonDetail({ // Inicia o construtor constante com parametros nomeados.
    required this.id, // Exige o ID para criar a instancia.
    required this.name, // Exige o nome para criar a instancia.
    required this.height, // Exige a altura para criar a instancia.
    required this.weight, // Exige o peso para criar a instancia.
    required this.types, // Exige a lista de tipos para criar a instancia.
    required this.imageUrl, // Exige a URL da imagem para criar a instancia.
  }); // Fecha o construtor.

  factory PokemonDetail.fromJson(Map<String, dynamic> json) { // Fabrica que cria detalhes a partir de JSON.
    final sprites = json['sprites'] as Map<String, dynamic>?; // Le o mapa de sprites, podendo ser nulo.
    final other = sprites?['other'] as Map<String, dynamic>?; // Le a secao "other" se existir.
    final official = other?['official-artwork'] as Map<String, dynamic>?; // Le "official-artwork" se existir.
    final imageUrl = (official?['front_default'] ?? sprites?['front_default']) as String? ?? ''; // Define a URL da imagem com fallback e vazio.

    final typesJson = json['types'] as List<dynamic>? ?? []; // Le a lista de tipos ou usa lista vazia.
    final types = typesJson // Inicia o processamento da lista de tipos.
        .map((item) => (item as Map<String, dynamic>)['type'] as Map<String, dynamic>) // Extrai o mapa "type" de cada item.
        .map((type) => type['name'] as String) // Extrai o nome do tipo como String.
        .toList(); // Converte o iteravel em lista de Strings.

    return PokemonDetail( // Retorna uma nova instancia de PokemonDetail.
      id: json['id'] as int, // Extrai o ID do JSON e faz cast para int.
      name: json['name'] as String, // Extrai o nome do JSON e faz cast para String.
      height: json['height'] as int, // Extrai a altura do JSON e faz cast para int.
      weight: json['weight'] as int, // Extrai o peso do JSON e faz cast para int.
      types: types, // Atribui a lista de tipos processada.
      imageUrl: imageUrl, // Atribui a URL da imagem calculada.
    ); // Fecha a chamada do construtor da instancia.
  } // Fecha o metodo factory.
} // Fecha a classe PokemonDetail.
