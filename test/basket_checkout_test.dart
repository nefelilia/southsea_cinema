import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

void main() {
  late BasketRepository repository;

  const movie = Movie(
    id: 'hp1',
    title: "Harry Potter and the Philosopher's Stone",
    synopsis: 'A young wizard begins his journey.',
    ageRating: 'PG',
    runtime: '2h 32m',
    screeningTime: '14:00',
    ticketPrice: 8.50,
    posterImagePath: 'assets/images/harry_potter_1.jpg',
  );

  setUp(() {
    repository = BasketRepository();
  });

  group('Basket checkout tests', () {
    test('Removing one ticket reduces quantity', () {
      repository.addTickets(movie, 3);

      repository.removeTicket(movie.id);

      expect(repository.totalTickets, 2);
      expect(repository.items.first.quantity, 2);
      expect(repository.totalPrice, 17.00);
    });

    test('Removing the last ticket removes the movie', () {
      repository.addTickets(movie, 1);

      repository.removeTicket(movie.id);

      expect(repository.items, isEmpty);
      expect(repository.totalTickets, 0);
      expect(repository.totalPrice, 0.0);
    });

    test('Removing a missing movie does not change basket', () {
      repository.addTickets(movie, 2);

      repository.removeTicket('unknown');

      expect(repository.totalTickets, 2);
      expect(repository.totalPrice, 17.00);
    });

    test('Clearing basket removes all tickets', () {
      repository.addTickets(movie, 3);

      repository.clearBasket();

      expect(repository.items, isEmpty);
      expect(repository.totalTickets, 0);
      expect(repository.totalPrice, 0.0);
    });
  });
}
