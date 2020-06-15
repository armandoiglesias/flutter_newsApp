import 'package:flutter/material.dart';
import 'package:news_provider/src/models/category_model.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:http/http.dart' as http;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewService with ChangeNotifier{
  List<Article> headlines = [];
  final _urlBase = "http://newsapi.org/v2";
  final _apiKey = "0f3daa55ea604d74aab6502c0ed33dfe";

  List<Category> categorias = [
    Category(icon: FontAwesomeIcons.building, name: "business" ),
    Category(icon: FontAwesomeIcons.tv, name: "entertainment" ),
    Category(icon: FontAwesomeIcons.addressCard, name: "general" ),
    Category(icon: FontAwesomeIcons.headSideVirus, name: "health" ),
    Category(icon: FontAwesomeIcons.vials, name: "science" ),
    Category(icon: FontAwesomeIcons.volleyballBall, name: "sports" ),
    Category(icon: FontAwesomeIcons.memory, name: "technology" ),

  ];

  Map<String, List<Article>> articulosPorCategoria = {};

  String _selectedCategory = "business";

  String get categoriaSeleccionada => _selectedCategory;

  set categoriaSeleccionada(String valor){
    this._selectedCategory = valor;
    this.getArticulosPorCategoria(valor);
    notifyListeners();
  }

  List<Article> get articulosCategoriaSeleccionada => this.articulosPorCategoria[categoriaSeleccionada];

  getArticulosPorCategoria(String categoria) async{

    if (this.articulosPorCategoria[categoria].length > 0) {
      return this.articulosPorCategoria[categoria];
    }

    final url = "$_urlBase/top-headlines?country=ve&apiKey=$_apiKey&category=$categoria";

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    this.articulosPorCategoria[categoria].addAll(newsResponse.articles);

    //notifyListeners();
  }


  NewService(){
    this.getTopHeadlines();

    categorias.forEach((element) {
      this.articulosPorCategoria[element.name] = List();
    });
  }

  getTopHeadlines() async {
    final url = "$_urlBase/top-headlines?country=ve&apiKey=$_apiKey";

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();

  }
}