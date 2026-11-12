import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  final AssetBundle assetBundle;

  MovieRepository({AssetBundle? assetBundle})
      : assetBundle = assetBundle ?? rootBundle;

  Future<List<Movie>> loadMoviesFromAsset() async {
    final String jsonString = await assetBundle.loadString(
      'assets/data/movies.json',
    );

    final List<dynamic> jsonList = jsonDecode(jsonString);

    return jsonList
        .map(
          (json) => Movie.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<List<Movie>> getMovies() async {
    return await loadMoviesFromAsset();
  }

  Future<Movie?> getMovieById(String id) async {
    final movies = await getMovies();

    for (final movie in movies) {
      if (movie.id == id) {
        return movie;
      }
    }

    return null;
  }
}
