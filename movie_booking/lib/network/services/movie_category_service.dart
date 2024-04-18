import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_booking/network/constants.dart';
import 'package:movie_booking/network/models/movie_category.dart';

class MovieCategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference<MovieCategory> _movieCategoryRef;

  MovieCategoryService() {
    _movieCategoryRef =
        _firestore.collection(MOVIE_CATEGORIES).withConverter<MovieCategory>(
              fromFirestore: (snapshot, _) =>
                  MovieCategory.fromJson(snapshot.data()!),
              toFirestore: (movieCategory, _) => movieCategory.toJson(),
            );
  }

  Future<List<MovieCategory>> getMovieCategories() async {
    QuerySnapshot<MovieCategory> snapshot = await _movieCategoryRef.get();
    return snapshot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();
  }

  Future<void> addMovieCategory(MovieCategory movieCategory) async {
    await _movieCategoryRef.add(movieCategory);
  }

  Future<String> getCategoryName(String categoryId) async {
    try {
      DocumentSnapshot<MovieCategory> categorySnapshot =
          await _movieCategoryRef.doc(categoryId).get();

      if (categorySnapshot.exists) {
        return categorySnapshot.data()!.name;
      } else {
        return ''; 
      }
    } catch (error) {
      print('Error fetching category: $error');
      return ''; 
    }
  }
}
