import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/movie_category_controller.dart';
import 'package:movie_booking/network/models/movie_category.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final movieCategoryController = Get.put(MovieCategoryController());
    final size = MediaQuery.of(context).size;
    return Obx(() {
      if (movieCategoryController.isLoading.value) {
        return Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        );
      } else {
        List<MovieCategory> movieCategories =
            movieCategoryController.allMovieCategories.toList();
        if (movieCategories.isEmpty) {
          return const SizedBox();
        } else {
          return Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 8,
              left: 16,
              right: 16,
            ),
            color: UIColors.white,
            width: size.width,
            height: size.height / 10,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                MovieCategory data = movieCategories[index];
                return Column(
                  children: [
                    CusInternetImage(
                      url: data.imageUrl.toString(),
                      height: 24,
                      width: 24,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: CusText.base(
                        data.name.toString(),
                        fontSize: FontSizes.medium,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 40,
                );
              },
              itemCount: movieCategories.length,
            ),
          );
        }
      }
    });
  }
}
