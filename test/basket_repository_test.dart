
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

void main() {
  const movie = Movie(
    id: 'hp1',
    title: "Harry Potter and the Philosopher's Stone",
    synopsis: 'A young wizard begins his journey.',
    ageRating: 'PG',
    runtime: '152 minutes',
    screeningTime: '18:00',
    ticketPrice: 8.50,
    posterImagePath: 'assets/images/hp1.jpg',
  );

  group('BasketRepository tests', () {
    test('Basket starts empty', () {
      final basket = BasketRepository();

      expect(basket.items, isEmpty);
      expect(basket.totalTickets, 0);
      expect(basket.totalPrice, 0.0);
    });

    test('Adds tickets to the basket', () {
      final basket = BasketRepository();

      basket.addTickets(movie, 2);

      expect(basket.items.length, 1);
      expect(basket.totalTickets, 2);
      expect(basket.totalPrice, 17.0);
    });

    test('Adds quantities for the same movie', () {
      final basket = BasketRepository();

      basket.addTickets(movie, 2);
      basket.addTickets(movie, 3);

      expect(basket.items.length, 1);
      expect(basket.totalTickets, 5);
      expect(basket.totalPrice, 42.50);
    });

    test('Does not add zero tickets', () {
      final basket = BasketRepository();

      basket.addTickets(movie, 0);

      expect(basket.items, isEmpty);
    });

    test('Removes a movie from the basket', () {
      final basket = BasketRepository();

      basket.addTickets(movie, 2);
      basket.removeMovie(movie.id);

      expect(basket.items, isEmpty);
      expect(basket.totalPrice, 0.0);
    });

    test('Clears the basket', () {
      final basket = BasketRepository();

      basket.addTickets(movie, 3);
      basket.clearBasket();

      expect(basket.items, isEmpty);
      expect(basket.totalTickets, 0);
      expect(basket.totalPrice, 0.0);
    });
  });
}
