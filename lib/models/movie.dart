class Movie {
    final bool adult;
    final String? backdropPath;
    final List<int> genreIds;
    final int id;
    final String? originalLanguage;
    final String? originalTitle;
    final String? overview;
    final double popularity;
    final String? posterPath;
    final String? releaseDate;
    final String? title;
    final bool video;
    final double voteAverage;
    final int voteCount;
    String? heroId;

    get fullPosterImg {
      if(posterPath != null) {
        return 'https://image.tmdb.org/t/p/w500${posterPath}';
      }
      return 'https://i.stack.imgur.com/GNhx0.png';
    }

    get fullBackdropPath {
      if(backdropPath != null) {
        return 'https://image.tmdb.org/t/p/w500${backdropPath}';
      }
      return 'https://i.stack.imgur.com/GNhx0.png';
    }

    Movie({
        required this.adult,
        this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        this.posterPath,
        this.releaseDate,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
        required this.heroId
    });

    factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        heroId: json["heroId"]
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}