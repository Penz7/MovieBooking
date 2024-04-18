import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_booking/network/constants.dart';
import 'package:movie_booking/network/models/cinema_room.dart';

class CinemaRoomService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference<CinemaRoom> _cinemaRef;

  CinemaRoomService() {
    _cinemaRef = _firestore.collection(CINEMA_ROOM).withConverter<CinemaRoom>(
          fromFirestore: (snapshot, _) => CinemaRoom.fromJson(snapshot.data()!),
          toFirestore: (cinemaRoom, _) => cinemaRoom.toJson(),
        );
  }

  Future<List<CinemaRoom>> getCinemaRoom() async {
    QuerySnapshot<CinemaRoom> snapshot = await _cinemaRef.get();
    return snapshot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();
  }


Future<List<CinemaRoom>> getCinemaRoomById(String idCinema) async {
    QuerySnapshot<CinemaRoom> snapshot = await _cinemaRef.where('id_cinema', isEqualTo: idCinema).get();
    return snapshot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();
  }
 
}
