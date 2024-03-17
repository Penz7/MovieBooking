import 'package:flutter/material.dart';

class CusInkWel extends InkWell {
  CusInkWel.base({
    super.key,
    required Widget child,
    super.onTap,
    double padding = 0,
  }) : super(
          child: padding != 0
              ? Padding(
                  padding: EdgeInsets.all(padding),
                  child: child,
                )
              : child,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        );

  CusInkWel.padding({
    super.key,
    required Widget child,
    super.onTap,
    EdgeInsets? padding,
  }) : super(
          child: padding != null
              ? Padding(
                  padding: padding,
                  child: child,
                )
              : child,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        );
}
