import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_booking/generated/assets.gen.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/utils/common/cus_inkwel.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

const double appbarHeight = 70;

class CusAppbar extends PreferredSize {
  CusAppbar.base({
    super.key,
    String? title,
    Color? backgroundColor = Colors.white,
    bool centerTitle = true,
    bool showBackButton = true,
    List<Widget>? actions,
    VoidCallback? customBackEvent,
    double elevation = 3,
    Color? textColor = Colors.black,
    Widget? leading,
    bool hasShadow = false,
    Widget? backButton,
  }) : super(
          child: Container(
            decoration: hasShadow
                ? BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                      ),
                    ],
                  )
                : null,
            child: AppBar(
              centerTitle: centerTitle,
              elevation: elevation,
              backgroundColor: backgroundColor,
              actions: actions ?? [],
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                // Only honored in Android M and above
                statusBarIconBrightness: Brightness.dark,
                // Only honored in Android M and above
                statusBarBrightness: Brightness.light,
              ),
              title: CusText.bold(
                title ?? "",
                fontSize: FontSizes.extra,
                color: textColor,
              ),
              titleSpacing: 0,
              leading: leading ??
                  (showBackButton
                      ? (backButton ?? CusBackbtn(callback: customBackEvent))
                      : null),
            ),
          ),
          preferredSize: const Size.fromHeight(appbarHeight),
        );

  CusAppbar.customTitle({
    super.key,
    Widget? title,
    Color? backgroundColor = UIColors.white,
    bool centerTitle = true,
    bool showBackgroundBackButton = false,
    bool showBackButton = true,
    List<Widget>? actions,
    double titleSpacing = 16,
    double elevation = 3,
    bool hasShadow = false,
    double height = appbarHeight,
  }) : super(
          child: Container(
            decoration: hasShadow
                ? BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                      ),
                    ],
                  )
                : null,
            child: AppBar(
              centerTitle: centerTitle,
              elevation: elevation,
              backgroundColor: backgroundColor,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                // Only honored in Android M and above
                statusBarIconBrightness: Brightness.dark,
                // Only honored in Android M and above
                statusBarBrightness: Brightness.light,
              ),
              title: title,
              titleSpacing: titleSpacing,
              leadingWidth: showBackButton ? null : 0,
              leading: showBackButton ? const CusBackbtn() : const SizedBox(),
              actions: actions,
            ),
          ),
          preferredSize: Size.fromHeight(height),
        );
}

class CusBackbtn extends StatelessWidget {
  const CusBackbtn({
    super.key,
    this.callback,
  });

  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CusInkWel.base(
        onTap: () {
          if (callback != null) {
            callback!();
          } else {
            Navigator.pop(context);
          }
        },
        padding: 0,
        child: Assets.icons.icBack.svg(width: 32,color: UIColors.white,),
      ),
    );
  }
}
