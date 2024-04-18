import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_booking/network/constants.dart';
import 'package:movie_booking/network/models/seat_layout_model.dart';

class SeatService {
  final CollectionReference<SeatModel> _seatTypeRef;

  SeatService()
      : _seatTypeRef = FirebaseFirestore.instance
            .collection(SEAT_LAYOUT)
            .withConverter<SeatModel>(
              fromFirestore: (snapshot, _) =>
                  SeatModel.fromJson(snapshot.data()!),
              toFirestore: (cinemaRoom, _) => cinemaRoom.toJson(),
            );

  Future<List<SeatModel>> getSeatbyID(String seatLayoutId) async {
    try {
      final snapshot = await _seatTypeRef
          .where('seat_layout_id', isEqualTo: seatLayoutId)
          .get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (error) {
      print('Lỗi khi lấy dữ liệu ghế: $error');
      return [];
    }
  }

  Future<bool> addSeatSelected(
  String seatLayoutId, List<String> idSeats) async {
  try {
    final snapshot = await _seatTypeRef
        .where('seat_layout_id', isEqualTo: seatLayoutId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final seatModel = snapshot.docs.first.data();
      final existingSeats = List<String>.from(seatModel.seatSelected ?? []);

      // Kiểm tra từng idSeat mới
      for (final idSeat in idSeats) {
        // Nếu idSeat chưa tồn tại trong danh sách ghế đã chọn thì thêm vào
        if (!existingSeats.contains(idSeat)) {
          existingSeats.add(idSeat);
        }
      }

      // Thực hiện cập nhật trường seat_selected trong Firestore
      await _seatTypeRef
          .doc(snapshot.docs.first.id)
          .update({'seat_selected': existingSeats});

      if (idSeats.every((id) => existingSeats.contains(id))) {
        print('Đã đặt vé cho các chỗ ngồi này trước đó.');
      }

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
