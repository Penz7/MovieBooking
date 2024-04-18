import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/auth_controller.dart';
import 'package:movie_booking/network/controllers/cinema_controller.dart';
import 'package:movie_booking/network/controllers/seat_selection_controller.dart';
import 'package:movie_booking/screens/seat/components/no_of_seat.dart';
import 'package:movie_booking/screens/seat/components/seat_layout.dart';
import 'package:movie_booking/screens/seat/components/seat_type.dart';
import 'package:movie_booking/utils/common/cus_appbar.dart';

class SeatSelectionScreen extends StatefulWidget {
  final String movieId;
  final String cinemaRoomId;
  final String cinemaId;
  final String seatLayoutId;
  const SeatSelectionScreen({
    super.key,
    required this.movieId,
    required this.cinemaRoomId,
    required this.cinemaId, required this.seatLayoutId,
  });

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final CinemaController _cinemaController = CinemaController();
  final SeatSelectionController _seatSelectionController =
      Get.put(SeatSelectionController());

  @override
  void initState() {
    super.initState();
    _cinemaController.getCinemaByID(widget.cinemaId);
    _seatSelectionController.getSeatLayoutRoom(widget.seatLayoutId, widget.movieId);
    _seatSelectionController.clearInfo();
  }

  noOfSeatSelection() {
    return Expanded(
      child: Container(
        color: Colors.white,
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Hãy chọn số vé cần đặt",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 30,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/${_seatSelectionController.getAsset()}",
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              NoOfSeats(
                onTap: _seatSelectionController.noOfSeats.call,
              ),
              const SizedBox(
                height: 10,
              ),
              SeatType(
                model: _seatSelectionController.seatLayout.first,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomBar({required Function(bool) toggle}) {
    return BottomAppBar(
      child: SizedBox(
        height: AppBar().preferredSize.height,
        child: ElevatedButton(
          onPressed: () {
            //print(_seatSelectionController.instance.isSeatSelection.value);

            if (_seatSelectionController.isSeatSelection.value) {
              if (_seatSelectionController.seatPrice <= 0.0) {
                AuthController.instance.getErrorSnackBar(
                    context, "Please select atleast one seat", '');
                return;
              }

              final data = _seatSelectionController.selectedSeats
                  .toList()
                  .cast<String>();

              if (data.length == _seatSelectionController.noOfSeats.value) {
                _seatSelectionController.createOrder(
                    context, widget.seatLayoutId, data);
              } else {
                AuthController.instance.getErrorSnackBar(
                    context, "Please choose enough ticket", '');
              }
            } else {
              if (_seatSelectionController.noOfSeats.value <= 0) {
                AuthController.instance.getErrorSnackBar(
                    context, "Please select number of seats", '');
                return;
              }
              toggle(true);
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: Obx(
            () => Center(
              child: Text(
                _seatSelectionController.isSeatSelection.value
                    ? "Tổng giá ${_seatSelectionController.seatPrice.value}"
                    : "Hãy chọn chỗ ngồi",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget myAppBar({required Function(bool) toggle}) {
    return CusAppbar.base(
      title: widget.movieId,
      textColor: UIColors.white,
      backgroundColor: UIColors.splash,
      actions: [
        TextButton(
          onPressed: () {
            toggle(false);
            _seatSelectionController.selectedSeats = [].obs;
            _seatSelectionController.seatPrice = 0.0.obs;
            _seatSelectionController.seatPrices = [].obs;
          },
          child: Obx(
            () => Text(
              "${_seatSelectionController.noOfSeats < 0 ? 0 : _seatSelectionController.noOfSeats} Vé",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(
        toggle: _seatSelectionController.isSeatSelection.call,
      ),
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: myAppBar(
        toggle: _seatSelectionController.isSeatSelection.call,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Obx(
            () => _seatSelectionController.isSeatSelection.value
                ? SeatLayout(
                    model: _seatSelectionController.seatLayout.first,
                    cinemaRoomId: widget.cinemaRoomId,
                  )
                : noOfSeatSelection(),
          ),
        ],
      ),
    );
  }
}
