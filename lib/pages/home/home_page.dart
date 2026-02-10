import 'package:flutter/material.dart'; // Importa os widgets do Material Design.
import '../../models/pokemon_model.dart'; // Importa o modelo de dados do Pokemon.
import '../../services/pokemon_api_service.dart'; // Importa o servico de API do Pokemon.
import '../../stores/favorites_store.dart'; // Importa o store de favoritos.
import '../details/details_page.dart'; // Importa a pagina de detalhes.
import '../login/login_page.dart'; // Importa a pagina de login/entrada.

class PokedexHeader extends StatelessWidget { // Declara o cabecalho da tela inicial.
  const PokedexHeader({super.key}); // Construtor constante do cabecalho.

  @override // Indica a sobrescrita do metodo da classe base.
  Widget build(BuildContext context) { // Constroi o widget do cabecalho.
    return Container( // Retorna um container com estilo.
      padding: const EdgeInsets.only( // Define o padding do cabecalho.
        top: 50, // Define o padding superior.
        left: 16, // Define o padding esquerdo.
        right: 16, // Define o padding direito.
        bottom: 16, // Define o padding inferior.
      ), // Fecha o EdgeInsets.only.

      color: Colors.white, // Define a cor de fundo como branca.
      child: Column( // Organiza os elementos em coluna.
        crossAxisAlignment: CrossAxisAlignment.start, // Alinha a coluna a esquerda.
        children: [ // Lista de filhos da coluna.
          Row( // Cria uma linha para o topo.
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Separa os itens nas extremidades.
            children: [ // Lista de filhos da linha.
              InkWell( // Torna o widget clicavel.
                borderRadius: BorderRadius.circular(10), // Define o raio do toque.
                onTap: () { // Define a acao ao tocar.
                  Navigator.push( // Navega para outra tela.
                    context, // Usa o contexto atual.
                    MaterialPageRoute(builder: (_) => const EntryPage()), // Cria a rota para EntryPage.
                  ); // Fecha o Navigator.push.
                }, // Fecha o onTap.

                child: Container( // Cria o botao visual.
                  height: 40, // Define a altura do botao.
                  width: 40, // Define a largura do botao.
                  decoration: BoxDecoration( // Define a decoracao do botao.
                    color: Colors.red, // Define a cor de fundo vermelha.
                    borderRadius: BorderRadius.circular(10), // Define cantos arredondados.
                  ), // Fecha o BoxDecoration.

                  child: const Icon( // Define o icone do botao.
                    Icons.catching_pokemon, // Icone do Pokemon.
                    color: Colors.white, // Define a cor do icone.
                    size: 24, // Define o tamanho do icone.
                  ), // Fecha o Icon.

                ), // Fecha o Container.
              ), // Fecha o InkWell.
            ], // Fecha a lista de filhos da linha.
          ), // Fecha o Row.

          const SizedBox(height: 16), // Adiciona espaco vertical.
          const Text( // Exibe o texto de boas-vindas.
            'BEM-VINDO, TREINADOR !', // Texto exibido.
            style: TextStyle( // Define o estilo do texto.
              color: Colors.black54, // Define a cor do texto.
              fontSize: 16, // Define o tamanho da fonte.
            ), // Fecha o TextStyle.
          ), // Fecha o Text.

          const SizedBox(height: 4), // Adiciona espaco vertical.
          const Text( // Exibe o titulo principal.
            'Pokémon API', // Texto exibido.
            style: TextStyle( // Define o estilo do texto.
              color: Colors.black, // Define a cor do texto.
              fontSize: 26, // Define o tamanho da fonte.
              fontWeight: FontWeight.bold, // Define o peso da fonte.
            ), // Fecha o TextStyle.
          ), // Fecha o Text.

        ], // Fecha a lista de filhos da coluna.
      ), // Fecha o Column.
    ); // Fecha o Container.
  } // Fecha o metodo build.
} // Fecha a classe PokedexHeader.

class HomePage extends StatefulWidget { // Declara a pagina principal como widget com estado.
  const HomePage({super.key}); // Construtor constante da pagina.

  @override // Indica a sobrescrita do metodo da classe base.
  State<HomePage> createState() => _HomePageState(); // Cria o estado da pagina.
} // Fecha a classe HomePage.

class _HomePageState extends State<HomePage> { // Declara a classe de estado da HomePage.
  final PokemonApiService _service = PokemonApiService(); // Instancia o servico de API.
  late Future<List<PokemonListItem>> _futurePokemons; // Declara o Future da lista de Pokemon.

  int _extractIdFromUrl(String url) { // Metodo para extrair o ID da URL.
    final uri = Uri.parse(url); // Converte a string em URI.
    final segments = uri.pathSegments.where((segment) => segment.isNotEmpty).toList(); // Filtra segmentos validos.
    return int.tryParse(segments.isNotEmpty ? segments.last : '') ?? 0; // Converte o ultimo segmento em int.
  } // Fecha o metodo _extractIdFromUrl.

  Color _cardColorForIndex(int index) { // Metodo que define a cor do card pelo indice.
    const palette = [ // Define a paleta de cores.
      Color(0xFF7BDCB5), // Cor 1 da paleta.
      Color(0xFF6BCB77), // Cor 2 da paleta.
      Color(0xFFFF6B6B), // Cor 3 da paleta.
      Color(0xFF4D96FF), // Cor 4 da paleta.
      Color(0xFFFFD93D), // Cor 5 da paleta.
      Color(0xFFB983FF), // Cor 6 da paleta.
    ]; // Fecha a lista de cores.

    return palette[index % palette.length]; // Retorna uma cor baseada no indice.
  } // Fecha o metodo _cardColorForIndex.

  String _capitalizeFirstLetter(String value) { // Metodo para capitalizar a primeira letra.
    if (value.isEmpty) { // Verifica se a string esta vazia.
      return value; // Retorna a string vazia sem alterar.
    } // Fecha o bloco do if.
    return value[0].toUpperCase() + value.substring(1).toLowerCase(); // Capitaliza e ajusta o restante.
  } // Fecha o metodo _capitalizeFirstLetter.

  @override // Indica a sobrescrita do metodo da classe base.
  void initState() { // Metodo executado ao iniciar o estado.
    super.initState(); // Chama a inicializacao da classe pai.
    _futurePokemons = _service.fetchPokemonList(); // Inicia a busca da lista na API.
  } // Fecha o metodo initState.

  @override // Indica a sobrescrita do metodo da classe base.
  Widget build(BuildContext context) { // Constroi a interface da tela.
    return Scaffold( // Retorna a estrutura basica da pagina.
      body: Column( // Organiza o conteudo em coluna.
        children: [ // Lista de filhos da coluna.
          const PokedexHeader(), // Exibe o cabecalho.
          Expanded( // Ocupa o espaco restante com o conteudo.
            child: FutureBuilder<List<PokemonListItem>>( // Construtor baseado no Future.
              future: _futurePokemons, // Informa o Future a ser observado.
              builder: (context, snapshot) { // Construtor baseado no snapshot.
                if (snapshot.connectionState == ConnectionState.waiting) { // Verifica se esta carregando.
                  return const Center(child: CircularProgressIndicator()); // Exibe carregamento.
                } // Fecha o bloco do if.

                if (snapshot.hasError) { // Verifica se ocorreu erro.
                  return const Center(child: Text('Erro ao carregar a lista.')); // Exibe mensagem de erro.
                } // Fecha o bloco do if.

                final pokemons = snapshot.data ?? []; // Usa os dados ou lista vazia.

                return GridView.builder( // Constroi um grid com os Pokemon.
                  padding: const EdgeInsets.all(12), // Define o padding do grid.
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // Configura o layout do grid.
                    crossAxisCount: 2, // Define duas colunas.
                    crossAxisSpacing: 12, // Define espaco horizontal.
                    mainAxisSpacing: 12, // Define espaco vertical.
                    childAspectRatio: 0.85, // Define a proporcao dos itens.
                  ), // Fecha o gridDelegate.

                  itemCount: pokemons.length, // Informa quantos itens existem.
                  itemBuilder: (context, index) { // Construtor de cada item.
                    final pokemon = pokemons[index]; // Recupera o Pokemon pelo indice.
                    final id = _extractIdFromUrl(pokemon.url); // Extrai o ID a partir da URL.
                    final imageUrl = id == 0 // Verifica se o ID e valido.
                        ? null // Se invalido, nao define imagem.
                        : 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png'; // Define a URL da imagem.

                    return InkWell( // Torna o card clicavel.
                      borderRadius: BorderRadius.circular(16), // Define o raio do toque.
                      onTap: () { // Define a acao ao tocar.
                        Navigator.push( // Navega para a tela de detalhes.
                          context, // Usa o contexto atual.
                          MaterialPageRoute( // Cria a rota de material.
                            builder: (_) => DetailsPage(pokemonName: pokemon.name), // Constroi a tela de detalhes.
                          ), // Fecha o MaterialPageRoute.
                        ); // Fecha o Navigator.push.
                      }, // Fecha o onTap.

                      child: Ink( // Usa Ink para efeitos de toque.
                        decoration: BoxDecoration( // Define a decoracao do card.
                          color: _cardColorForIndex(index), // Define a cor do card.
                          borderRadius: BorderRadius.circular(16), // Define cantos arredondados.
                        ), // Fecha o BoxDecoration.

                        child: Stack( // Empilha widgets do card.
                          children: [ // Lista de widgets empilhados.
                            Padding( // Adiciona padding interno.
                              padding: const EdgeInsets.all(12), // Define o padding.
                              child: Column( // Organiza conteudo em coluna.
                                mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente.
                                crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente.
                                children: [ // Lista de widgets da coluna.
                                  Text( // Exibe o nome do Pokemon.
                                    _capitalizeFirstLetter(pokemon.name), // Capitaliza o nome.
                                    maxLines: 1, // Limita a uma linha.
                                    overflow: TextOverflow.ellipsis, // Corta com reticencias se exceder.
                                    style: const TextStyle( // Define o estilo do texto.
                                      color: Colors.white, // Define a cor do texto.
                                      fontSize: 22, // Define o tamanho da fonte.
                                      fontWeight: FontWeight.bold, // Define o texto em negrito.
                                    ), // Fecha o TextStyle.
                                  ), // Fecha o Text.

                                  const SizedBox(height: 8), // Adiciona espaco vertical.
                                  if (imageUrl != null) // Verifica se ha imagem.
                                    Expanded( // Expande a area da imagem.
                                      child: Image.network( // Exibe a imagem remota.
                                        imageUrl, // Usa a URL da imagem.
                                        width: 180, // Define a largura da imagem.
                                        height: 180, // Define a altura da imagem.
                                        fit: BoxFit.contain, // Ajusta a imagem sem cortar.
                                      ), // Fecha o Image.network.
                                    ), // Fecha o Expanded.

                                ], // Fecha a lista de filhos da coluna.
                              ), // Fecha o Column.
                            ), // Fecha o Padding.
                            
                            Positioned( // Posiciona o botao de favorito.
                              top: 8, // Define a posicao no topo.
                              right: 8, // Define a posicao a direita.
                              child: ValueListenableBuilder<Set<String>>( // Observa mudancas nos favoritos.
                                valueListenable: FavoritesStore.favorites, // Observa o store de favoritos.
                                builder: (context, favorites, _) { // Construtor baseado nos favoritos.
                                  final isFavorite = favorites.contains(pokemon.name); // Verifica se esta favoritado.
                                  return InkWell( // Torna o icone clicavel.
                                    onTap: () => FavoritesStore.toggle(pokemon.name), // Alterna o favorito.
                                    borderRadius: BorderRadius.circular(20), // Define o raio do toque.
                                    child: Padding( // Adiciona padding ao icone.
                                      padding: const EdgeInsets.all(6), // Define o padding.
                                      child: Icon( // Exibe o icone de favorito.
                                        isFavorite ? Icons.favorite : Icons.favorite_border, // Escolhe o icone.
                                        color: Colors.white, // Define a cor do icone.
                                        size: 24, // Define o tamanho do icone.
                                      ), // Fecha o Icon.
                                    ), // Fecha o Padding.
                                  ); // Fecha o InkWell.
                                }, // Fecha o builder.
                              ), // Fecha o ValueListenableBuilder.
                            ), // Fecha o Positioned.

                          ], // Fecha a lista do Stack.
                        ), // Fecha o Stack.
                      ), // Fecha o Ink.
                    ); // Fecha o InkWell.
                  }, // Fecha o itemBuilder.
                ); // Fecha o GridView.builder.
              }, // Fecha o builder do FutureBuilder.
            ), // Fecha o FutureBuilder.
          ), // Fecha o Expanded.
        ], // Fecha a lista de filhos da coluna.
      ), // Fecha o Column.
    ); // Fecha o Scaffold.
  } // Fecha o metodo build.
} // Fecha a classe _HomePageState.
