import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/models/search_movie_response.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  late List<Movie> busquedas = [];
  MovieSearchDelegate({Key? key, required this.busquedas});
  @override
  //TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar Película';
  
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    if (query.isEmpty && busquedas.isEmpty) {
      return Container(
          child: Center(
              child: Icon(Icons.movie_creation_outlined,
                  color: Colors.black38, size: 150)));
    } else if(query.isEmpty && busquedas.isNotEmpty){
      return ListView.builder(
            itemCount: busquedas.length,
            itemBuilder: (_, int index) {
              return _SuggestionItem(movie: busquedas[index], busquedas: busquedas);
            },
          );
    } else {
      {
      return FutureBuilder(
        future: moviesProvider.searchMovie(query),
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, int index) {
              return _SuggestionItem(movie: snapshot.data![index], busquedas: busquedas);
            },
          );
        },
      );
    }
    }
  }
}

class _SuggestionItem extends StatelessWidget {
  final Movie movie;
  late List<Movie> busquedas = [];

  _SuggestionItem({Key? key, required this.movie, required this.busquedas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: AssetImage('assets/images/no-image.jpg'),
        image: NetworkImage(movie.fullPosterImg),
        width: 50,
        fit: BoxFit.contain,
      ),
      title: Text(movie.title!),
      subtitle: Text(movie.originalTitle!),
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: movie);
        busquedas.add(movie);
      },
    );
  }
}
