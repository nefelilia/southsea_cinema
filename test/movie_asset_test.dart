import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Movie asset loader tests', () {
    test('Loads all movies from the JSON asset', () async {
      final repository = MovieRepository();

      final movies = await repository.loadMoviesFromAsset();

      expect(movies.length, 2);

      expect(movies[0].id, 'hp1');
      expect(
        movies[0].title,
        "Harry Potter and the Philosopher's Stone",
      );
      expect(movies[0].ticketPrice, 8.50);
      expect(movies[0].ageRating, 'PG');
      expect(movies[0].runtime, '2h 32m');
      expect(movies[0].screeningTime, '14:00');
      expect(
        movies[0].posterImagePath,
        'assets/images/harry_potter_1.jpg',
      );

      expect(movies[1].id, 'hp2');
      expect(
        movies[1].title,
        'Harry Potter and the Chamber of Secrets',
      );
      expect(movies[1].ticketPrice, 9.50);
      expect(movies[1].ageRating, 'PG');
      expect(movies[1].runtime, '2h 41m');
      expect(movies[1].screeningTime, '17:30');
      expect(
        movies[1].posterImagePath,
        'assets/images/harry_potter_2.jpg',
      );
    });

    test('Loaded movies have valid synopses', () async {
      final repository = MovieRepository();

      final movies = await repository.loadMoviesFromAsset();

      expect(
        movies[0].synopsis,
        'Harry discovers he is a wizard and begins his first year at Hogwarts.',
      );

      expect(
        movies[1].synopsis,
        'Harry returns to Hogwarts and investigates a mysterious hidden chamber.',
      );
    });
  });
}
