import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderHistories {
  OrderHistories({
    String? orderId,
    String? cinemaId,
    String? cinemaRoomId,
    List<String>? seatId,
    String? userId,
    String? movieId,
    num? totalPrice,
    Timestamp? time,
  }) {
    _orderId = orderId;
    _cinemaId = cinemaId;
    _cinemaRoomId = cinemaRoomId;
    _seatId = seatId;
    _userId = userId;
    _movieId = movieId;
    _totalPrice = totalPrice;
    _time = time;
  }

  OrderHistories.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _cinemaId = json['cinema_id'];
    _cinemaRoomId = json['cinema_room_id'];
    _seatId = json['seat_id'] != null ? json['seat_id'].cast<String>() : [];
    _userId = json['user_id'];
    _movieId = json['movie_id'];
    _totalPrice = json['total_price'];
    _time = json['time'];
  }

  String? _orderId;
  String? _cinemaId;
  String? _cinemaRoomId;
  List<String>? _seatId;
  String? _userId;
  String? _movieId;
  num? _totalPrice;
  Timestamp? _time;

  OrderHistories copyWith({
    String? orderId,
    String? cinemaId,
    String? cinemaRoomId,
    List<String>? seatId,
    String? userId,
    String? movieId,
    num? totalPrice,
    Timestamp? time,
  }) =>
      OrderHistories(
        orderId: orderId ?? _orderId,
        cinemaId: cinemaId ?? _cinemaId,
        cinemaRoomId: cinemaRoomId ?? _cinemaRoomId,
        seatId: seatId ?? _seatId,
        userId: userId ?? _userId,
        movieId: movieId ?? _movieId,
        totalPrice: totalPrice ?? _totalPrice,
        time: time ?? _time,
      );

  String? get orderId => _orderId;
  String? get cinemaId => _cinemaId;
  String? get cinemaRoomId => _cinemaRoomId;
  List<String>? get seatId => _seatId;
  String? get userId => _userId;
  String? get movieId => _movieId;
  num? get totalPrice => _totalPrice;
  Timestamp? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['cinema_id'] = _cinemaId;
    map['cinema_room_id'] = _cinemaRoomId;
    map['seat_id'] = _seatId;
    map['user_id'] = _userId;
    map['movie_id'] = _movieId;
    map['total_price'] = _totalPrice;
    map['time'] = _time;
    return map;
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    DateFormat formatter = DateFormat("MMMM d, y 'at' h:mm:ss a");
    return formatter.format(dateTime);
  }
}
