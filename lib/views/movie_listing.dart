import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatelessWidget {
  const MovieListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: Container(
        child: const Column(
          children: [
            Text(
              'Harry Potter and the Philosopher\'s Stone',
            ),
            Text(
              'A young wizard begins his first year at Hogwarts School of Witchcraft and Wizardry.',
            ),
            Row(
              children: [
                Text('PG'),
                Text('2h 32m'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}