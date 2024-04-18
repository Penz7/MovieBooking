import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_booking/network/constants.dart';
import 'package:movie_booking/network/models/cinema.dart';

class CinemaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference<Cinema> _cinemaRef;

  CinemaService() {
    _cinemaRef = _firestore.collection(CINEMAS).withConverter<Cinema>(
          fromFirestore: (snapshot, _) => Cinema.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );
  }

  Future<List<Cinema>> getCinema() async {
    QuerySnapshot<Cinema> snapshot = await _cinemaRef.get();
    return snapshot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();
  }

 Future<List<Cinema>> getCinemaByID(String id) async {
    QuerySnapshot<Cinema> snapshot = await _cinemaRef.where('id', isEqualTo: id).get();
    return snapshot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();
  }

}
