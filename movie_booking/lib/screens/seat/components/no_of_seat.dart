import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_booking/network/controllers/seat_selection_controller.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class NoOfSeats extends StatelessWidget {
  final Function(int) onTap;
  const NoOfSeats({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()  => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                if (SeatSelectionController.instance.noOfSeats.value > 0) {
                  onTap(SeatSelectionController.instance.noOfSeats.value - 1);
                }
              },
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(
              width: 20,
            ),
            Center(
              child: CusText.semiBold(
                SeatSelectionController.instance.noOfSeats.value > 0 ? '${SeatSelectionController.instance.noOfSeats.value}' : 
                "0",
                fontSize: FontSizes.moreExtra,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {
                onTap(
                  SeatSelectionController.instance.noOfSeats.value + 1,
                );
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
        ));
  
  }
}
