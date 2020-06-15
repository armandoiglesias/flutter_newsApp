import 'package:flutter/material.dart';
import 'package:news_provider/src/services/new_service.dart';
import 'package:news_provider/src/widgets/lista_noticia.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {

    final newService = Provider.of<NewService>(context);



    return Scaffold(
      body: 
        newService.headlines.length == 0 
        ? Center(child: CircularProgressIndicator(),)
        :ListaNoticia(newService.headlines)
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}