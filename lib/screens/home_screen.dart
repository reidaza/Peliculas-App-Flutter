import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';

//Importaciones Propias
import 'package:peliculas_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  
  @override
  Widget build(BuildContext context) {


    final moviesProvider = Provider.of<MoviesProvider>(context);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Tarjetas Principales
            CardSwiper(movies: moviesProvider.onDisplayMovies ),
            //Slider de pelicular
            MovieSlider(
              movies: moviesProvider.popularMovies,//De donde traigo las peliculas
              title: 'Populares'
            ),
            //Listado horizontal de peliculas
          ],
        ),
      )
    );
  }
}