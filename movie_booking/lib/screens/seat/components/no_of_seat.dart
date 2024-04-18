import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/seat_selection_controller.dart';

class NoOfSeats extends StatelessWidget {
  final Function(int) onTap;
  const NoOfSeats({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        alignment: WrapAlignment.spaceAround,
        children: List.generate(
         10,
          (index) => GestureDetector(
            onTap: () {
              onTap(index + 1);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: index + 1 ==
                        SeatSelectionController.instance.noOfSeats.value
                    ? UIColors.greenColor
                    : UIColors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    color: index + 1 ==
                            SeatSelectionController.instance.noOfSeats.value
                        ? UIColors.white
                        : UIColors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
