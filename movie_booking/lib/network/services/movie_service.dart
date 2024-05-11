import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_booking/network/constants.dart';
import 'package:movie_booking/network/models/movie.dart';

class MovieService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference<Movie> _movieRef;

  MovieService() {
    _movieRef = _firestore.collection(MOVIES).withConverter<Movie>(
          fromFirestore: (snapshot, _) => Movie.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );
  }

  Future<List<Movie>> getMovies() async {
    QuerySnapshot<Movie> snapshot = await _movieRef.get();
    return snapshot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();
  }

  Future<void> addMovie(Movie movie) async {
    await _movieRef.add(movie);
  }

  Future<Movie?> getMovieByName(String name) async {
    try {
      QuerySnapshot<Movie> querySnapshot = await _movieRef.where('name', isEqualTo: name).get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data();
      } else {
        return null;
      }
    } catch (error) {
      print('Error fetching movie by name: $error');
      return null;
    }
  }

  Future<List<Movie>> getMoviesByCategory(String category) async {
  try {
    QuerySnapshot<Movie> querySnapshot = await _movieRef.where('movie_category', isEqualTo: category).get();
    List<Movie> movies = [];
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        movies.add(doc.data());
      }
    }
    return movies;
  } catch (error) {
    print('Error fetching movies by category: $error');
    return [];
  }
}

}
