import 'package:flutter/material.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/utils/common/cus_appbar.dart';
import 'package:movie_booking/utils/common/cus_text.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CusAppbar.base(
        textColor: UIColors.white,
        title: orderId,
        backgroundColor: UIColors.splash,
      ),
      backgroundColor: UIColors.fafafa,
      body: Container(
        child: CusText.base(orderId),
      ),
    );
  }
}
