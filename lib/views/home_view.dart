import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

class HomeView extends StatefulWidget {
  final MovieRepository? repository;

  const HomeView({
    super.key,
    this.repository,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Movie> _movies = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      final repository = widget.repository ?? MovieRepository();

      final movies = await repository.loadMoviesFromAsset();

      if (!mounted) return;

      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _errorMessage = 'Unable to load movies';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: cinemaBrand,
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: const TextStyle(
            color: cinemaFontWhite,
            fontSize: 18,
          ),
        ),
      );
    }

    if (_movies.isEmpty) {
      return const Center(
        child: Text(
          'No movies available',
          style: TextStyle(
            color: cinemaFontWhite,
            fontSize: 18,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _movies.length,
      itemBuilder: (context, index) {
        return MovieCard(
          movie: _movies[index],
        );
      },
    );
  }
}
