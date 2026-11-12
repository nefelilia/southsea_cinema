import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MovieRepository repository;

  setUp(() {
    repository = MovieRepository();
  });

  group('MovieRepository tests', () {
    test('getMovies returns two movies', () async {
      final List<Movie> movies = await repository.getMovies();

      expect(movies.length, 2);
    });

    test('getMovies contains correct Harry Potter movies', () async {
      final movies = await repository.getMovies();

      expect(
        movies[0].title,
        "Harry Potter and the Philosopher's Stone",
      );

      expect(
        movies[1].title,
        'Harry Potter and the Chamber of Secrets',
      );
    });

    test('getMovieById finds existing movie', () async {
      final movie = await repository.getMovieById('hp1');

      expect(movie, isNotNull);

      expect(
        movie!.title,
        "Harry Potter and the Philosopher's Stone",
      );

      expect(movie.ticketPrice, 8.50);
    });

    test('getMovieById returns null for missing movie', () async {
      final movie = await repository.getMovieById('unknown');

      expect(movie, isNull);
    });
  });
}
