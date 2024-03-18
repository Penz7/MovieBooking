import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking/generated/assets.gen.dart';

class CusInternetImage extends StatelessWidget {
  const CusInternetImage({
    super.key,
    required this.url,
    this.width = 0,
    this.height = 0,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.placeHolder,
  });

  final String url;
  final double width;
  final double height;
  final double borderRadius;
  final BoxFit fit;
  final String? placeHolder;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty || !url.contains('http')) return _buildErrorImage();
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        errorWidget: (_, __, ___) {
          return _buildErrorImage();
        },
        placeholder: (BuildContext context, String url) {
          ///replace animation or loading widget
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildErrorImage() {
    return Assets.images.icErrorImage.image(
      width: 2 * width / 3,
      fit: BoxFit.fitWidth,
    );
  }
}

class LCImage extends Image {
  LCImage.file({
    super.key,
    required File file,
    super.width,
    super.height,
    super.color,
    BoxFit boxFit = BoxFit.cover,
  }) : super(
          image: ResizeImage.resizeIfNeeded(
            null,
            null,
            FileImage(file),
          ),
          fit: boxFit,
        );
}
