import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

class TestMovieAssetBundle extends CachingAssetBundle {
  final String jsonString;

  TestMovieAssetBundle(this.jsonString);

  @override
  Future<ByteData> load(String key) {
    return rootBundle.load(key);
  }

  @override
  Future<String> loadString(
    String key, {
    bool cache = true,
  }) async {
    if (key == 'assets/data/movies.json') {
      return jsonString;
    }

    return rootBundle.loadString(key, cache: cache);
  }
}

Future<void> loadApp(WidgetTester tester) async {
  final jsonString = await tester.runAsync(() async {
    return await rootBundle.loadString(
      'assets/data/movies.json',
      cache: false,
    );
  });

  final repository = MovieRepository(
    assetBundle: TestMovieAssetBundle(jsonString!),
  );

  await tester.pumpWidget(
    SouthseaCinemaApp(
      movieRepository: repository,
    ),
  );

  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    basketRepository.clearBasket();
  });

  group('Southsea Cinema widget tests', () {
    testWidgets('App loads the home screen', (tester) async {
      await loadApp(tester);

      expect(find.byType(HomeView), findsOneWidget);
    });

    testWidgets('Home screen displays both movie cards', (tester) async {
      await loadApp(tester);

      expect(find.byType(MovieCard), findsWidgets);

      await tester.scrollUntilVisible(
        find.text('Harry Potter and the Chamber of Secrets'),
        200,
        scrollable: find.byType(Scrollable).first,
      );

      expect(
        find.text('Harry Potter and the Chamber of Secrets'),
        findsOneWidget,
      );
    });

    testWidgets('Home screen displays both Harry Potter movies',
        (tester) async {
      await loadApp(tester);

      expect(
        find.text("Harry Potter and the Philosopher's Stone"),
        findsOneWidget,
      );

      await tester.scrollUntilVisible(
        find.text('Harry Potter and the Chamber of Secrets'),
        200,
      );

      expect(
        find.text('Harry Potter and the Chamber of Secrets'),
        findsOneWidget,
      );
    });

    testWidgets('Home screen displays booking buttons', (tester) async {
      await loadApp(tester);

      expect(find.text('Book Tickets'), findsWidgets);

      await tester.scrollUntilVisible(
        find.text('Harry Potter and the Chamber of Secrets'),
        200,
      );

      expect(find.text('Book Tickets'), findsNWidgets(2));
    });

    testWidgets('Movie cards display ticket prices', (tester) async {
      await loadApp(tester);

      expect(find.text('Ticket: £8.50'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Ticket: £9.50'),
        200,
      );

      expect(find.text('Ticket: £9.50'), findsOneWidget);
    });

    testWidgets('User can book tickets for a Harry Potter movie',
        (tester) async {
      await loadApp(tester);

      final bookButton = find.text('Book Tickets').first;

      await tester.ensureVisible(bookButton);
      await tester.tap(bookButton);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);

      expect(
        find.text("Harry Potter and the Philosopher's Stone"),
        findsOneWidget,
      );

      final dropdown = find.byType(DropdownMenu<int>);

      expect(dropdown, findsOneWidget);

      await tester.ensureVisible(dropdown);
      await tester.pumpAndSettle();

      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      await tester.tap(find.text('2').last);
      await tester.pumpAndSettle();

      final addButton = find.text('ADD TO ORDER');

      await tester.ensureVisible(addButton);
      await tester.pumpAndSettle();

      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(
        find.text('2 ticket(s) added to order'),
        findsOneWidget,
      );

      expect(basketRepository.totalTickets, 2);
      expect(basketRepository.totalPrice, 17.0);
    });
  });
}
