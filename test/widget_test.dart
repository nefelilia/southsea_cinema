
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

      // Open the first movie's booking page.
      final bookButton = find.text('Book Tickets').first;

      await tester.ensureVisible(bookButton);
      await tester.tap(bookButton);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);

      expect(
        find.text("Harry Potter and the Philosopher's Stone"),
        findsOneWidget,
      );

      // Find the ticket dropdown.
      final dropdown = find.byType(DropdownMenu<int>);

      expect(dropdown, findsOneWidget);

      // Scroll down to the ticket controls.
      await tester.ensureVisible(dropdown);
      await tester.pumpAndSettle();

      // Open the dropdown.
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      // Select 2 tickets.
      await tester.tap(find.text('2').last);
      await tester.pumpAndSettle();

      // Scroll to the ADD TO ORDER button.
      final addButton = find.text('ADD TO ORDER');

      await tester.ensureVisible(addButton);
      await tester.pumpAndSettle();

      // Add tickets to the order.
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Check the confirmation message.
      expect(
        find.text('2 ticket(s) added to order'),
        findsOneWidget,
      );
    });
  });
}
