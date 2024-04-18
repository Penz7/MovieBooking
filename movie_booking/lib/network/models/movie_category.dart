class MovieCategory {
  MovieCategory({
    required this.name,
    required this.isActive,
    required this.imageUrl,
  });

  MovieCategory.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          isActive: json['is_active']! as bool,
          imageUrl: json['image_url']! as String,
        );

  final String name;
  final bool isActive;
  final String imageUrl;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'is_active': isActive,
      'image_url': imageUrl,
    };
  }

  MovieCategory copyWith({
    String? name,
    bool? isActive,
    String? imageUrl,
  }) {
    return MovieCategory(
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}


