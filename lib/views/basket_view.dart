
import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  @override
  Widget build(BuildContext context) {
    final items = basketRepository.items;

    return Scaffold(
      backgroundColor: cinemaBackground,
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: items.isEmpty
            ? const Center(
                child: Text(
                  'Your basket is empty',
                  style: TextStyle(
                    color: cinemaFontWhite,
                    fontSize: 20,
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Basket',
                    style: cinemaHeaderStyle,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return Card(
                          color: cinemaSurface,
                          child: ListTile(
                            title: Text(
                              item.movie.title,
                              style: const TextStyle(
                                color: cinemaFontWhite,
                              ),
                            ),
                            subtitle: Text(
                              '${item.quantity} ticket(s) × ${item.movie.formattedPrice}',
                              style: const TextStyle(
                                color: cinemaFontMuted,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '£${item.totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: cinemaFontWhite,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: cinemaBrand,
                                  ),
                                  tooltip: 'Remove movie',
                                  onPressed: () {
                                    setState(() {
                                      basketRepository.removeMovie(
                                        item.movie.id,
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Text(
                    'Total tickets: ${basketRepository.totalTickets}',
                    style: const TextStyle(
                      color: cinemaFontWhite,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total: £${basketRepository.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: cinemaBrand,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}
