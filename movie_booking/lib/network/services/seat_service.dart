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
        for (final idSeat in idSeats) {
          if (!existingSeats.contains(idSeat)) {
            existingSeats.add(idSeat);
          }
        }
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

  Future<void> updateSeatStatus(String seatLayoutId) async {
    try {
      final snapshot = await _seatTypeRef
          .where('seat_layout_id', isEqualTo: seatLayoutId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final seatDocument = snapshot.docs.first;
        final seatData = seatDocument.data();

        final seatSelected = seatData.seatSelected ?? [];
        final rowBeaks = seatData.rowBeaks ?? [];
        final seatType = seatData.seatType ?? [];
        final cols = seatData.cols ?? 0;

        var countNor = 0;
        var countVip = 0;
        var countVipPro = 0;

        for (String item in seatSelected) {
          if (item.contains(RegExp('[A-E]'))) {
            countNor++;
          } else if (item.contains(RegExp('[F-H]'))) {
            countVip++;
          } else if (item.contains(RegExp('[I-J]'))) {
            countVipPro++;
          }
        }

        final counts = [countNor, countVip, countVipPro];
        List<Map<String, dynamic>> listSeatType = [];
        for (int i = 0; i < seatType.length; i++) {
          final currentSeatType = seatType[i];
          final currentRowBeak = rowBeaks[i];
          final amountSeatRowBeak = (cols - 1) * currentRowBeak;

          final isFullyBooked = counts[i] == amountSeatRowBeak;
          currentSeatType.status = !isFullyBooked;
          listSeatType.add(currentSeatType.toJson());
        }

        await _seatTypeRef.doc(seatDocument.id).update({
          'seat_type': listSeatType,
        });
      } else {
        print('Tài liệu không tồn tại.');
      }
    } catch (error) {
      print('Lỗi khi cập nhật trạng thái ghế: $error');
    }
  }
}
