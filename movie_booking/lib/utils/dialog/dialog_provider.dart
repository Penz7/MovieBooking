import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:movie_booking/utils/dialog/view/confirm_dialog.dart';
import 'package:movie_booking/utils/dialog/view/message_dialog.dart';

class DialogProvider {
  static final DialogProvider instance = DialogProvider._();

  DialogProvider._();

  static bool isShowingMessage = false;

  Future<bool?> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmButtonTitle,
  }) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return ConfirmDialog(
          title: title,
          confirmButtonTitle: confirmButtonTitle,
          message: message,
          cancelButtonTitle: 'Cancel',
        );
      },
      barrierDismissible: false,
    );
  }

  Future<bool?> showMessageDialog(
    BuildContext context, {
    String? title,
    required String message,
    bool barrierDismissible = true,
    VoidCallback? callback,
  }) async {
    if (isShowingMessage) {
      return false;
    }
    isShowingMessage = true;
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return MessageDialog(
          title: title,
          message: message,
          callback: callback,
        );
      },
      barrierDismissible: barrierDismissible,
    ).then((value) {
      isShowingMessage = false;
      return null;
    });
  }

   Future<dynamic> showCustomDialog(
    BuildContext context, {
    bool barrierDismissible = true,
    required Widget dialog,
  }) async {
    return await showDialog<dynamic>(
      context: context,
      builder: (context) {
        return dialog;
      },
      barrierDismissible: barrierDismissible,
    );
  }

  Future<dynamic> animatedDialog(
    BuildContext context, {
    bool barrierDismissible = true,
    required Widget dialog,
    Duration duration = const Duration(
      milliseconds: 200,
    ),
    Cubic curve = Curves.fastOutSlowIn,
    DialogTransitionType animationType = DialogTransitionType.slideFromBottom,
  }) async {
    return await showAnimatedDialog(
      context: context,
      builder: (context) {
        return dialog;
      },
      barrierDismissible: barrierDismissible,
      animationType: animationType,
      curve: curve,
      duration: duration,
    );
  }
}
