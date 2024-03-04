// To parse this JSON data, do
//
//     final nowPlayingResponse = nowPlayingResponseFromJson(jsonString);

import 'dart:convert';

import 'package:peliculas/models/movie.dart';

NowPlayingResponse nowPlayingResponseFromJson(String str) => NowPlayingResponse.fromJson(json.decode(str));

String nowPlayingResponseToJson(NowPlayingResponse data) => json.encode(data.toJson());

class NowPlayingResponse {
    final int page;
    final List<Movie> results;
    final int totalPages;
    final int totalResults;

    NowPlayingResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory NowPlayingResponse.fromJson(String str) => 
      NowPlayingResponse.fromMap(json.decode(str));

    factory NowPlayingResponse.fromMap(Map<String, dynamic> json) => 
      NowPlayingResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}



enum OriginalLanguage {
    DE,
    EN,
    KO
}

final originalLanguageValues = EnumValues({
    "de": OriginalLanguage.DE,
    "en": OriginalLanguage.EN,
    "ko": OriginalLanguage.KO
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
