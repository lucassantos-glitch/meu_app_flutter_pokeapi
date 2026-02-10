import 'package:flutter/material.dart'; // Importa os widgets do Material Design.
import '../../models/pokemon_model.dart'; // Importa os modelos de dados do Pokemon.
import '../../services/pokemon_api_service.dart'; // Importa o servico de API do Pokemon.
import '../../stores/favorites_store.dart'; // Importa o store de favoritos.

class DetailsPage extends StatefulWidget { // Declara a pagina de detalhes como widget com estado.
  final String pokemonName; // Define o nome do Pokemon recebido pela tela.

  const DetailsPage({super.key, required this.pokemonName}); // Construtor que exige o nome do Pokemon.

  @override // Indica a sobrescrita do metodo da classe base.
  State<DetailsPage> createState() => _DetailsPageState(); // Cria o estado associado a tela.
} // Fecha a classe DetailsPage.

class _DetailsPageState extends State<DetailsPage> { // Declara a classe de estado da pagina.
  final PokemonApiService _service = PokemonApiService(); // Instancia o servico para buscar dados na API.
  late Future<PokemonDetail> _futureDetail; // Declara o Future que carregara os detalhes.

  String _formatHeight(int height) { // Metodo para formatar a altura.
    final meters = height / 10; // Converte decimetros para metros.
    return '${meters.toStringAsFixed(1)} m'; // Retorna a altura formatada com uma casa decimal.
  } // Fecha o metodo _formatHeight.

  String _formatWeight(int weight) { // Metodo para formatar o peso.
    final kg = weight / 10; // Converte hectogramas para quilogramas.
    return '${kg.toStringAsFixed(1)} kg'; // Retorna o peso formatado com uma casa decimal.
  } // Fecha o metodo _formatWeight.

  String _capitalize(String value) { // Metodo para capitalizar a primeira letra.
    if (value.isEmpty) { // Verifica se a string esta vazia.
      return value; // Retorna a string vazia sem alterar.
    } // Fecha o bloco do if.
    return value[0].toUpperCase() + value.substring(1); // Retorna com a primeira letra maiuscula.
  } // Fecha o metodo _capitalize.

  @override // Indica a sobrescrita do metodo da classe base.
  void initState() { // Metodo executado ao iniciar o estado.
    super.initState(); // Chama a inicializacao da classe pai.
    _futureDetail = _service.fetchPokemonDetail(widget.pokemonName); // Inicia a busca dos detalhes na API.
  } // Fecha o metodo initState.

  @override // Indica a sobrescrita do metodo da classe base.
  Widget build(BuildContext context) { // Constroi a interface da tela.
    return Scaffold( // Retorna a estrutura basica da pagina.
      appBar: AppBar( // Cria a barra superior.
        title: Text(widget.pokemonName.toUpperCase()), // Exibe o nome do Pokemon em maiusculas.
      ), // Fecha o AppBar.

      body: FutureBuilder<PokemonDetail>( // Construtor que reage ao Future de detalhes.
        future: _futureDetail, // Informa o Future a ser observado.
        builder: (context, snapshot) { // Construtor de interface baseado no snapshot.
          if (snapshot.connectionState == ConnectionState.waiting) { // Verifica se esta carregando.
            return const Center(child: CircularProgressIndicator()); // Mostra o indicador de carregamento.
          } // Fecha o bloco do if.

          if (snapshot.hasError || !snapshot.hasData) { // Verifica erro ou ausencia de dados.
            return const Center(child: Text('Erro ao carregar detalhes.')); // Exibe mensagem de erro.
          } // Fecha o bloco do if.

          final detail = snapshot.data!; // Recupera os detalhes do Pokemon do snapshot.
          final textTheme = Theme.of(context).textTheme; // Obtém o tema de texto atual.

          return ListView( // Retorna uma lista rolavel para o conteudo.
            padding: const EdgeInsets.all(16), // Define o padding interno da lista.
            children: [ // Define os widgets filhos da lista.
              if (detail.imageUrl.isNotEmpty) // Verifica se ha URL de imagem.
                Image.network( // Exibe a imagem remota.
                  detail.imageUrl, // Usa a URL da imagem.
                  height: 200, // Define a altura da imagem.
                  fit: BoxFit.contain, // Ajusta a imagem para caber sem cortar.
                ), // Fecha o widget Image.network.

              const SizedBox(height: 24), // Adiciona espaco vertical.
              Text( // Exibe o nome do Pokemon.
                _capitalize(detail.name), // Aplica capitalizacao no nome.
                style: textTheme.headlineSmall?.copyWith( // Define o estilo do texto.
                  fontWeight: FontWeight.bold, // Deixa o texto em negrito.
                  letterSpacing: 0.6, // Ajusta o espacamento entre letras.
                  fontSize: 30, // Define o tamanho da fonte.
                ), // Fecha o copyWith.

                textAlign: TextAlign.center, // Centraliza o texto.
              ), // Fecha o widget Text.

              const SizedBox(height: 16), // Adiciona espaco vertical.
              Text( // Exibe o titulo da secao.
                'Informações Gerais', // Texto do titulo.
                style: textTheme.titleMedium?.copyWith( // Define o estilo do titulo.
                  fontWeight: FontWeight.w600, // Define o peso da fonte.
                  fontSize: 20, // Define o tamanho da fonte.
                ), // Fecha o copyWith.
              ), // Fecha o widget Text.

              const SizedBox(height: 16), // Adiciona espaco vertical.
              Text( // Exibe o ID formatado.
                'ID: ${detail.id.toString().padLeft(3, '0')}', // Formata o ID com 3 digitos.
                style: textTheme.bodyMedium?.copyWith(fontSize: 18), // Define o estilo do texto.
              ), // Fecha o widget Text.

              const SizedBox(height: 1), // Adiciona um pequeno espaco.
              Text( // Exibe a altura.
                'Altura: ${_formatHeight(detail.height)}', // Formata e mostra a altura.
                style: textTheme.bodyMedium?.copyWith(fontSize: 18), // Define o estilo do texto.
              ), // Fecha o widget Text.

              const SizedBox(height: 1), // Adiciona um pequeno espaco.
              Text( // Exibe o peso.
                'Peso: ${_formatWeight(detail.weight)}', // Formata e mostra o peso.
                style: textTheme.bodyMedium?.copyWith(fontSize: 18), // Define o estilo do texto.
              ), // Fecha o widget Text.

              const SizedBox(height: 1), // Adiciona um pequeno espaco.
              Text( // Exibe os tipos do Pokemon.
                'Tipos: ${detail.types.map(_capitalize).join(', ')}', // Capitaliza e junta os tipos.
                style: textTheme.bodyMedium?.copyWith(fontSize: 18), // Define o estilo do texto.
              ), // Fecha o widget Text.

              const SizedBox(height: 25), // Adiciona espaco antes do botao.
              ValueListenableBuilder<Set<String>>( // Reage a mudancas na lista de favoritos.
                valueListenable: FavoritesStore.favorites, // Observa o store de favoritos.
                builder: (context, favorites, _) { // Constroi baseado nos favoritos atuais.
                  final isFavorite = favorites.contains(detail.name); // Verifica se o Pokemon esta favoritado.

                  return ElevatedButton.icon( // Cria um botao com icone.
                    onPressed: () { // Define a acao do botao.
                      FavoritesStore.toggle(detail.name); // Alterna o estado de favorito.
                    }, // Fecha o onPressed.
                    
                    icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border), // Define o icone conforme favorito.
                    label: Text(isFavorite ? 'DESFAVORITAR' : 'FAVORITAR'), // Define o texto conforme favorito.
                  ); // Fecha o ElevatedButton.icon.
                }, // Fecha o builder.
              ), // Fecha o ValueListenableBuilder.
            ], // Fecha a lista de filhos.
          ); // Fecha o ListView.
        }, // Fecha o builder do FutureBuilder.
      ), // Fecha o FutureBuilder.
    ); // Fecha o Scaffold.
  } // Fecha o metodo build.
} // Fecha a classe _DetailsPageState.
