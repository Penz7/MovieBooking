import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_booking/network/constants.dart';
import 'package:movie_booking/network/models/seat_layout_model.dart';

class SeatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<SeatModel> _seatTypeRef;

  SeatService() {
    _seatTypeRef = _firestore.collection(SEAT_LAYOUT).withConverter<SeatModel>(
      fromFirestore: (snapshot, _) => SeatModel.fromJson(snapshot.data()!),
      toFirestore: (cinemaRoom, _) => cinemaRoom.toJson(),
    );
  }

  Future<List<SeatModel>> getSeatbyID(String cinemaRoomId) async {
    final snapshot = await _seatTypeRef
        .where('cinema_room_id', isEqualTo: cinemaRoomId)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<bool> addSeatSelected(String cinemaRoomId, List<String> idSeats) async {
    try {
      final snapshot = await _seatTypeRef.doc(cinemaRoomId).get();
      if (snapshot.exists) {
        SeatModel seatModel = snapshot.data()!;
        seatModel = seatModel.copyWith(seatSelected: [
          ...(seatModel.seatSelected ?? []),
          ...idSeats,
        ]);

        await _seatTypeRef.doc(cinemaRoomId).set(seatModel);
        return true;
      } else {
        print('Tài liệu không tồn tại.');
        return false;
      }
    } catch (error) {
      print('Thêm idSeat thất bại: $error');
      return false;
    }
  }
}
