import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../generated/colors.gen.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.size = 32,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const RepaintBoundary(
        child: LoadingIndicator(
          indicatorType: Indicator.lineSpinFadeLoader,
          colors: [UIColors.splash],
          strokeWidth: 2,
          backgroundColor: Colors.transparent,
          pathBackgroundColor: UIColors.splash,
        ),
      ),
    );
  }
}

class ImageLoadingWidget extends StatelessWidget {
  const ImageLoadingWidget({
    super.key,
    this.size = 32,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        cupertinoOverrideTheme: const CupertinoThemeData(
          brightness: Brightness.dark,
        ),
      ),
      child: CupertinoActivityIndicator(
        radius: size / 2,
        animating: true,
      ),
    );
  }
}
