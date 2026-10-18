
import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'package:southsea_cinema/constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cinemaSurface,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              movie.posterImagePath,
              height: 250,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 12),

            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text('Age rating: ${movie.ageRating}'),
            const SizedBox(height: 8),

            Text(movie.synopsis),
            const SizedBox(height: 8),

            Text('Screening: ${movie.screeningTime}'),
            Text('Ticket: £${movie.ticketPrice.toStringAsFixed(2)}'),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                debugPrint('Book tickets for ${movie.title}');
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
              ),
              child: const Text('Book Tickets'),
            ),
          ],
        ),
      ),
    );
  }
}
