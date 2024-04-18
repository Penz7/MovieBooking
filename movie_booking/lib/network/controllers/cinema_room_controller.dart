import 'package:get/get.dart';
import 'package:movie_booking/network/models/cinema.dart';
import 'package:movie_booking/network/models/cinema_room.dart';
import 'package:movie_booking/network/models/seat_layout_model.dart';
import 'package:movie_booking/network/services/cinema_room_service.dart';
import 'package:movie_booking/network/services/seat_service.dart';

class CinemaRoomController extends GetxController {

  static CinemaRoomController instance = Get.find();
  var isLoading = false.obs;
  var allCinemaRoombyID = <CinemaRoom>[].obs;
  var selectdCinema = <Cinema>[].obs;

  final CinemaRoomService _databaseService = CinemaRoomService();
  final SeatService _seatService = SeatService();

  @override
  void onInit() {
    super.onInit();
    // fetchAllCinema();
  }

  // fetchAllCinema() async {
  //   isLoading.value = true;
  //   try {
  //     List<Cinema> data = await _databaseService.getCinema();
  //     for (var cinema in data) {
  //       if (cinema.address != null) {
  //         String addressAll = await _locationController.getAddressFromCoordinates(
  //           cinema.address!.latitude,
  //           cinema.address!.longitude,
  //         );
  //         double distance = await _locationController.calculateDistanceTo(cinema.address!.latitude,
  //           cinema.address!.longitude,);
  //         cinema.addressAll = addressAll;
  //         cinema.distance = distance.toInt() * 1.0;
  //       }
  //     }
  //     allCinema.assignAll(data);
  //   } catch (error) {
  //     print('Error fetching cinema: $error');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  void getCinemaRoomById(String idCinema, String movieId) async {
    isLoading.value = true;
    allCinemaRoombyID.clear();
    try {
      List<CinemaRoom> data =
          await _databaseService.getCinemaRoomById(idCinema);
      for (var room in data) {
        if (room.seatLayoutId != null && room.seatLayoutId!.isNotEmpty) {
          final List<SeatModel> seatModel =
              await _seatService.getSeatbyID(room.seatLayoutId!);
          if (seatModel.any((seat) =>
              seat.movieId != null && seat.movieId!.contains(movieId))) {
            allCinemaRoombyID.assign(room);
            break;
          }
        } else {
          print(
              'Không tìm thấy thông tin ghế cho phòng chiếu có ID: ${room.idRoom}');
        }
      }
    } catch (error) {
      print(
          'Lỗi khi lấy thông tin phòng chiếu cho rạp có ID: $idCinema: $error');
    } finally {
      isLoading.value = false;
    }
  }
}
