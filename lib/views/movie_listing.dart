import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

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
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Harry Potter and the Philosopher\'s Stone',
               style: cinemaHeaderStyle,
            ),
            Text(
  'A young wizard begins his first year at Hogwarts School of Witchcraft and Wizardry.',
  style: TextStyle(color: cinemaFontMuted),
),
            Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      'PG',
      style: TextStyle(color: cinemaFontWhite),
    ),
    SizedBox(width: 20),
    Text(
      '2h 32m',
      style: TextStyle(color: cinemaFontWhite),
    ),
  ],
),
 SizedBox(height: 12),        
            Text(
  'Tickets',
  style: TextStyle(color: cinemaFontWhite),
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
ElevatedButton(
  style: ElevatedButton.styleFrom(
  backgroundColor: cinemaBrand,
  foregroundColor: cinemaBackground,
),
  onPressed: () {
    setState(() {
      addedQuantity = selectedQuantity;
    });
  },
  child: const Text('ADD TO ORDER'),
),
Text(
  '$addedQuantity ticket(s) added to order',
  style: TextStyle(color: cinemaFontMuted),
),
          ],
        ),
      ),
    );
  }
}