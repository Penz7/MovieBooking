import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/auth_controller.dart';
import 'package:movie_booking/network/controllers/movie_controller.dart';
import 'package:movie_booking/network/controllers/seat_selection_controller.dart';
import 'package:movie_booking/screens/checkout/payment/components/movie_info.dart';
import 'package:movie_booking/utils/common/cus_appbar.dart';
import 'package:movie_booking/utils/common/cus_loading.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';
import 'package:movie_booking/utils/dialog/dialog_provider.dart';
import 'package:movie_booking/utils/dialog/view/confirm_dialog.dart';

class PaymentScreen extends StatefulWidget {
  final String movieId;
  final String cinemaRoomId;
  final String cinemaId;
  final String seatLayoutId;
  final List<String> seatID;
  const PaymentScreen({
    super.key,
    required this.movieId,
    required this.cinemaRoomId,
    required this.cinemaId,
    required this.seatLayoutId,
    required this.seatID,
  });

  @override
  State<StatefulWidget> createState() {
    return _PaymentScreenState();
  }
}

class _PaymentScreenState extends State<PaymentScreen> {
  final MovieController _cinemaController = Get.find<MovieController>();
  String? picUrl = AuthController.instance.user!.photoURL;
  String? name = AuthController.instance.user!.displayName;
  String? email = AuthController.instance.user!.email;
  String? phone = AuthController.instance.user!.phoneNumber;

  final SeatSelectionController _seatSelectionController =
      Get.find<SeatSelectionController>();

  bool _isPayLoading = false;

  Widget bottomBar() {
    return BottomAppBar(
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CusText.bold(
                  'Tổng tiền: ',
                  fontSize: FontSizes.big,
                ),
                CusText.bold(
                  '${_seatSelectionController.seatPrice.value.toInt()}.000đ',
                  fontSize: FontSizes.big,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: AppBar().preferredSize.height,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await DialogProvider.instance.showCustomDialog(
                    context,
                    dialog: const ConfirmDialog(
                      title: 'Xác nhận đặt vé',
                      message: "Bạn có chắc chắn muốn đặt vé không?",
                      confirmButtonTitle: 'Đặt vé',
                      cancelButtonTitle: 'Hủy',
                    ),
                  );
                  if (result == true && context.mounted) {
                    setState(() {
                      _isPayLoading = true; // Hiển thị tiện ích loading
                    });

                    bool isSuccess = await _seatSelectionController.createOrder(
                      widget.seatLayoutId,
                      widget.seatID,
                    );

                    setState(() {
                      _isPayLoading = false; // Ẩn tiện ích loading
                    });

                    if (isSuccess) {
                      if (mounted) {
                        AuthController.instance
                            .getSuccessSnackBar(context, "Đặt vé thành công");
                        context.go('/home/thank');
                      }
                    } else {
                      if (mounted) {
                        AuthController.instance.getErrorSnackBar(
                            context, "Failed", "Đặt vé thất bại");
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Thanh toán',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    String listSeatID = widget.seatID.join(",");
    return SafeArea(
      child: Scaffold(
        appBar: CusAppbar.base(
          textColor: UIColors.white,
          title: 'Thông tin thanh toán',
          backgroundColor: UIColors.splash,
        ),
        bottomNavigationBar: bottomBar(),
        backgroundColor: UIColors.d9d9d9,
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CusText.semiBold(
                  'Thông tin phim: ',
                  fontSize: FontSizes.extra,
                ),
                const SizedBox(
                  height: 16,
                ),
                MovieInfo(
                  movie: _cinemaController.movie.first,
                  cinemaId: widget.cinemaId,
                  cinemaRoomId: widget.cinemaRoomId,
                  seatId: listSeatID,
                ),
                CusText.semiBold(
                  'Thông tin khách hàng: ',
                  fontSize: FontSizes.extra,
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: UIColors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: UIColors.black.withOpacity(
                              0.015,
                            ),
                            blurRadius: 8,
                            offset: const Offset(
                              0,
                              2,
                            ))
                      ]),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CusText.bold(
                        name ?? '',
                        fontSize: FontSizes.big,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CusText.medium(
                        '${phone ?? ''} - $email',
                        fontSize: FontSizes.medium,
                      )
                    ],
                  ),
                )
              ],
            ),
            _isPayLoading
                ? const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CusLoading(),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
