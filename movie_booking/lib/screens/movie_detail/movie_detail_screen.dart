import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/cinema_controller.dart';
import 'package:movie_booking/network/controllers/movie_controller.dart';
import 'package:movie_booking/screens/movie_detail/components/moive_detail_banner.dart';
import 'package:movie_booking/screens/movie_detail/components/moive_detail_info.dart';
import 'package:movie_booking/utils/common/appbutton.dart';
import 'package:movie_booking/utils/common/cus_appbar.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_booking/utils/dialog/dialog_provider.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    super.key,
    required this.movieId,
  });
  final String movieId;
  @override
  State<StatefulWidget> createState() {
    return _MovieDetailScreenState();
  }
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final ScrollController scrollController = ScrollController();
  final CinemaController _cinemaController = Get.find<CinemaController>();
  final movieController = Get.find<MovieController>();

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    movieController.getMovieByName(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Obx(
      () {
        return movieController.movie.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Scaffold(
                  appBar: CusAppbar.base(
                    textColor: UIColors.white,
                    title: widget.movieId,
                    backgroundColor: UIColors.splash,
                  ),
                  backgroundColor: UIColors.fafafa,
                  body: Stack(
                    children: [
                      ListView(
                        children: [
                          Stack(
                            children: [
                              const MovieDetailBanner(),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: MovieDetailInfo(
                                  data: movieController.movie.first,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: RatingBar.builder(
                                initialRating: (movieController
                                        .movie.first.favourites!
                                        .toDouble() *
                                    5 /
                                    100),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                onRatingUpdate: (rating) {
                                   DialogProvider.instance.showMessageDialog(context,
                                message: "Cảm ơn bạn đã đánh giá bộ phim là $rating");
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                CusText.semiBold(
                                  'Nội dung phim',
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CusText.medium(
                                  movieController.movie.first.summary ?? '',
                                  maxLines: isExpanded ? 30 : 4,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: CusText.medium(
                                    isExpanded ? 'Rút gọn' : 'Xem thêm',
                                    color: UIColors.splash,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 16,
                            left: 16,
                            right: 16,
                            bottom: 24,
                          ),
                          decoration: BoxDecoration(
                            color: UIColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: UIColors.black.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: AppButton.fill(
                            title: 'Mua vé',
                            width: double.infinity,
                            hideKeyboardWhenClick: true,
                            onPressed: ()  {
                              _cinemaController.selectedCinema.clear();  
                              context.go('/home/movie-detail/${widget.movieId}/booking/${widget.movieId}',);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
