import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/seat_selection_controller.dart';

class SeatType extends StatelessWidget {
  final Function(int) onTap;
  const SeatType({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        alignment: WrapAlignment.spaceAround,
        children: List.generate(
         
          SeatSelectionController.instance.seatLayout.first.seatType!.length,
          (index) => Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
            ),
            child: GestureDetector(
              onTap: () {
                onTap(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300,),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      index == SeatSelectionController.instance.seatType.value
                          ? UIColors.greenColor
                          : const Color(0xfffcfcfc),
                  border: Border.all(
                      width: 0.5,
                      color: index ==
                              SeatSelectionController.instance.seatType.value
                          ? UIColors.greenColor
                          : const Color(0xffe5e5e5)),
                ),
                child: Column(
                  children: [
                    Text(
                       SeatSelectionController.instance.seatLayout.first.seatType?[index].title ?? "",
                      style: TextStyle(
                        color: index ==
                                SeatSelectionController.instance.seatType.value
                            ? Colors.white
                            : const Color(0xff999999),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\u20B9 ${ SeatSelectionController.instance.seatLayout.first.seatType?[index].price}",
                      style: TextStyle(
                        color: index ==
                                SeatSelectionController.instance.seatType.value
                            ? Colors.white
                            : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                       SeatSelectionController.instance.seatLayout.first.seatType?[index].status == true ? "Còn vé" : "Hết vé",
                      style: TextStyle(
                        color: index ==
                                SeatSelectionController.instance.seatType.value
                            ? Colors.white
                            : Color(0xff999999),
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
