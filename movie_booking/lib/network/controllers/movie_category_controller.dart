import 'package:get/get.dart';
import 'package:movie_booking/network/models/movie_category.dart';
import 'package:movie_booking/network/services/movie_category_service.dart';

class MovieCategoryController extends GetxController {
  var isLoading = false.obs;
  var allMovieCategories = <MovieCategory>[].obs;
  var categoryName = ''.obs;

  final MovieCategoryService _databaseService = MovieCategoryService();

  @override
  void onInit() {
    super.onInit();
    fetchAllMovieCategory();
  }

  fetchAllMovieCategory() async {
    isLoading.value = true;
    try {
      List<MovieCategory> data = await _databaseService.getMovieCategories();
      allMovieCategories.assignAll(data);
    } catch (error) {
      print('Error fetching movie categories: $error');
    } finally {
      isLoading.value = false;
    }
  }

  void addMovieCategory(MovieCategory movieCategory) {
    _databaseService.addMovieCategory(movieCategory);
  }


  void getDocumentIdByName(String name) {
    
  }
}
