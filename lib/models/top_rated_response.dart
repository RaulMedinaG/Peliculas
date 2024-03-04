import 'dart:convert';

import 'package:peliculas/models/movie.dart';

class TopRatedResponse {
    final int page;
    final List<Movie> results;
    final int totalPages;
    final int totalResults;

    TopRatedResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory TopRatedResponse.fromJson(String str) => 
      TopRatedResponse.fromMap(json.decode(str));

    factory TopRatedResponse.fromMap(Map<String, dynamic> json) => 
      TopRatedResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

}