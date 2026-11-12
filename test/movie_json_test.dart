
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  final movieJson = <String, dynamic>{
    'id': 'hp1',
    'title': "Harry Potter and the Philosopher's Stone",
    'synopsis':
        'Harry discovers he is a wizard and begins his first year at Hogwarts.',
    'ageRating': 'PG',
    'runtime': '2h 32m',
    'screeningTime': '14:00',
    'ticketPrice': 8.50,
    'posterImagePath': 'assets/images/harry_potter_1.jpg',
  };

  group('Movie JSON tests', () {
    test('Movie.fromJson reads all fields correctly', () {
      final movie = Movie.fromJson(movieJson);

      expect(movie.id, 'hp1');
      expect(
        movie.title,
        "Harry Potter and the Philosopher's Stone",
      );
      expect(
        movie.synopsis,
        'Harry discovers he is a wizard and begins his first year at Hogwarts.',
      );
      expect(movie.ageRating, 'PG');
      expect(movie.runtime, '2h 32m');
      expect(movie.screeningTime, '14:00');
      expect(movie.ticketPrice, 8.50);
      expect(
        movie.posterImagePath,
        'assets/images/harry_potter_1.jpg',
      );
    });

    test('Movie.toJson returns all fields correctly', () {
      final movie = Movie.fromJson(movieJson);

      expect(movie.toJson(), movieJson);
    });

    test('Movie.fromJson accepts whole-number prices', () {
      final json = {
        ...movieJson,
        'ticketPrice': 8,
      };

      final movie = Movie.fromJson(json);

      expect(movie.ticketPrice, 8.0);
      expect(movie.ticketPrice, isA<double>());
      expect(movie.formattedPrice, '£8.00');
    });

    test('Movie JSON round trip preserves all fields', () {
      final original = Movie.fromJson(movieJson);
      final restored = Movie.fromJson(original.toJson());

      expect(restored.toJson(), original.toJson());
    });
  });
}
