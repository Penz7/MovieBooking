import 'package:get/get.dart';
import 'package:movie_booking/network/models/movie.dart';
import 'package:movie_booking/network/services/movie_category_service.dart';
import 'package:movie_booking/network/services/movie_service.dart';

class MovieController extends GetxController {
  var isLoading = false.obs;
  var allMovies = <Movie>[].obs;

  final MovieService _databaseService = MovieService();
  final MovieCategoryService _movieCategoryService = MovieCategoryService();

  @override
  void onInit() {
    super.onInit();
    fetchAllMovie();
  }

  fetchAllMovie() async {
    isLoading.value = true;
    try {
      List<Movie> data = await _databaseService.getMovies();

      for (var movie in data) {
        if (movie.movieCategory != null) {
          String categoryName =
              await _movieCategoryService.getCategoryName(movie.movieCategory!);
          movie.categoryName = categoryName;
        }
      }
      // Update the list of movies with the fetched category names
      allMovies.assignAll(data);
    } catch (error) {
      print('Error fetching movies: $error');
    } finally {
      isLoading.value = false;
    }
  }

  var movie = <Movie>[].obs;

  void getMovieByName(String name) async {
    movie.clear();
    try {
      final result = await _databaseService.getMovieByName(name.trim());
      if (result != null) {
        String categoryName =
            await _movieCategoryService.getCategoryName(result.movieCategory!);
        result.categoryName = categoryName;
        movie.add(result);
      } else {
        print('Movie not found for name: $name');
      }
    } catch (error) {
      print('Error to get movie: $error');
    }
  }

  void addMovie(Movie movie) {
    _databaseService.addMovie(movie);
  }
}
