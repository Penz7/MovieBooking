import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/cinema_controller.dart';
import 'package:movie_booking/network/controllers/location_controller.dart';
import 'package:movie_booking/network/models/cinema.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class ListCinema extends StatefulWidget {
  const ListCinema({
    super.key,
    required this.date,
    this.onCinemaSelected,
  });

  final DateTime date;
  final void Function(Cinema)? onCinemaSelected;

  @override
  State<StatefulWidget> createState() {
    return _ListCinemaState();
  }
}

class _ListCinemaState extends State<ListCinema> {
  final LocationController dateController = Get.find<LocationController>();
  final _cinemaController = Get.find<CinemaController>();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var selectedDate = dateController.selectedDate.value;
        if (_cinemaController.isLoading.value) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        } else {
          List<Cinema> data = _cinemaController.allCinema.toList();
          if (data.isEmpty) {
            return const SizedBox();
          } else {
            if (selectedDate.day == 0) {
              return const SizedBox();
            } else {
              return Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                height: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: UIColors.white,
                ),
                width: double.infinity,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        if (widget.onCinemaSelected != null) {
                          widget.onCinemaSelected!(data[index]);
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: (selectedIndex == index)
                                    ? UIColors.splash
                                    : UIColors.d9d9d9,
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: UIColors.white,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: CusInternetImage(
                              url: data[index].urlImage ?? "",
                              borderRadius: 6,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CusText.bold(
                            data[index].name ?? "",
                            fontSize: FontSizes.big,
                            color: (selectedIndex == index)
                                ? UIColors.splash
                                : UIColors.d9d9d9,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 20,
                    );
                  },
                  itemCount: data.length,
                ),
              );
            }
          }
        }
      },
    );
  }
}
