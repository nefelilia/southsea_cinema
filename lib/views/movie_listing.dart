import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({
    super.key,
    required this.movie,
  });

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int selectedQuantity = 0;
  int addedQuantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cinemaBackground,
      appBar: AppBar(
        title: const Text(
          appTitle,
          style: cinemaHeaderStyle,
        ),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isNarrow = constraints.maxWidth < 900;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.title,
                  style: cinemaHeaderStyle,
                ),
                const SizedBox(height: 12),
                Text(
                  widget.movie.synopsis,
                  style: const TextStyle(
                    color: cinemaFontMuted,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      widget.movie.ageRating,
                      style: const TextStyle(
                        color: cinemaFontWhite,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      widget.movie.runtime,
                      style: const TextStyle(
                        color: cinemaFontWhite,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Screening: ${widget.movie.screeningTime}',
                  style: const TextStyle(
                    color: cinemaFontWhite,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ticket: ${widget.movie.formattedPrice}',
                  style: const TextStyle(
                    color: cinemaFontWhite,
                  ),
                ),
                const SizedBox(height: 20),
                Flex(
                  direction: isNarrow ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Tickets',
                      style: TextStyle(
                        color: cinemaFontWhite,
                      ),
                    ),
                    SizedBox(
                      width: isNarrow ? 0 : 12,
                      height: isNarrow ? 8 : 0,
                    ),
                    DropdownMenu<int>(
                      initialSelection: selectedQuantity,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: 0, label: '0'),
                        DropdownMenuEntry(value: 1, label: '1'),
                        DropdownMenuEntry(value: 2, label: '2'),
                        DropdownMenuEntry(value: 3, label: '3'),
                        DropdownMenuEntry(value: 4, label: '4'),
                        DropdownMenuEntry(value: 5, label: '5'),
                      ],
                      onSelected: (value) {
                        setState(() {
                          selectedQuantity = value ?? 0;
                        });
                      },
                    ),
                    SizedBox(
                      width: isNarrow ? 0 : 12,
                      height: isNarrow ? 8 : 0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cinemaBrand,
                        foregroundColor: cinemaBackground,
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () {
                        setState(() {
                          addedQuantity = selectedQuantity;
                        });
                      },
                      child: const Text('ADD TO ORDER'),
                    ),
                    SizedBox(
                      width: isNarrow ? 0 : 12,
                      height: isNarrow ? 8 : 0,
                    ),
                    Text(
                      '$addedQuantity ticket(s) added to order',
                      style: const TextStyle(
                        color: cinemaFontMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
