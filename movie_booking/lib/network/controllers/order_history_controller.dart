import 'package:get/get.dart';
import 'package:movie_booking/network/controllers/auth_controller.dart';
import 'package:movie_booking/network/models/cinema.dart';
import 'package:movie_booking/network/models/cinema_room.dart';
import 'package:movie_booking/network/models/order_history.dart';
import 'package:movie_booking/network/services/cinema_room_service.dart';
import 'package:movie_booking/network/services/cinema_service.dart';
import 'package:movie_booking/network/services/order_history_service.dart';

class OrderHistoryController extends GetxController {
  var isLoading = false.obs;
  var allOrderByUserID = <OrderHistories>[].obs;
  var allCinemaRoombyID = <CinemaRoom>[].obs;

  var allCinema = <Cinema>[].obs;

  final OrderHistoryService _databaseService = OrderHistoryService();
  final CinemaService _cinemaService = CinemaService();
  final CinemaRoomService _cinemaRoomService = CinemaRoomService();

  @override
  void onInit() {
    super.onInit();
    fetchAllOrder();
  }

  fetchAllOrder() async {
    isLoading.value = true;
    try {
      List<OrderHistories> data = await _databaseService.getOrderByUserId(AuthController.instance.user!.uid);
      allOrderByUserID.clear();
      allCinema.clear();
      allCinemaRoombyID.clear();
      for (var item in data) {
        List<Cinema> cinema = await _cinemaService.getCinemaByID(item.cinemaId!);
        if (cinema.isNotEmpty) {
       
          allCinema.add(cinema.first); 
        
        }
        List<CinemaRoom> cinemaRoom = await _cinemaRoomService.getCinemaRoomById(item.cinemaId!);
        if (cinemaRoom.isNotEmpty) {
          
          allCinemaRoombyID.add(cinemaRoom.first); 
        
        }
      }
      allOrderByUserID.assignAll(data);
      print(allCinema.length);
      print(allCinemaRoombyID.length);
    } catch (error) {
      print('Error fetching movies: $error');
    } finally {
      isLoading.value = false;
    }
  }


  Future<bool> addOrderHistory(OrderHistories orderHistories) async {
    return await _databaseService.addOrderHistory(orderHistories);
  }

  void getCinemaByID(String id) {}
}
