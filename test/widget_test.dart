import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  group('Southsea Cinema widget tests', () {
    testWidgets('App loads the home screen', (tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.byType(HomeView), findsOneWidget);
    });

    testWidgets('Home screen displays both movie cards', (tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.byType(MovieCard), findsOneWidget);

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
      await tester.pumpWidget(const SouthseaCinemaApp());

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
      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.text('Book Tickets'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Harry Potter and the Chamber of Secrets'),
        200,
      );

      expect(find.text('Book Tickets'), findsNWidgets(2));
    });

    testWidgets('Movie cards display ticket prices', (tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.text('Ticket: £8.50'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Ticket: £9.50'),
        200,
      );

      expect(find.text('Ticket: £9.50'), findsOneWidget);
    });
  });
}
