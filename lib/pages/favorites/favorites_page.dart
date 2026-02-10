import 'package:flutter/material.dart'; // Importa os widgets do Material Design.
import '../../models/pokemon_model.dart'; // Importa o modelo de dados do Pokemon.
import '../../services/pokemon_api_service.dart'; // Importa o servico de API do Pokemon.
import '../../stores/favorites_store.dart'; // Importa o store de favoritos.
import '../details/details_page.dart'; // Importa a pagina de detalhes.

class FavoritesPage extends StatelessWidget { // Declara a pagina de favoritos como widget sem estado.
  const FavoritesPage({super.key, this.onBackToHome}); // Construtor com callback opcional.

  final VoidCallback? onBackToHome; // Define o callback para voltar a Home.

  static final PokemonApiService _service = PokemonApiService(); // Instancia estatica do servico.

  String _capitalizeFirstLetter(String value) { // Metodo para capitalizar a primeira letra.
    if (value.isEmpty) { // Verifica se a string esta vazia.
      return value; // Retorna a string vazia sem alterar.
    } // Fecha o bloco do if.
    return value[0].toUpperCase() + value.substring(1).toLowerCase(); // Capitaliza e ajusta o restante.
  } // Fecha o metodo _capitalizeFirstLetter.

  @override // Indica a sobrescrita do metodo da classe base.
  Widget build(BuildContext context) { // Constroi a interface da tela.
    return Scaffold( // Retorna a estrutura basica da pagina.
      appBar: AppBar( // Cria a barra superior.
        leading: IconButton( // Define o botao de voltar.
          icon: const Icon(Icons.arrow_back), // Usa o icone de seta.
          onPressed: () { // Define a acao do botao.
            if (onBackToHome != null) { // Verifica se ha callback para Home.
              onBackToHome!(); // Chama o callback.
              return; // Sai do handler apos chamar o callback.
            } // Fecha o bloco do if.

            if (Navigator.canPop(context)) { // Verifica se pode voltar na pilha.
              Navigator.pop(context); // Volta para a tela anterior.
            } // Fecha o bloco do if.
          }, // Fecha o onPressed.
        ), // Fecha o IconButton.

        title: const Text('Favoritos'), // Define o titulo da pagina.
        centerTitle: true, // Centraliza o titulo.
      ), // Fecha o AppBar.

      body: ValueListenableBuilder<Set<String>>( // Reage a mudancas nos favoritos.
        valueListenable: FavoritesStore.favorites, // Observa o store de favoritos.
        builder: (context, favorites, _) { // Construtor baseado nos favoritos.
          final items = favorites.toList()..sort(); // Converte para lista e ordena.

          if (items.isEmpty) { // Verifica se a lista esta vazia.
            return const Center(child: Text('Nenhum favorito ainda.')); // Exibe mensagem de vazio.
          } // Fecha o bloco do if.

          return GridView.builder( // Constroi um grid de favoritos.
            padding: const EdgeInsets.all(12), // Define o padding do grid.
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // Configura o layout do grid.
              crossAxisCount: 2, // Define duas colunas.
              crossAxisSpacing: 12, // Define espaco horizontal.
              mainAxisSpacing: 12, // Define espaco vertical.
              childAspectRatio: 0.9, // Define a proporcao dos itens.
            ), // Fecha o gridDelegate.

            itemCount: items.length, // Informa quantos itens existem.
            itemBuilder: (context, index) { // Construtor de cada item.
              final name = items[index]; // Recupera o nome do item.

              return FutureBuilder<PokemonDetail>( // Carrega detalhes do Pokemon.
                future: _service.fetchPokemonDetail(name), // Dispara a busca na API.
                builder: (context, snapshot) { // Construtor baseado no snapshot.
                  final detail = snapshot.data; // Recupera o detalhe quando disponivel.

                  return InkWell( // Torna o card clicavel.
                    borderRadius: BorderRadius.circular(16), // Define bordas arredondadas no toque.
                    onTap: () { // Define a acao de toque.
                      Navigator.push( // Navega para a tela de detalhes.
                        context, // Usa o contexto atual.
                        MaterialPageRoute( // Cria a rota de material.
                          builder: (_) => DetailsPage(pokemonName: name), // Constroi a tela de detalhes.
                        ), // Fecha o MaterialPageRoute.
                      ); // Fecha o Navigator.push.
                    }, // Fecha o onTap.

                    child: Container( // Cria o container do card.
                      decoration: BoxDecoration( // Define a decoracao do container.
                        color: const Color(0xFFFFF6F6), // Define a cor de fundo.
                        borderRadius: BorderRadius.circular(16), // Define cantos arredondados.
                        border: Border.all(color: const Color(0xFFF0E3E3)), // Define a borda.
                      ), // Fecha o BoxDecoration.

                      child: Stack( // Empilha widgets.
                        children: [ // Lista de widgets empilhados.
                          Padding( // Adiciona padding interno.
                            padding: const EdgeInsets.all(12), // Define o padding.
                            child: Column( // Organiza o conteudo em coluna.
                              mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente.
                              children: [ // Lista de widgets da coluna.
                                if (detail != null && detail.imageUrl.isNotEmpty) // Verifica se ha imagem.
                                  Expanded( // Expande a area da imagem.
                                    child: Image.network( // Exibe a imagem remota.
                                      detail.imageUrl, // Usa a URL da imagem.
                                      fit: BoxFit.contain, // Ajusta a imagem sem cortar.
                                    ), // Fecha o Image.network.
                                  ) // Fecha o Expanded.

                                else // Caso nao haja imagem.
                                  const Expanded( // Expande o placeholder.
                                    child: Center( // Centraliza o indicador.
                                      child: SizedBox( // Define o tamanho do indicador.
                                        width: 28, // Largura do indicador.
                                        height: 28, // Altura do indicador.
                                        child: CircularProgressIndicator(strokeWidth: 2), // Mostra carregamento.
                                      ), // Fecha o SizedBox.
                                    ), // Fecha o Center.
                                  ), // Fecha o Expanded.

                                const SizedBox(height: 8), // Adiciona espaco vertical.
                                Text( // Exibe o nome do Pokemon.
                                  _capitalizeFirstLetter(name), // Capitaliza o nome.
                                  maxLines: 1, // Limita a uma linha.
                                  overflow: TextOverflow.ellipsis, // Corta com reticencias se exceder.
                                  style: const TextStyle( // Define o estilo do texto.
                                    fontWeight: FontWeight.bold, // Deixa o texto em negrito.
                                  ), // Fecha o TextStyle.
                                ), // Fecha o widget Text.
                              ], // Fecha a lista de filhos da coluna.
                            ), // Fecha o Column.
                          ), // Fecha o Padding.

                          Positioned( // Posiciona o botao de remover.
                            top: 4, // Define a posicao no topo.
                            right: 4, // Define a posicao a direita.
                            child: IconButton( // Cria o botao de remover.
                              icon: const Icon(Icons.delete_outline), // Define o icone do botao.
                              onPressed: () => FavoritesStore.remove(name), // Remove o item dos favoritos.
                            ), // Fecha o IconButton.
                          ), // Fecha o Positioned.
                          
                        ], // Fecha a lista do Stack.
                      ), // Fecha o Stack.
                    ), // Fecha o Container.
                  ); // Fecha o InkWell.
                }, // Fecha o builder.
              ); // Fecha o FutureBuilder.
            }, // Fecha o itemBuilder.
          ); // Fecha o GridView.builder.
        }, // Fecha o builder do ValueListenableBuilder.
      ), // Fecha o ValueListenableBuilder.
    ); // Fecha o Scaffold.
  } // Fecha o metodo build.
} // Fecha a classe FavoritesPage.
