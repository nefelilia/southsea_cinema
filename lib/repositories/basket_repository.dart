
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/models/basket_item.dart';

class BasketRepository {
  final List<BasketItem> _items = [];

  List<BasketItem> get items => List.unmodifiable(_items);

  void addTickets(Movie movie, int quantity) {
    if (quantity <= 0) {
      return;
    }

    final index = _items.indexWhere(
      (item) => item.movie.id == movie.id,
    );

    if (index == -1) {
      _items.add(
        BasketItem(
          movie: movie,
          quantity: quantity,
        ),
      );
    } else {
      final existingItem = _items[index];

      _items[index] = BasketItem(
        movie: existingItem.movie,
        quantity: existingItem.quantity + quantity,
      );
    }
  }

  void removeMovie(String movieId) {
    _items.removeWhere(
      (item) => item.movie.id == movieId,
    );
  }

  void clearBasket() {
    _items.clear();
  }

  double get totalPrice {
    return _items.fold(
      0.0,
      (total, item) => total + item.totalPrice,
    );
  }

  int get totalTickets {
    return _items.fold(
      0,
      (total, item) => total + item.quantity,
    );
  }
}
final BasketRepository basketRepository = BasketRepository();