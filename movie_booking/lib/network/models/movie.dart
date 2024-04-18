import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class Movie {
  Movie({
    Timestamp? createDate,
    String? director,
    num? favourites,
    String? imageUrl,
    bool? isActive,
    String? movieCategory,
    String? name,
    String? summary,
    num? time,
    String? categoryName = "",
  }) {
    _createDate = createDate;
    _director = director;
    _favourites = favourites;
    _imageUrl = imageUrl;
    _isActive = isActive;
    _movieCategory = movieCategory;
    _name = name;
    _summary = summary;
    _time = time;
    _categoryName = categoryName;
  }

  Movie.fromJson(dynamic json) {
    _createDate = json['create_date'];
    _director = json['director'];
    _favourites = json['favourites'];
    _imageUrl = json['image_url'];
    _isActive = json['is_active'];
    _movieCategory = json['movie_category'];
    _name = json['name'];
    _summary = json['summary'];
    _time = json['time'];
  }

  Timestamp? _createDate;
  String? _director;
  num? _favourites;
  String? _imageUrl;
  bool? _isActive;
  String? _movieCategory;
  String? _name;
  String? _summary;
  num? _time;
  String? _categoryName;

  Movie copyWith({
    Timestamp? createDate,
    String? director,
    num? favourites,
    String? imageUrl,
    bool? isActive,
    String? movieCategory,
    String? name,
    String? summary,
    num? time,
    String? categoryName,
  }) =>
      Movie(
        createDate: createDate ?? _createDate,
        director: director ?? _director,
        favourites: favourites ?? _favourites,
        imageUrl: imageUrl ?? _imageUrl,
        isActive: isActive ?? _isActive,
        movieCategory: movieCategory ?? _movieCategory,
        name: name ?? _name,
        summary: summary ?? _summary,
        time: time ?? _time,
        categoryName: categoryName ?? _categoryName,
      );

  Timestamp? get createDate => _createDate;
  String? get director => _director;
  num? get favourites => _favourites;
  String? get imageUrl => _imageUrl;
  bool? get isActive => _isActive;
  String? get movieCategory => _movieCategory;
  String? get name => _name;
  String? get summary => _summary;
  num? get time => _time;
  String? get categoryName => _categoryName;

  set categoryName(String? value) {
    _categoryName = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['create_date'] = _createDate;
    map['director'] = _director;
    map['favourites'] = _favourites;
    map['image_url'] = _imageUrl;
    map['is_active'] = _isActive;
    map['movie_category'] = _movieCategory;
    map['name'] = _name;
    map['summary'] = _summary;
    map['time'] = _time;
    return map;
  }

  String formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat.yMMMMd('en_US').format(dateTime);
  }
}
