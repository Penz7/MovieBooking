import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  Event({
    required this.name,
    required this.isActive,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
  });

  Event.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          isActive: json['is_active']! as bool,
          imageUrl: json['image_url']! as String,
          startDate: json['start_date']! as Timestamp,
          endDate: json['end_date']! as Timestamp,
        );

  final String name;
  final bool isActive;
  final String imageUrl;
  final Timestamp endDate;
  final Timestamp startDate;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'is_active': isActive,
      'image_url': imageUrl,
      'start_date': startDate,
      'end_date': endDate,
    };
  }

  Event copyWith({
    String? name,
    bool? isActive,
    String? imageUrl,
    Timestamp? startDate,
    Timestamp? endDate,
  }) {
    return Event(
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      imageUrl: imageUrl ?? this.imageUrl, 
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate
    );
  }
}


