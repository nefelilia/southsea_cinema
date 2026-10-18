import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  group('MovieRepository unit tests', () {
    test('getMovies returns two movies', () {
      final repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, 2);
    });

    test('getMovies contains the correct Harry Potter movies', () {
      final repository = MovieRepository();
      final movies = repository.getMovies();

      final firstMovie = movies[0];
      expect(firstMovie.id, 'hp1');
      expect(
        firstMovie.title,
        "Harry Potter and the Philosopher's Stone",
      );
      expect(firstMovie.ticketPrice, 8.50);
      expect(firstMovie.ageRating, 'PG');
      expect(firstMovie.posterImagePath, isNotEmpty);

      final secondMovie = movies[1];
      expect(secondMovie.id, 'hp2');
      expect(
        secondMovie.title,
        'Harry Potter and the Chamber of Secrets',
      );
      expect(secondMovie.ticketPrice, 9.50);
      expect(secondMovie.ageRating, 'PG');
      expect(secondMovie.posterImagePath, isNotEmpty);
    });

    test('getMovieById finds an existing movie', () {
      final repository = MovieRepository();

      final movie = repository.getMovieById('hp1');

      expect(movie, isNotNull);
      expect(movie?.id, 'hp1');
      expect(
        movie?.title,
        "Harry Potter and the Philosopher's Stone",
      );
    });

    test('getMovieById returns null for a missing movie', () {
      final repository = MovieRepository();

      final movie = repository.getMovieById('unknown');

      expect(movie, isNull);
    });
  });
}
