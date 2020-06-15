import 'package:flutter/material.dart';
import 'package:news_provider/src/models/category_model.dart';
import 'package:news_provider/src/services/new_service.dart';
import 'package:news_provider/src/theme/theme.dart';
import 'package:news_provider/src/widgets/lista_noticia.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewService>(context);

    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          _ListaCategorias(),
          Expanded(
              child: ListaNoticia(newsService.articulosCategoriaSeleccionada)),
        ],
      )),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categorias = Provider.of<NewService>(context).categorias;

    return Container(
      width: double.infinity,
      height: 80.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                _CategoryButton(categorias[index]),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                    "${categorias[index].name[0].toUpperCase()}${categorias[index].name.substring(1)}")
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewService>(context, listen: false);
    return GestureDetector(
      onTap: () {
        newsService.categoriaSeleccionada = categoria.name;
        //print(categoria.name);
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoria.icon,
          color: newsService.categoriaSeleccionada == categoria.name
              ? miTema.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
