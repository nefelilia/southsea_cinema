
import '../models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return [
      Movie(
        id: 'hp1',
        title: "Harry Potter and the Philosopher's Stone",
        synopsis:
            'Harry discovers he is a wizard and begins his first year at Hogwarts.',
        ageRating: 'PG',
        runtime: '2h 32m',
        screeningTime: '14:00',
        ticketPrice: 8.50,
        posterImagePath: 'assets/images/harry_potter_1.jpg',
      ),
      Movie(
        id: 'hp2',
        title: 'Harry Potter and the Chamber of Secrets',
        synopsis:
            'Harry returns to Hogwarts and investigates a mysterious hidden chamber.',
        ageRating: 'PG',
        runtime: '2h 41m',
        screeningTime: '17:30',
        ticketPrice: 9.50,
        posterImagePath: 'assets/images/harry_potter_2.jpg',
      ),
    ];
  }

  Movie? getMovieById(String id) {
    for (final movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }
    return null;
  }
}
