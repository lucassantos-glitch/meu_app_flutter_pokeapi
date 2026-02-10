import 'package:flutter/material.dart'; // Importa os widgets do Material Design.
import '../main_navigation/main_navigation_page.dart'; // Importa a pagina de navegacao principal.

class EntryPage extends StatelessWidget { // Declara a pagina de entrada como widget sem estado.
  const EntryPage({super.key}); // Construtor constante da pagina.

  @override // Indica a sobrescrita do metodo da classe base.
  Widget build(BuildContext context) { // Constroi a interface da tela.
    return Scaffold( // Retorna a estrutura basica da pagina.
      body: Stack( // Empilha widgets na tela.
        children: [ // Lista de widgets empilhados.
          Positioned.fill( // Faz o filho preencher todo o espaco.
            child: Image.asset( // Exibe uma imagem local.
              'lib/assets/images/pokeapi_logo.png', // Caminho da imagem.
              fit: BoxFit.cover, // Ajusta a imagem para cobrir.
            ), // Fecha o Image.asset.
          ), // Fecha o Positioned.fill.

          Center( // Centraliza o conteudo.
            child: Padding( // Adiciona padding ao conteudo.
              padding: const EdgeInsets.all(24), // Define o padding.
              child: Column( // Organiza o conteudo em coluna.
                mainAxisAlignment: MainAxisAlignment.end, // Alinha ao final da coluna.
                children: [ // Lista de widgets da coluna.
                  const SizedBox(height: 32), // Adiciona espaco vertical.
                  SizedBox( // Define o tamanho do botao.
                    width: double.infinity, // Faz o botao ocupar toda a largura.
                    child: ElevatedButton( // Cria um botao elevado.
                      onPressed: () { // Define a acao ao clicar.
                        Navigator.pushReplacement( // Substitui a tela atual pela principal.
                          context, // Usa o contexto atual.
                          MaterialPageRoute( // Cria a rota de material.
                            builder: (_) => const MainNavigationPage(), // Constroi a pagina principal.
                          ), // Fecha o MaterialPageRoute.
                        ); // Fecha o Navigator.pushReplacement.
                      }, // Fecha o onPressed.

                      child: const Padding( // Adiciona padding interno ao texto.
                        padding: EdgeInsets.symmetric(vertical: 20), // Define o padding vertical.
                        child: Text('ENTRAR'), // Exibe o texto do botao.
                      ), // Fecha o Padding.
                      
                    ), // Fecha o ElevatedButton.
                  ), // Fecha o SizedBox.
                ], // Fecha a lista de filhos da coluna.
              ), // Fecha o Column.
            ), // Fecha o Padding.
          ), // Fecha o Center.
        ], // Fecha a lista do Stack.
      ), // Fecha o Stack.
    ); // Fecha o Scaffold.
  } // Fecha o metodo build.
} // Fecha a classe EntryPage.
