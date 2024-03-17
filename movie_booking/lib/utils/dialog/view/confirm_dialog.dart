import 'package:flutter/material.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/utils/common/cus_inkwel.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmButtonTitle,
    required this.cancelButtonTitle,
  });

  final String title;
  final String message;
  final String confirmButtonTitle;
  final String cancelButtonTitle;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          width: 320,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: UIColors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != '') ...[
                CusText.regular(
                  title,
                  maxLines: 10,
                ),
                const SizedBox(
                  height: 8,
                )
              ],
              CusText.regular(
                message,
                fontSize: FontSizes.medium,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
              Divider(
                thickness: 0.5,
                color: UIColors.black.withOpacity(
                  0.3,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CusInkWel.base(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: UIColors.white,
                          border: Border.all(
                            color: UIColors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: CusText.semiBold(
                          cancelButtonTitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: CusInkWel.base(
                      onTap: () {
                        Navigator.pop(
                          context,
                          true,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: UIColors.splash,
                          border: Border.all(
                            color: UIColors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: CusText.semiBold(
                          confirmButtonTitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
