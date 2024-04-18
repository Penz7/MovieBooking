/// seat_layout_id : 40
/// id_cinema : "MAE2"
/// id_room : "MAE2R1"
/// name : "Screen 1"

class CinemaRoom {
  CinemaRoom({
    String? seatLayoutId,
    String? idCinema,
    String? idRoom,
    String? name,
  }) {
    _seatLayoutId = seatLayoutId;
    _idCinema = idCinema;
    _idRoom = idRoom;
    _name = name;
  }

  CinemaRoom.fromJson(dynamic json) {
    _seatLayoutId = json['seat_layout_id'];
    _idCinema = json['id_cinema'];
    _idRoom = json['id_room'];
    _name = json['name'];
  }
  String? _seatLayoutId;
  String? _idCinema;
  String? _idRoom;
  String? _name;
  CinemaRoom copyWith({
    String? seatLayoutId,
    String? idCinema,
    String? idRoom,
    String? name,
  }) =>
      CinemaRoom(
        seatLayoutId: seatLayoutId ?? _seatLayoutId,
        idCinema: idCinema ?? _idCinema,
        idRoom: idRoom ?? _idRoom,
        name: name ?? _name,
      );
  String? get seatLayoutId => _seatLayoutId;
  String? get idCinema => _idCinema;
  String? get idRoom => _idRoom;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seat_layout_id'] = _seatLayoutId;
    map['id_cinema'] = _idCinema;
    map['id_room'] = _idRoom;
    map['name'] = _name;
    return map;
  }
}
