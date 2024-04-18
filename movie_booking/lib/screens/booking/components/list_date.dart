import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/location_controller.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class ListDate extends StatefulWidget {
  const ListDate({
    super.key,
    this.onDateSelected,
  });

  final void Function(DateTime)? onDateSelected;
  @override
  State<StatefulWidget> createState() {
    return _ListDateState();
  }
}

class _ListDateState extends State<ListDate> {
  final LocationController _locationController = Get.find<LocationController>();
  int selectedIndex = 0;
  @override
  void initState() {
    _locationController.getWeekDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = _locationController.weekDates;
    return Container(
      padding: const EdgeInsets.all(16),
      height: 120,
      width: double.infinity,
      color: UIColors.white,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              if (widget.onDateSelected != null) {
                widget.onDateSelected!(data[index]);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: (selectedIndex == index)
                    ? UIColors.splash
                    : UIColors.d9d9d9,
              ),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                      color: UIColors.white,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: CusText.medium(
                      (index == 0)
                          ? "H.nay"
                          : _locationController.convertNumberToDay(
                              data[index].weekday.toString(),
                            ),
                      color: (selectedIndex == index)
                          ? UIColors.splash
                          : UIColors.d9d9d9,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: CusText.bold(
                      data[index].day.toString(),
                      fontSize: FontSizes.extra,
                      color: UIColors.white,
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 20,
          );
        },
        itemCount: 7,
      ),
    );
  }
}
