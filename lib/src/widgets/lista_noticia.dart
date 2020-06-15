import 'package:flutter/material.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:news_provider/src/theme/theme.dart';

class ListaNoticia extends StatelessWidget {
  final List<Article> noticias;

  ListaNoticia(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(
          articulo: noticias[index],
          index: index,
        );
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article articulo;
  final int index;

  _Noticia({@required this.articulo, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar(articulo, index),
        _TarjetaTitulo(articulo),
        _TarjetaImagen(articulo),
        _TarjetaBody(articulo),
        _TarjetaBotones()
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        RawMaterialButton(
          onPressed: (){}, 
          fillColor: miTema.accentColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0) ),
          child: Icon(Icons.star_border),
        ),
        SizedBox( 
          width: 10,
         ),
        RawMaterialButton(
          onPressed: (){}, 
          fillColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0) ),
          child: Icon(Icons.more),
        ),
      ],)
    );
  }
}

class _TarjetaBody extends StatelessWidget {

   final Article articulo;

  _TarjetaBody(this.articulo);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(articulo.description  ?? "" ),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article articulo;

  _TarjetaImagen(this.articulo);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft:  Radius.circular(50.0),  bottomRight: Radius.circular(50) ) ,
            child: Container(
            child: FadeInImage(
                placeholder: AssetImage("assets/giphy.gif"),
                image: articulo.urlToImage != null
                    ? NetworkImage(articulo.urlToImage)
                    : Image(image: AssetImage("assets/no-image.png")))),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article articulo;

  const _TarjetaTitulo(this.articulo);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        articulo.title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article articulo;
  final int indice;

  const _TarjetaTopBar(this.articulo, this.indice);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            "${indice + 1} ",
            style: TextStyle(color: miTema.accentColor),
          ),
          Text(
            "${articulo.source.name}",
          )
        ],
      ),
    );
  }
}
