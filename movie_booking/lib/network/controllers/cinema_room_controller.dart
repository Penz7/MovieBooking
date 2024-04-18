import 'package:get/get.dart';
import 'package:movie_booking/network/models/cinema.dart';
import 'package:movie_booking/network/models/cinema_room.dart';
import 'package:movie_booking/network/services/cinema_room_service.dart';

class CinemaRoomController extends GetxController {
  var isLoading = false.obs;
  var allCinemaRoombyID = <CinemaRoom>[].obs;
  var selectdCinema = <Cinema>[].obs;

  final CinemaRoomService _databaseService = CinemaRoomService();

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

  void getCinemaRoomById(String idCinema) async {
    isLoading.value = true;
    try {
      List<CinemaRoom> data =
          await _databaseService.getCinemaRoomById(idCinema);
      print(data);
      allCinemaRoombyID.assignAll(data);
    } catch (error) {
      print('Error get cinema room by $idCinema');
    } finally {
      isLoading.value = false;
    }
  }
}
