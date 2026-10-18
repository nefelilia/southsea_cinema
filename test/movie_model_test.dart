import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    const movie = Movie(
      id: 'movie1',
      title: 'Test Movie',
      synopsis: 'A test movie synopsis',
      ageRating: 'PG',
      runtime: '120 minutes',
      screeningTime: '18:00',
      ticketPrice: 7.50,
      posterImagePath: 'assets/images/test.jpg',
    );

    test('Movie constructor stores all properties', () {
      expect(movie.id, 'movie1');
      expect(movie.title, 'Test Movie');
      expect(movie.synopsis, 'A test movie synopsis');
      expect(movie.ageRating, 'PG');
      expect(movie.runtime, '120 minutes');
      expect(movie.screeningTime, '18:00');
      expect(movie.ticketPrice, 7.50);
      expect(movie.posterImagePath, 'assets/images/test.jpg');
    });

    test('formattedPrice displays pounds and pence', () {
      expect(movie.formattedPrice, '£7.50');
    });

    test('formattedPrice displays two decimal places', () {
      const wholePriceMovie = Movie(
        id: 'movie2',
        title: 'Another Movie',
        synopsis: 'Another synopsis',
        ageRating: '12A',
        runtime: '90 minutes',
        screeningTime: '20:00',
        ticketPrice: 10.0,
        posterImagePath: 'assets/images/test2.jpg',
      );

      expect(wholePriceMovie.formattedPrice, '£10.00');
    });
  });
}
