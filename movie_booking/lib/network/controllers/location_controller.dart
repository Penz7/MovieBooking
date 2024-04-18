import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  late RxString city = ''.obs;
  RxBool isLocating = false.obs;
  static LocationController instance = Get.find();
  late List<DateTime> weekDates = [];
   var selectedDate = DateTime.now().obs;

  @override
  void onReady() {
    _determinePosition();

    super.onReady();
  }

  

  Future<void> _determinePosition() async {
    setIsLocating(true); // Bắt đầu quá trình xác định vị trí
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setIsLocating(false); // Kết thúc vì dịch vụ vị trí không được kích hoạt
        throw 'Location services are disabled.';
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setIsLocating(false); // Kết thúc vì quyền truy cập vị trí bị từ chối
          throw 'Location permissions are denied';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setIsLocating(
            false); 
        throw 'Location permissions are permanently denied, we cannot request permissions.';
      }

      // Khi đến đây, quyền truy cập vị trí đã được cấp phép
      Position position = await Geolocator.getCurrentPosition();
      // Sử dụng geocoding để lấy tên thành phố từ vị trí
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String city = placemarks.isNotEmpty
          ? '${placemarks[0].administrativeArea}, ${placemarks[0].subAdministrativeArea}'
          : '';

      setCity(city); // Cập nhật giá trị của biến city
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      setIsLocating(false); 
    }
  }

  void setCity(String myCity) {
    city.value = myCity; // Thiết lập giá trị cho biến city
    update();
  }

  void setIsLocating(bool val) {
    isLocating.value = val; // Thiết lập giá trị cho biến isLocating
    update();
  }

   void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  List<DateTime> getWeekDates() {
    final DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      weekDates.add(today.add(Duration(days: i)));
    }
    return weekDates;
  }

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        print(placemarks);

        String address =
            '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
        return address;
      } else {
        return 'Cannot find address for the provided coordinates';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<double> calculateDistanceTo(
      double destinationLatitude, double destinationLongitude) async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition();
      return (await Geolocator.distanceBetween(
            currentPosition.latitude,
            currentPosition.longitude,
            destinationLatitude,
            destinationLongitude,
          )) /
          1000;
    } catch (e) {
      // Xử lý lỗi nếu cần
      print('Error calculating distance: $e');
      return -1; // Trả về -1 nếu có lỗi
    }
  }

  String convertNumberToDay(String numberString) {
    switch (numberString) {
      case '1':
        return 'Chủ nhật';
      case '2':
        return 'Thứ 2';
      case '3':
        return 'Thứ 3';
      case '4':
        return 'Thứ 4';
      case '5':
        return 'Thứ 5';
      case '6':
        return 'Thứ 6';
      case '7':
        return 'Thứ 7';
      default:
        return '';
    }
  }
}
