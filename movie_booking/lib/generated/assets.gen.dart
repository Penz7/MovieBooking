/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsColorGen {
  const $AssetsColorGen();

  /// File path: assets/color/colors.xml
  String get colors => 'assets/color/colors.xml';

  /// List of all assets
  List<String> get values => [colors];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/facebook.svg
  SvgGenImage get facebook => const SvgGenImage('assets/icons/facebook.svg');

  /// File path: assets/icons/google.svg
  SvgGenImage get google => const SvgGenImage('assets/icons/google.svg');

  /// File path: assets/icons/ic_back.svg
  SvgGenImage get icBack => const SvgGenImage('assets/icons/ic_back.svg');

  /// File path: assets/icons/ic_camera.svg
  SvgGenImage get icCamera => const SvgGenImage('assets/icons/ic_camera.svg');

  /// File path: assets/icons/ic_clear.svg
  SvgGenImage get icClear => const SvgGenImage('assets/icons/ic_clear.svg');

  /// File path: assets/icons/ic_dropdown.svg
  SvgGenImage get icDropdown =>
      const SvgGenImage('assets/icons/ic_dropdown.svg');

  /// File path: assets/icons/ic_heart.svg
  SvgGenImage get icHeart => const SvgGenImage('assets/icons/ic_heart.svg');

  /// File path: assets/icons/ic_next.svg
  SvgGenImage get icNext => const SvgGenImage('assets/icons/ic_next.svg');

  /// File path: assets/icons/ic_notification.svg
  SvgGenImage get icNotification =>
      const SvgGenImage('assets/icons/ic_notification.svg');

  /// File path: assets/icons/ic_search.svg
  SvgGenImage get icSearch => const SvgGenImage('assets/icons/ic_search.svg');

  /// File path: assets/icons/ic_visibility_off.svg
  SvgGenImage get icVisibilityOff =>
      const SvgGenImage('assets/icons/ic_visibility_off.svg');

  /// File path: assets/icons/ic_visibility_on.svg
  SvgGenImage get icVisibilityOn =>
      const SvgGenImage('assets/icons/ic_visibility_on.svg');

  $AssetsIconsNavigationGen get navigation => const $AssetsIconsNavigationGen();

  /// File path: assets/icons/splash_icon.svg
  SvgGenImage get splashIcon =>
      const SvgGenImage('assets/icons/splash_icon.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        facebook,
        google,
        icBack,
        icCamera,
        icClear,
        icDropdown,
        icHeart,
        icNext,
        icNotification,
        icSearch,
        icVisibilityOff,
        icVisibilityOn,
        splashIcon
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/banner.png
  AssetGenImage get banner => const AssetGenImage('assets/images/banner.png');

  /// File path: assets/images/ic_error_image.png
  AssetGenImage get icErrorImage =>
      const AssetGenImage('assets/images/ic_error_image.png');

  /// List of all assets
  List<AssetGenImage> get values => [banner, icErrorImage];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en-US.json
  String get enUS => 'assets/translations/en-US.json';

  /// File path: assets/translations/vi-VN.json
  String get viVN => 'assets/translations/vi-VN.json';

  /// List of all assets
  List<String> get values => [enUS, viVN];
}

class $AssetsIconsNavigationGen {
  const $AssetsIconsNavigationGen();

  /// File path: assets/icons/navigation/ic_account.svg
  SvgGenImage get icAccount =>
      const SvgGenImage('assets/icons/navigation/ic_account.svg');

  /// File path: assets/icons/navigation/ic_account_active.svg
  SvgGenImage get icAccountActive =>
      const SvgGenImage('assets/icons/navigation/ic_account_active.svg');

  /// File path: assets/icons/navigation/ic_explore.svg
  SvgGenImage get icExplore =>
      const SvgGenImage('assets/icons/navigation/ic_explore.svg');

  /// File path: assets/icons/navigation/ic_explore_active.svg
  SvgGenImage get icExploreActive =>
      const SvgGenImage('assets/icons/navigation/ic_explore_active.svg');

  /// File path: assets/icons/navigation/ic_home.svg
  SvgGenImage get icHome =>
      const SvgGenImage('assets/icons/navigation/ic_home.svg');

  /// File path: assets/icons/navigation/ic_home_active.svg
  SvgGenImage get icHomeActive =>
      const SvgGenImage('assets/icons/navigation/ic_home_active.svg');

  /// File path: assets/icons/navigation/ic_meal.svg
  SvgGenImage get icMeal =>
      const SvgGenImage('assets/icons/navigation/ic_meal.svg');

  /// File path: assets/icons/navigation/ic_meal_active.svg
  SvgGenImage get icMealActive =>
      const SvgGenImage('assets/icons/navigation/ic_meal_active.svg');

  /// File path: assets/icons/navigation/ic_practice.svg
  SvgGenImage get icPractice =>
      const SvgGenImage('assets/icons/navigation/ic_practice.svg');

  /// File path: assets/icons/navigation/ic_practice_active.svg
  SvgGenImage get icPracticeActive =>
      const SvgGenImage('assets/icons/navigation/ic_practice_active.svg');

  /// File path: assets/icons/navigation/nutrition_scan_curve.svg
  SvgGenImage get nutritionScanCurve =>
      const SvgGenImage('assets/icons/navigation/nutrition_scan_curve.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        icAccount,
        icAccountActive,
        icExplore,
        icExploreActive,
        icHome,
        icHomeActive,
        icMeal,
        icMealActive,
        icPractice,
        icPracticeActive,
        nutritionScanCurve
      ];
}

class Assets {
  Assets._();

  static const $AssetsColorGen color = $AssetsColorGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
