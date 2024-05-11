import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/movie_controller.dart';
import 'package:movie_booking/network/models/movie.dart';
import 'package:movie_booking/utils/common/cus_appbar.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  final String categoryId;
  final String categoryName;

  @override
  State<StatefulWidget> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  final movieController = Get.find<MovieController>();

  @override
  void initState() {
    movieController.getMovieByCategory(widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CusAppbar.base(
        textColor: UIColors.white,
        title: 'Danh sách phim theo thể loại',
        backgroundColor: UIColors.splash,
      ),
      backgroundColor: UIColors.fafafa,
      body: Obx(
        () {
          List<Movie> movies = movieController.searchMovies.toList();
          return Center(
            child: RefreshIndicator(
              onRefresh: () async {
                movieController.getMovieByCategory(widget.categoryId);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  CusText.bold(
                    'Danh sách phim theo thể loại: ${widget.categoryName}',
                    fontSize: FontSizes.big,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: movies.isEmpty
                        ? SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Lottie.asset(
                                  'assets/files/null_box.json',
                                  width: 300,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                CusText.base('Danh sách trống'),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(16),
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 1 / 2,
                            ),
                            itemCount: movies.length,
                            itemBuilder: (BuildContext context, int index) {
                              final data = movies[index];
                              return GestureDetector(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 200,
                                  height: 400,
                                  decoration: BoxDecoration(
                                      color: UIColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            color: UIColors.black
                                                .withOpacity(0.15),
                                            blurRadius: 8,
                                            offset: const Offset(
                                              0,
                                              2,
                                            ),
                                            spreadRadius: 0)
                                      ]),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
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
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Expanded(
                                        child: CusText.bold(
                                          data.categoryName ?? '',
                                          fontSize: FontSizes.small,
                                          color: UIColors.d9d9d9,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  print(data.name);
                                  context.go('/home/movie-detail/${data.name}');
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
