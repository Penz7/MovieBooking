import 'package:flutter/material.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/utils/common/cus_inkwel.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';


class MessageDialog extends StatelessWidget {
  const MessageDialog({
    super.key,
    this.title,
    required this.message,
    this.callback,
    this.button,
  });

  final String? title;
  final String message;
  final VoidCallback? callback;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 343,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: UIColors.white,
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[
              CusText.bold(
                title ?? '',
                fontSize: FontSizes.big,
                maxLines: 10,
              ),
              const SizedBox(
                height: 8,
              )
            ],
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: CusText.base(
                message,
                fontSize: FontSizes.medium,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 16,
            ),
            CusInkWel.base(
              onTap: () {
                Navigator.pop(context);
                if (callback != null) {
                  callback!.call();
                }
              },
              child: button ??
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: CusText.semiBold(
                        "close",
                        fontSize: FontSizes.medium,
                      ),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
