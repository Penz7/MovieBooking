/// amount_seat : 40
/// id_cinema : "MAE2"
/// id_room : "MAE2R1"
/// name : "Screen 1"

class CinemaRoom {
  CinemaRoom({
    num? amountSeat,
    String? idCinema,
    String? idRoom,
    String? name,
  }) {
    _amountSeat = amountSeat;
    _idCinema = idCinema;
    _idRoom = idRoom;
    _name = name;
  }

  CinemaRoom.fromJson(dynamic json) {
    _amountSeat = json['amount_seat'];
    _idCinema = json['id_cinema'];
    _idRoom = json['id_room'];
    _name = json['name'];
  }
  num? _amountSeat;
  String? _idCinema;
  String? _idRoom;
  String? _name;
  CinemaRoom copyWith({
    num? amountSeat,
    String? idCinema,
    String? idRoom,
    String? name,
  }) =>
      CinemaRoom(
        amountSeat: amountSeat ?? _amountSeat,
        idCinema: idCinema ?? _idCinema,
        idRoom: idRoom ?? _idRoom,
        name: name ?? _name,
      );
  num? get amountSeat => _amountSeat;
  String? get idCinema => _idCinema;
  String? get idRoom => _idRoom;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount_seat'] = _amountSeat;
    map['id_cinema'] = _idCinema;
    map['id_room'] = _idRoom;
    map['name'] = _name;
    return map;
  }
}
