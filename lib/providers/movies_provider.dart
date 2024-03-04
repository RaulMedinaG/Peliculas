import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:peliculas/models/credits_response.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/models/now_playing_response.dart';
import 'package:peliculas/models/popular_response.dart';
import 'package:peliculas/models/search_movie_response.dart';
import 'package:peliculas/models/top_rated_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _urlBase = 'api.themoviedb.org';
  String _apiKey = '6e926ddafe3bed379fa0c907c2d9040e';
  String _language = 'es-ES';

  int _popularPage = 0;

  List<Movie> enCines = [];
  List<Movie> populares = [];
  List<Movie> top_rated = [];
  List<Movie> up_coming = [];

  Map<int, List<Cast>> moviesCast = {};

  Future<List<Cast>> getMoviesCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) {
      return moviesCast[movieId]!;
    }
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId]  = creditsResponse.cast;
    return creditsResponse.cast;
  }

  MoviesProvider() {
    print('MoviesProvider inicializado');
    getEnCinesMovies();
    getPopularMovies();
    getTopRatedMovies();
    getUpComingMovies();
  }

  Future<List<Movie>> searchMovie(String query) async{
    var url = Uri.https(_urlBase, '3/search/movie',
      {'api_key': _apiKey, 'language': _language, 'query': '$query'});
    final response = await get(url);
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final searchMovieResponse = SearchMovieResponse.fromJson(jsonData);
    return searchMovieResponse.results;
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_urlBase, endpoint,
      {'api_key': _apiKey, 'language': _language, 'page': '$page'});
      Response response = await get(url);
      return response.body;
  }

  getEnCinesMovies() async {
    var url = Uri.https(_urlBase, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    Response response = await get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    // print(nowPlayingResponse.results[0].title);
    enCines = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_urlBase, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    Response response = await get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    populares = [...populares, ...popularResponse.results];
    print(populares[0].title);
    notifyListeners();
  }

  getTopRatedMovies() async {
    var url = Uri.https(_urlBase, '3/movie/top_rated',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    Response response = await get(url);
    final popularResponse = TopRatedResponse.fromJson(response.body);
    top_rated = [...top_rated, ...popularResponse.results];
    print(top_rated[0].title);
    notifyListeners();
  }

  getUpComingMovies() async {
    var url = Uri.https(_urlBase, '3/movie/upcoming',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    Response response = await get(url);
    final up_comingResponse = TopRatedResponse.fromJson(response.body);
    up_coming = [...up_coming, ...up_comingResponse.results];
    print(up_coming[0].title);
    notifyListeners();
  }
}
