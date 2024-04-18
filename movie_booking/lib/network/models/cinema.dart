import 'package:cloud_firestore/cloud_firestore.dart';

class Cinema {
  Cinema({
    GeoPoint? address,
    String? id,
    String? name,
    String? urlImage,
    String? addressAll = "",
    double? distance = 0.0,
  }) {
    _address = address;
    _id = id;
    _name = name;
    _urlImage = urlImage;
    _addressAll = addressAll;
    _distance = distance;
  }

  Cinema.fromJson(dynamic json) {
    _address = json['address'];
    _id = json['id'];
    _name = json['name'];
    _urlImage = json['url_image'];
  }

  GeoPoint? _address;
  String? _id;
  String? _name;
  String? _urlImage;
  String? _addressAll;
  double? _distance;

  Cinema copyWith({
    GeoPoint? address,
    String? id,
    String? name,
    String? urlImage,
    String? addressAll,
    double? distance,
  }) =>
      Cinema(
          address: address ?? _address,
          id: id ?? _id,
          name: name ?? _name,
          urlImage: urlImage ?? _urlImage,
          addressAll: addressAll ?? _addressAll,
          distance: distance ?? _distance,);

  GeoPoint? get address => _address;
  String? get id => _id;
  String? get name => _name;
  String? get urlImage => _urlImage;
  String? get addressAll => _addressAll;
  double? get distance => _distance;

  set addressAll(String? value) {
    _addressAll = value;
  }

  set distance(double? value) {
    _distance = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['id'] = _id;
    map['name'] = _name;
    map['url_image'] = _urlImage;
    return map;
  }
}
