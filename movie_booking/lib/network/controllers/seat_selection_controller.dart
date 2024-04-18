import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_booking/network/controllers/auth_controller.dart';
import 'package:movie_booking/network/models/seat_layout_model.dart';
import 'package:movie_booking/network/services/seat_service.dart';
// import 'package:movieticketbookingapp/controllers/auth_controller.dart';
// import 'package:movieticketbookingapp/utils/constants.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:http/http.dart' as http;

class SeatSelectionController extends GetxController {
  static SeatSelectionController instance = Get.find();
  RxInt timeSelectedIndex = 0.obs;
  static int initialValue = -1;
  RxInt noOfSeats = initialValue.obs;
  RxInt seatType = initialValue.obs;
  RxBool isSeatSelection = false.obs;
  var isLoading = false.obs;

  var seatLayout = <SeatModel>[].obs;

  final SeatService _seatService = SeatService();

  RxList selectedSeats = [].obs;
  RxList seatPrices = [].obs;
  RxDouble seatPrice = 0.0.obs;
  static const String _chars = '1234567890';
  final Random _rnd = Random();

  @override
  void onReady() {
    super.onReady();
    noOfSeats = initialValue.obs;
    seatType = initialValue.obs;
  }

  void getSeatLayoutRoom(String cinemaRoomID) async {
    isLoading.value = true;
    seatLayout.clear();
    try {
      List<SeatModel> data = await _seatService.getSeatbyID(cinemaRoomID);
      seatLayout.assignAll(data);
    } catch (error) {
      print('Error get seat layout room by $cinemaRoomID');
    } finally {
      isLoading.value = false;
    }
  }

  void createOrder(
      BuildContext context, String cinemaRoomId, List<String> idSeat) async {
    try {
      bool isSuccess = await _seatService.addSeatSelected(cinemaRoomId, idSeat);
      if (isSuccess) {
        AuthController.instance.getSuccessSnackBar(context, "Success");
      } else {
        AuthController.instance.getErrorSnackBar(
            context, "Failed", "Failed to add seat selection.");
      }
    } catch (error) {
      print('Đặt vé thất bại: $error');
      AuthController.instance
          .getErrorSnackBar(context, "Failed", error.toString());
    }
  }

  String getAsset() {
    int val = noOfSeats.value;
    if (val <= 2) {
      return "vespa.svg";
    } else if (val > 2 && val <= 4) {
      return "car.svg";
    } else if (val > 4 && val <= 8) {
      return "van.svg";
    }
    return "bus.svg";
  }

  updateNoOfSeats(int value) {
    noOfSeats = value.obs;
    update();
  }

  clearInfo() {
    noOfSeats = initialValue.obs;
    seatType = initialValue.obs;
    isSeatSelection = false.obs;
    selectedSeats = [].obs;
    seatPrices = [].obs;
    seatPrice = 0.0.obs;
    update();
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  // void createOrder() async {
  //   http.Response res = await http.post(
  //     Uri.parse(Constants.createOrderUrl),
  //     headers: {
  //       'content-type': 'application/json',
  //       'authorization': 'Basic ${base64Encode(utf8.encode(Constants.keyId + ':' + Constants.keySecret))}'
  //     },
  //     body: jsonEncode({
  //       "amount": seatPrice * 100,
  //       "currency": "INR",
  //       "receipt": 'recpt_' + getRandomString(4),
  //     }),
  //   );

  //   print(res.body);
  //   String orderId = jsonDecode(res.body)['id'];
  //   print(orderId);
  //   createPayment(orderId);
  // }

  // void createPayment(String orderId) async {
  //   _razorpay = Razorpay();

  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  //   var options = {
  //     'key': Constants.keyId,
  //     'amount': seatPrice * 100, //in the smallest currency sub-unit.
  //     'name': 'Find Seat',
  //     'order_id': orderId, // Generate order_id using Orders API
  //     'description': 'Movie Ticket Amount',
  //     'timeout': 300, // in seconds
  //     'prefill': {
  //       'contact': AuthController.instance.user!.phoneNumber ?? '9876543210',
  //       'email': AuthController.instance.user!.email,
  //     }
  //   };

  //   _razorpay.open(options);
  // }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   // Do something when payment succeeds
  //   AuthController.instance.getSuccessSnackBar("Payment Success for order Id : ${response.orderId}");
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Do something when payment fails
  //   AuthController.instance.getErrorSnackBarNew("Payment failed : ${response.message}");
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet was selected
  // }

  // @override
  // void dispose() {
  //   _razorpay.clear();
  //   super.dispose();
  // }
}
