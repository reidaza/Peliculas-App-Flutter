import 'package:flutter/material.dart';

//Importaciones Propias
import 'package:peliculas_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Peliculas en cines '),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.search_outlined),
            )
        ],
      ),
      body: Column(
        children: [
          CardSwiper(),

          //Listado horizontal de peliculas
        ],
      )
    );
  }
}