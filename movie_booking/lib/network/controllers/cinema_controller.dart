import 'package:get/get.dart';
import 'package:movie_booking/network/controllers/location_controller.dart';
import 'package:movie_booking/network/models/cinema.dart';
import 'package:movie_booking/network/services/cinema_service.dart';

class CinemaController extends GetxController {
  var isLoading = false.obs;
  var allCinema = <Cinema>[].obs;
  var selectedCinema = <Cinema>[].obs;

  final CinemaService _cinemaService = CinemaService();
  final LocationController _locationController = LocationController();

  @override
  void onInit() {
    super.onInit();
    fetchAllCinema();
  }

  fetchAllCinema() async {
    isLoading.value = true;
    try {
      List<Cinema> data = await _cinemaService.getCinema();
      await _updateCinemaData(data);
      allCinema.assignAll(data);
    } catch (error) {
      print('Error fetching cinema: $error');
    } finally {
      isLoading.value = false;
    }
  }

 Future<Cinema?> cinemaByID(String id) async {
  try {
    List<Cinema> cinema = await _cinemaService.getCinemaByID(id);
    return cinema.first;
  } catch (error) {
    print('Error fetching cinema by ID: $error');
    return null; 
  }
}


  void getCinemaByID(String id)  {
    selectedCinema.clear();
    for (var data in allCinema) {
      if (data.id! == id) {
        selectedCinema.assign(data);
      }
    }
  }

  Future<void> _updateCinemaData(List<Cinema> cinemas) async {
    for (var cinema in cinemas) {
      if (cinema.address != null) {
        String addressAll =
            await _locationController.getAddressFromCoordinates(
          cinema.address!.latitude,
          cinema.address!.longitude,
        );
        double distance = await _locationController.calculateDistanceTo(
          cinema.address!.latitude,
          cinema.address!.longitude,
        );
        cinema.addressAll = addressAll;
        cinema.distance = distance.toInt() * 1.0;
      }
    }
  }
}
