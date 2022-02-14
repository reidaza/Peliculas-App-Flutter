//Buscador para que tiene como fin proveer informacion a la app, trayendola desde el la api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  String _baseUrl = 'api.themoviedb.org';
  String _apikey = 'c04f6d02962ee8ca94519bf5b8e5ad44';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  MoviesProvider(){
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async{
    //Peliculas que vamos a estar mostrando
    var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
      'page': '1'
    });
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    // print(nowPlayingResponse.results[1].title);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }
}