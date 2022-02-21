//Buscador para que tiene como fin proveer informacion a la app, trayendola desde el la api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/models/search_response.dart';

class MoviesProvider extends ChangeNotifier{

  String _baseUrl = 'api.themoviedb.org';
  String _apikey = 'c04f6d02962ee8ca94519bf5b8e5ad44';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  
  Map<int, List<Cast>> moviesCast = {};
  
  int _popularPage = 0; 

  
  MoviesProvider(){
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }
  Future <String> _getJsonData(String endpoint, [int page = 1]) async{
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apikey,
      'language': _language,
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;
  }
  getOnDisplayMovies() async{
    //Peliculas que vamos a estar mostrando
    final jsonData = await _getJsonData('/3/movie/now_playing');
    // Await the http get response, then decode the json-formatted response.
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    // print(nowPlayingResponse.results[1].title);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async{
    _popularPage ++; 
    //Peliculas que vamos a estar mostrando
    final jsonData = await _getJsonData('/3/movie/popular', _popularPage);
    // Await the http get response, then decode the json-formatted response.
    final popularResponse = PopularResponse.fromJson(jsonData);

    // print(nowPlayingResponse.results[1].title);
    popularMovies = [...popularMovies, ...popularResponse.results];
    print(popularMovies[0]);
    notifyListeners();
  }

  Future <List <Cast> > getMovieCast (int movieId) async{
    //TODO: Revisar mapa 
    if( moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    print('Pidiendo info al servidor sobre actores');
    final jsonData = await _getJsonData('/3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future <List <Movie>> searhMovies(String query) async{
    
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }


}