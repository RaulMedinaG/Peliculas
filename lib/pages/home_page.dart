import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/card_swiper.dart';
import 'package:peliculas/widgets/movie_slider.dart';
import 'package:peliculas/widgets/top_rated_slider.dart';
import 'package:peliculas/widgets/up_coming_slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final List<Movie> busquedas = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines',  style: TextStyle(color: Colors.black)),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => showSearch(
              context: context, delegate: MovieSearchDelegate(busquedas: busquedas)),
              icon: Icon(Icons.search_outlined, color: Colors.black,)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(
              movies: moviesProvider.enCines,
            ),
            MovieSlider(
              movies: moviesProvider.populares,
              nextPage: () => moviesProvider.getPopularMovies(),
            ),
            TopRatedSlider(
              movies: moviesProvider.top_rated,
              nextPage: () => moviesProvider.getTopRatedMovies(),
            ),
            UpComingSlider(
              movies: moviesProvider.up_coming,
              nextPage: () => moviesProvider.getUpComingMovies(),
            )
          ],
        ),
      )
    );
  }
}