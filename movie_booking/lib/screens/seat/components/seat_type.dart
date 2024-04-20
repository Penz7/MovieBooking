import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/seat_selection_controller.dart';
import 'package:movie_booking/network/models/seat_layout_model.dart';

class SeatType extends StatelessWidget {
  final SeatModel model;

  const SeatType({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        alignment: WrapAlignment.spaceAround,
        children: List.generate(
          model.seatType!.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: GestureDetector(
              onTap: () {
                if (model.seatType![index].status == true) {
                  SeatSelectionController.instance.seatType.value = index;
                }
              },
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 300,
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                   model.seatType![index].status == true ? 
                   (index == SeatSelectionController.instance.seatType.value
                          ? UIColors.greenColor
                          : const Color(0xfffcfcfc)) : UIColors.d9d9d9,
                  border: Border.all(
                    width: 0.5,
                    color:
                        index == SeatSelectionController.instance.seatType.value
                            ? UIColors.greenColor
                            : const Color(0xffe5e5e5),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      model.seatType![index].title ?? "",
                      style: TextStyle(
                        color: index ==
                                SeatSelectionController.instance.seatType.value
                            ? Colors.white
                            : const Color(0xff999999),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${model.seatType![index].price}k",
                      style: TextStyle(
                        color: index ==
                                SeatSelectionController.instance.seatType.value
                            ? Colors.white
                            : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      model.seatType![index].status! ? "Còn vé" : "Hết vé",
                      style: TextStyle(
                        color: index ==
                                SeatSelectionController.instance.seatType.value
                            ? Colors.white
                            : const Color(0xff999999),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
