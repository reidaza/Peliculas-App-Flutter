import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:provider/provider.dart';
import 'package:peliculas_app/providers/movies_provider.dart';


class MovieSearchDelegate extends SearchDelegate{

  @override
  String? get searchFieldLabel => 'Buscar Pelicula';

  @override
  //Tambien botones, en este caso borra lo que escribi
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
        )
    ];
  }

  @override
  //Se puede construir mediante un boton, sirve para volver a la pantalla principal 
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      }, 
    );
  }

  @override
  //Regresa un listview con los resultados
  Widget buildResults(BuildContext context) {
    return Text('BuildResults');
  }
  Widget _emptyContainer(){
    return Container(
        child: Center(
          child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130),
        ),
      );
  }
  @override
  //Sugiere lo que estemos buscando
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty){
      return _emptyContainer();
    }
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.searhMovies(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot){
        if (!snapshot.hasData) return _emptyContainer();
        final movies = snapshot.data!;
        
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_ , int index) => _MovieItem(movies[index]),
        );
      },
    );
  }

}


class _MovieItem extends StatelessWidget {
  
  final Movie movie;
  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: AssetImage('assets/no-image.jpg'), 
        image: NetworkImage(movie.fullPosterImg),
        width: 50,
        fit: BoxFit.contain,
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: (){
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}