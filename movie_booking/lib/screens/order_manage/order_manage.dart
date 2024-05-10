import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_booking/generated/assets.gen.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/auth_controller.dart';
import 'package:movie_booking/network/controllers/location_controller.dart';
import 'package:movie_booking/network/controllers/order_history_controller.dart';
import 'package:movie_booking/network/models/cinema.dart';
import 'package:movie_booking/network/models/cinema_room.dart';
import 'package:movie_booking/network/models/order_history.dart';
import 'package:movie_booking/screens/profile/profile_account.dart';
import 'package:movie_booking/utils/common/cus_appbar.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_inkwel.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';
import 'package:movie_booking/utils/dialog/dialog_provider.dart';

class OrderManageScreen extends StatefulWidget {
  const OrderManageScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OrderManageScreenState();
  }
}

class _OrderManageScreenState extends State<OrderManageScreen> {
  final ScrollController scrollController = ScrollController();
  final OrderHistoryController _orderHistoryController =
      Get.put(OrderHistoryController());

  @override
  void initState() {
    _orderHistoryController.fetchAllOrder();
    super.initState();
  }

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
                            DialogProvider.instance.showMessageDialog(
                              context,
                              message: "Đang bảo trì",
                            );
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
        body: Obx(
          () {
            if (_orderHistoryController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<OrderHistories> movies =
                  _orderHistoryController.allOrderByUserID.toList();
              List<Cinema> cinema = _orderHistoryController.allCinema.toList();
              List<CinemaRoom> cinemaRoom =
                  _orderHistoryController.allCinemaRoombyID.toList();
              return Center(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await _orderHistoryController.fetchAllOrder();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      CusText.bold(
                        'Danh sách các vé đã đặt',
                        fontSize: FontSizes.extra,
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
                                    const SizedBox(height: 16,),
                                    CusText.base('Hiện chưa có đơn nào!!!'),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              )
                            : ListView.separated(
                                padding: const EdgeInsets.all(16),
                                itemBuilder: (context, index) {
                                  String seat = movies[index].seatId!.join(' ');
                                  return GestureDetector(
                                    onTap: () {
                                      context.go(
                                          '/order/order-detail/${movies[index].orderId}');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: UIColors.black
                                                .withOpacity(0.15),
                                            blurRadius: 8,
                                            offset: const Offset(
                                              0,
                                              2,
                                            ),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                        color: UIColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CusText.bold(
                                                'Mã vé: ${movies[index].orderId}',
                                              ),
                                              CusText.bold(
                                                movies[index].formatTimestamp(
                                                    movies[index].time!),
                                                fontSize: FontSizes.small,
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 4,
                                            ),
                                            child: Divider(
                                              color: UIColors.d9d9d9,
                                              height: 1,
                                            ),
                                          ),
                                          CusText.base(
                                            'Phim: ${movies[index].movieId}',
                                          ),
                                          CusText.base(
                                            'Rạp: ${cinema[index].name}',
                                          ),
                                          CusText.base(
                                            'Phòng chiếu: ${cinemaRoom[index].name}',
                                          ),
                                          CusText.base('Ghế: $seat'),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Divider(
                                              color: UIColors.d9d9d9,
                                              height: 1,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CusText.bold(
                                                'Tổng tiền: ${movies[index].totalPrice?.toInt()}.000đ',
                                                fontSize: FontSizes.medium,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: movies.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 16,
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
