import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/seat_selection_controller.dart';
import 'package:movie_booking/network/models/seat_layout_model.dart';
import 'package:movie_booking/utils/common/cus_text.dart';

// ignore: must_be_immutable
class SeatLayout extends StatelessWidget {
  final SeatModel model;
  final String cinemaRoomId;
  SeatLayout({
    super.key,
    required this.model,
    required this.cinemaRoomId,
  });
  int alphabetCounter = -1;
  int seatCounter = 0;
  double amount = 0.0;

  Widget mainSeatLayout({
    required Function(double) seatPrice,
    required double price,
    required String rowNo,
    required List<String> seatSelected,
  }) {
    String seatNo = "$seatCounter";
    String seatId = "$rowNo$seatNo";

    bool isSelected = seatSelected.contains(seatId);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          if (!isSelected) {
            RxList seats = SeatSelectionController.instance.selectedSeats;
            RxList seatPriceList = SeatSelectionController.instance.seatPrices;

            if (seats.contains(seatId)) {
              seatPriceList.remove(price);
              seats.remove(seatId);
            } else {
              if (seats.length >=
                  SeatSelectionController.instance.noOfSeats.value) {
                seats.removeAt(0);
                seatPriceList.removeAt(0);
                seats.add(seatId);
                seatPriceList.add(price);
              } else {
                seatPriceList.add(price);
                seats.add(seatId);
              }
            }
            amount = seatPriceList.fold(0, (prev, e) => prev + e);
            seatPrice(amount < 0 ? 0.0 : amount);
          }
        },
        child: Obx(
          () {
            Color backColor = SeatSelectionController.instance.selectedSeats
                    .contains("$rowNo$seatNo")
                ? UIColors.greenColor
                : const Color(0xffffffff);
            Color textColor = SeatSelectionController.instance.selectedSeats
                    .contains("$rowNo$seatNo")
                ? Colors.white
                : Colors.black87;
            Color borderColor = SeatSelectionController.instance.selectedSeats
                    .contains("$rowNo$seatNo")
                ? UIColors.greenColor
                : const Color(0xff707070);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: (!isSelected) ? backColor : UIColors.d9d9d9,
                border: Border.all(
                  width: 0.5,
                  color: (!isSelected) ? borderColor : UIColors.black,
                ),
              ),
              child: Center(
                child: Text(
                  seatNo,
                  style: TextStyle(color: textColor),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int seatLength = SeatSelectionController.instance.seatType.value + 1;
    return Expanded(
      child: Column(
        children: [
          SvgPicture.asset("assets/icons/screen_here.svg"),
          const Text("Màn hình"),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    color: UIColors.d9d9d9,
                    border: Border.all(
                      width: 0.5,
                      color: UIColors.black,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '',
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Đây là những ghế đã được đặt',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: InteractiveViewer(
              alignment: Alignment.center,
              panEnabled: true,
              child: ListView.builder(
                itemCount: seatLength,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 30,
                        right: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CusText.bold(
                            " ${model.seatType?[seatLength - index - 1].price}.000 VNĐ - ${model.seatType?[seatLength - index - 1].title}",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ...List.generate(
                            model.rowBeaks![index],
                            (row) {
                              alphabetCounter++;
                              seatCounter = 0;

                              String rowNo =
                                  String.fromCharCode(65 + alphabetCounter);
                              return Wrap(
                                children: List.generate(
                                  model.cols ?? 0,
                                  (col) {
                                    if (col == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Text(rowNo),
                                        ),
                                      );
                                    }
                                    //numbering the seats
                                    seatCounter++;
                                    // String seatNo = "$seatCounter";
                                    double price = model
                                        .seatType![seatLength - index - 1]
                                        .price!
                                        .toDouble();

                                    return mainSeatLayout(
                                      seatPrice: SeatSelectionController
                                          .instance.seatPrice.call,
                                      price: price,
                                      rowNo: rowNo,
                                      seatSelected: model.seatSelected ?? [],
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
