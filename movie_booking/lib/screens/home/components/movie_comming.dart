import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/movie_category_controller.dart';
import 'package:movie_booking/network/controllers/movie_controller.dart';
import 'package:movie_booking/network/models/movie.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class MoviesComming extends StatefulWidget {
  const MoviesComming({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _MoviesCommingState();
  }
}

class _MoviesCommingState extends State<MoviesComming> {
  final movieController = Get.put(MovieController());
  final movieCategoryController = Get.put(MovieCategoryController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() {
      if (movieController.isLoading.value) {
        return Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        );
      } else {
        List<Movie> movies = movieController.allMovies.toList();
        if (movies.isEmpty) {
          return const SizedBox();
        } else {
          return Container(
            height: size.height / 2.2,
            color: UIColors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6,
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final data = movies[index];
                return GestureDetector(
                  child: SizedBox(
                    width: 150,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CusInternetImage(
                          borderRadius: 20,
                          url: data.imageUrl ?? '',
                          fit: BoxFit.fitHeight,
                          width: 150,
                          height: 230,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CusText.semiBold(
                          data.formatDate(data.createDate!),
                          fontSize: FontSizes.moreSmall,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CusText.bold(
                          data.name ?? '',
                          fontSize: FontSizes.big,
                          maxLines: 3,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CusText.bold(
                          data.categoryName ?? '',
                          fontSize: FontSizes.small,
                          color: UIColors.d9d9d9,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    print(data.name);
                    context.go('/home/movie-detail/${data.name}');
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 20,
                );
              },
              itemCount: movies.length,
            ),
          );
        }
      }
    });
  }
}
