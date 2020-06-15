import 'package:flutter/material.dart';
import 'package:news_provider/src/pages/tab1_page.dart';
import 'package:news_provider/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel() ,
          child: Scaffold(
        body: _Pagina(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i){
        navegacionModel.paginaActual = i;
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text ("Para ti") ),
        BottomNavigationBarItem(icon: Icon(Icons.public), title: Text ("Encabezados") ),
      ]);
  }
}

class _Pagina extends StatelessWidget {
  const _Pagina({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2Page(),
        
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier{
  int _paginaActual = 0;
  PageController _pageController = PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual (int valor){
    this._paginaActual = valor;
    notifyListeners();

    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);

  }

  PageController get pageController => this._pageController;

}