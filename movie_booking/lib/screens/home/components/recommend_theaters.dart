import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/cinema_controller.dart';
import 'package:movie_booking/network/models/cinema.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class RecommendTheater extends StatefulWidget {
  const RecommendTheater({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RecommendTheaterState();
  }
}

class _RecommendTheaterState extends State<RecommendTheater> {
  final _controller = Get.put(CinemaController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () {
        if (_controller.isLoading.value) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        } else {
          List<Cinema> data = _controller.allCinema.toList();
          if (data.isEmpty) {
            return const SizedBox();
          } else {
            return Container(
              width: size.width,
              height: size.height / 7,
              color: UIColors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 250,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: UIColors.white,
                      border: Border.all(
                        color: UIColors.d9d9d9,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CusText.medium(
                          'Space about ${data[index].distance ?? ''} km',
                          fontSize: FontSizes.small,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(
                          color: UIColors.d9d9d9,
                          height: 1,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            CusInternetImage(
                              url: data[index].urlImage ?? "",
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CusText.bold(
                                    data[index].name ?? "",
                                    fontSize: FontSizes.medium,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  CusText.medium(
                                    data[index].addressAll ?? "",
                                    fontSize: FontSizes.small,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 30,
                  );
                },
                itemCount: data.length,
              ),
            );
          }
        }
      },
    );
  }
}
