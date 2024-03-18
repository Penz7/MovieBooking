import 'package:flutter/material.dart';
import 'package:movie_booking/generated/assets.gen.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/utils/common/cus_inkwel.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class TitleHeading extends StatelessWidget {
  const TitleHeading({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      color: UIColors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CusText.semiBold(
            title,
            fontSize: FontSizes.big,
          ),
          CusInkWel.base(
            child: Row(
              children: [
                CusText.bold(
                  'See all',
                  fontSize: FontSizes.medium,
                  color: UIColors.splash,
                ),
                const SizedBox(
                  width: 4,
                ),
                Assets.icons.icNext.svg(
                  width: 16,
                  height: 16,
                  fit: BoxFit.fitHeight,
                  color: UIColors.splash,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
