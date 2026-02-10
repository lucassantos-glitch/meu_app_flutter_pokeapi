import 'package:flutter/material.dart'; // Importa os widgets do Material Design.
import '../favorites/favorites_page.dart'; // Importa a pagina de favoritos.
import '../home/home_page.dart'; // Importa a pagina inicial.

class MainNavigationPage extends StatefulWidget { // Declara a pagina com navegacao por abas.
  const MainNavigationPage({super.key}); // Construtor constante da pagina.

  @override // Indica a sobrescrita do metodo da classe base.
  State<MainNavigationPage> createState() => _MainNavigationPageState(); // Cria o estado da pagina.
} // Fecha a classe MainNavigationPage.

class _MainNavigationPageState extends State<MainNavigationPage> { // Declara a classe de estado.
  int _currentIndex = 0; // Define o indice da aba atual.

  void _setIndex(int index) { // Metodo para atualizar o indice da aba.
    setState(() { // Atualiza o estado da interface.
      _currentIndex = index; // Define o novo indice.
    }); // Fecha o setState.
  } // Fecha o metodo _setIndex.

  @override // Indica a sobrescrita do metodo da classe base.
  Widget build(BuildContext context) { // Constroi a interface da pagina.
    return Scaffold( // Retorna a estrutura basica da pagina.
      body: IndexedStack( // Mantem o estado das paginas ao trocar abas.
        index: _currentIndex, // Define qual pagina esta visivel.
        children: [ // Lista de paginas das abas.
          const HomePage(), // Pagina inicial.
          FavoritesPage(onBackToHome: () => _setIndex(0)), // Pagina de favoritos com callback.
        ], // Fecha a lista de paginas.
      ), // Fecha o IndexedStack.

      bottomNavigationBar: BottomNavigationBar( // Define a barra de navegacao inferior.
        currentIndex: _currentIndex, // Define a aba selecionada.
        onTap: _setIndex, // Atualiza o indice ao tocar.
        items: const [ // Define os itens da barra.
          BottomNavigationBarItem( // Item da aba Home.
            icon: Icon(Icons.home), // Icone da aba Home.
            label: 'Home', // Rotulo da aba Home.
          ), // Fecha o item Home.

          BottomNavigationBarItem( // Item da aba Favoritos.
            icon: Icon(Icons.favorite), // Icone da aba Favoritos.
            label: 'Favoritos', // Rotulo da aba Favoritos.
          ), // Fecha o item Favoritos.
        ], // Fecha a lista de itens.
        
      ), // Fecha o BottomNavigationBar.
    ); // Fecha o Scaffold.
  } // Fecha o metodo build.
} // Fecha a classe _MainNavigationPageState.
