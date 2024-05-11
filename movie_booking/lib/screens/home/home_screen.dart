import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie_booking/generated/assets.gen.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/auth_controller.dart';
import 'package:movie_booking/network/controllers/location_controller.dart';
import 'package:movie_booking/screens/home/components/banner_movie.dart';
import 'package:movie_booking/screens/home/components/category.dart';
import 'package:movie_booking/screens/home/components/movie_comming.dart';
import 'package:movie_booking/screens/home/components/recommend_seats.dart';
import 'package:movie_booking/screens/home/components/recommend_theaters.dart';
import 'package:movie_booking/screens/home/components/title_heading.dart';
import 'package:movie_booking/screens/profile/profile_account.dart';
import 'package:movie_booking/screens/social/social_post.dart';
import 'package:movie_booking/utils/common/cus_appbar.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_inkwel.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';
import 'package:movie_booking/utils/dialog/dialog_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    String? picUrl = AuthController.instance.user!.photoURL;
    String? userName = AuthController.instance.user!.email ?? "";
    picUrl = picUrl ?? "";
    return SafeArea(
      child: Scaffold(
        appBar: CusAppbar.customTitle(
          height: 70,
          centerTitle: true,
          showBackButton: false,
          title: Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CusInkWel.base(
                      onTap: () {
                        Get.to(() => const ProfileScreen());
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CusInternetImage(
                          url: picUrl,
                          fit: BoxFit.cover,
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CusText.bold(
                          userName,
                          fontSize: FontSizes.medium,
                          color: UIColors.white,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CusInkWel.base(
                          onTap: () {
                            DialogProvider.instance.showMessageDialog(context,
                                message: "Đang bảo trì");
                          },
                          child: Row(
                            children: [
                              Obx(
                                () => CusText.base(
                                  LocationController.instance.city.value,
                                  fontSize: FontSizes.small,
                                  color: UIColors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Assets.icons.icDropdown.svg(
                                width: 10,
                                color: UIColors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    CusInkWel.base(
                      child: Assets.icons.icSearch.svg(),
                      onTap: () {},
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    CusInkWel.base(
                      child: Assets.icons.icNotification.svg(),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: UIColors.appBarColor,
        ),
        backgroundColor: UIColors.fafafa,
        body: Stack(
          children: [
            CustomScrollView(
              physics: const ClampingScrollPhysics(),
              controller: scrollController,
              slivers: [
                const SliverToBoxAdapter(
                  child: BannerMovie(),
                ),
                SliverToBoxAdapter(
                  child: TitleHeading(
                    title: 'Categories: ',
                    onTap: () {},
                  ),
                ),
                // const SliverPersistentHeader(
                //   delegate: AppSearchingDelegate(),
                //   pinned: true,
                // ),
                 SliverToBoxAdapter(
                  child: Categories(),
                ),
                SliverToBoxAdapter(
                  child: TitleHeading(
                    title: 'Recommend Seats: ',
                    onTap: () {},
                  ),
                ),
                const SliverToBoxAdapter(
                  child: RecommendSeats(),
                ),
                SliverToBoxAdapter(
                  child: TitleHeading(
                    title: 'Recommend Theaters: ',
                    onTap: () {},
                  ),
                ),
                const SliverToBoxAdapter(
                  child: RecommendTheater(),
                ),

                SliverToBoxAdapter(
                  child: TitleHeading(
                    title: 'Movies Comming: ',
                    onTap: () {},
                  ),
                ),
                SliverToBoxAdapter(
                  child: const MoviesComming(),
                ),
                SliverToBoxAdapter(
                  child: TitleHeading(
                    title: 'Interesting Posts: ',
                    onTap: () {},
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SocialPost(),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 30,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: CusInkWel.base(
                onTap: () {
                  scrollController.animateTo(
                    0,
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.brown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
