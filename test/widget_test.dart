import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
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

    testWidgets('User can book tickets for a Harry Potter movie',
        (tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      // Tap the first movie's booking button.
      final bookButton = find.text('Book Tickets').first;

      await tester.ensureVisible(bookButton);
      await tester.tap(bookButton);
      await tester.pumpAndSettle();

      // Check that the booking screen opens.
      expect(find.byType(MovieListing), findsOneWidget);

      expect(
        find.text("Harry Potter and the Philosopher's Stone"),
        findsOneWidget,
      );

      // Check that the ticket dropdown exists.
      expect(find.byType(DropdownMenu<int>), findsOneWidget);

      // Open the dropdown.
      await tester.tap(find.byType(DropdownMenu<int>));
      await tester.pumpAndSettle();

      // Select 2 tickets.
      await tester.tap(find.text('2').last);
      await tester.pumpAndSettle();

      // Tap ADD TO ORDER.
      await tester.tap(find.text('ADD TO ORDER'));
      await tester.pumpAndSettle();

      // Check the confirmation message.
      expect(
        find.text('2 ticket(s) added to order'),
        findsOneWidget,
      );
    });
  });
}
