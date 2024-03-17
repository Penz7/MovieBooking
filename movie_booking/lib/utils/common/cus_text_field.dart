import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:movie_booking/generated/assets.gen.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/utils/common/cus_inkwel.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class CusTextField extends StatefulWidget {
  const CusTextField({
    super.key,
    this.labelText,
    required this.hintText,
    this.onChanged,
    this.isPassword = false,
    this.errorText,
    this.headerMaxLines,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.currentNode,
    this.nextNode,
    this.tfMaxLength,
    this.onSubmit,
    this.autoFocus = false,
    this.action = TextInputAction.done,
    this.inputFormatters,
    this.showKeyboardAction = false,
    this.hasBorder = true,
    this.bgColor = UIColors.white,
    this.hintTextColor = UIColors.greyColor,
    this.prefixIcon,
    this.focusBorderColor,
    this.unFocusBorderColor,
    this.onClear,
    this.isShowClearAll = true,
  });

  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Function()? onSubmit;
  final Function(String)? onChanged;
  final bool isPassword;
  final TextInputType? keyboardType;
  final int? headerMaxLines;
  final int? maxLines;
  final TextEditingController? controller;
  final FocusNode? currentNode;
  final FocusNode? nextNode;
  final int? tfMaxLength;
  final bool autoFocus;
  final TextInputAction? action;
  final List<TextInputFormatter>? inputFormatters;
  final bool showKeyboardAction;
  final bool hasBorder;
  final Color bgColor;
  final Color hintTextColor;
  final Widget? prefixIcon;
  final Color? focusBorderColor;
  final Color? unFocusBorderColor;
  final VoidCallback? onClear;
  final bool isShowClearAll;

  @override
  CusTextFieldState createState() => CusTextFieldState();
}

class CusTextFieldState extends State<CusTextField> {
  // Color for border
  bool isHidePassword = true;
  String? errorMessage;
  late FocusNode currentNode;
  bool isShowClearAll = false;

  @override
  void initState() {
    currentNode = widget.currentNode ?? FocusNode();
    super.initState();
    // Change color for border if focus was changed
    currentNode.addListener(() {
      setState(() {
        if (currentNode.hasFocus) {
          errorMessage = null;
          if (widget.controller?.text.isNotEmpty == true) {
            isShowClearAll = true;
          }
          return;
        }
        if (isShowClearAll) {
          isShowClearAll = false;
        }
      });
    });

    if (widget.controller != null) {
      widget.controller!.addListener(() {
        if (currentNode.hasFocus == false) {
          return;
        }
        if (widget.controller!.text.isNotEmpty == true) {
          if (isShowClearAll != true) {
            setState(() {
              isShowClearAll = true;
            });
          }
          return;
        }
        if (isShowClearAll != false) {
          setState(() {
            isShowClearAll = false;
          });
        }
      });
    }
  }

  setErrorMessage(String message) {
    if (!mounted) {
      return;
    }
    setState(() {
      errorMessage = message;
    });
  }

  Color _getColorForTitle() {
    if (errorMessage != null) {
      return Colors.red;
    }
    if (currentNode.hasFocus == true) {
      return UIColors.text;
    }
    return UIColors.text;
  }

  Color _getColorForTextFieldBorder() {
    if (errorMessage != null) {
      return Colors.red;
    }
    if (currentNode.hasFocus == true) {
      return widget.focusBorderColor ?? UIColors.text;
    }
    return widget.unFocusBorderColor ?? UIColors.text;
  }

  Color _getColorForTextFieldBG() {
    if (errorMessage != null) {
      return UIColors.text;
    }
    if (currentNode.hasFocus == true) {
      return widget.bgColor;
    }
    return widget.bgColor;
  }

  Widget getTitleWidget() {
    if (widget.labelText != null) {
      return CusText.bold(
        widget.labelText ?? "",
        fontSize: FontSizes.medium,
        maxLines: widget.headerMaxLines,
        color: _getColorForTitle(),
      );
    }
    return const SizedBox();
  }

  Widget? renderSuffixIcon() {
    if (widget.isPassword) {
      return CusInkWel.base(
        padding: 0,
        onTap: () {
          setState(() {
            isHidePassword = !isHidePassword;
          });
        },
        child: Container(
          width: 40,
          height: 38,
          decoration:  BoxDecoration(
            color: UIColors.greyColor,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: isHidePassword
              ? Assets.icons.icVisibilityOff.svg(
                  width: 16,
                )
              : Assets.icons.icVisibilityOn.svg(
                  width: 16,
                ),
        ),
      );
    }

    if (isShowClearAll && widget.isShowClearAll) {
      return CusInkWel.base(
        padding: 0,
        onTap: () {
          if (widget.onClear != null) {
            widget.onClear!();
          }
          widget.controller!.clear();
        },
        child: Assets.icons.icClear.svg(
          height: 24,
          fit: BoxFit.scaleDown,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        getTitleWidget(),
        KeyboardActions(
          enable: widget.showKeyboardAction,
          config: KeyboardActionsConfig(
            keyboardBarColor: UIColors.white,
            nextFocus: false,
            actions: [
              if ([
                TextInputType.phone,
                TextInputType.number,
              ].contains(widget.keyboardType))
                KeyboardActionsItem(
                  focusNode: currentNode,
                  toolbarButtons: [
                    (node) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.nextNode != null) {
                            widget.nextNode!.requestFocus();
                          } else {
                            currentNode.unfocus();
                          }
                        },
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(8.0),
                          child: CusText.bold(
                            "Tiếp tục",
                            color: Colors.blue,
                          ),
                        ),
                      );
                    }
                  ],
                ),
            ],
          ),
          disableScroll: true,
          child: Container(
            padding: EdgeInsets.only(left: 8, right: widget.isPassword ? 0 : 8),
            margin: EdgeInsets.only(top: widget.labelText != null ? 8 : 0),
            decoration: BoxDecoration(
              color: _getColorForTextFieldBG(),
              border: widget.hasBorder
                  ? Border.all(color: _getColorForTextFieldBorder())
                  : null,
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextField(
              autofocus: widget.autoFocus,
              controller: widget.controller,
              onChanged: widget.onChanged,
              focusNode: currentNode,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              textInputAction: widget.nextNode != null
                  ? TextInputAction.next
                  : widget.action,
              enableInteractiveSelection: true,
              obscureText: widget.isPassword == true ? isHidePassword : false,
              maxLines: widget.maxLines,
              style: const TextStyle(
                color: UIColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                border: InputBorder.none,
                fillColor: Colors.transparent,
                hintStyle: TextStyle(
                  color: widget.hintTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
                suffixStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                isDense: true,
                filled: true,
                hintText: widget.hintText?.trim(),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: 40,
                  maxHeight: 40,
                ),
                suffixIcon: renderSuffixIcon(),
                counterText: '',
                prefixIconConstraints: widget.prefixIcon != null
                    ? const BoxConstraints(
                        minHeight: 24,
                        minWidth: 24,
                      )
                    : const BoxConstraints(
                        maxWidth: 24,
                        maxHeight: 24,
                      ),
                prefixIcon: widget.prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: widget.prefixIcon,
                      )
                    : const SizedBox(
                        width: 8,
                      ),
              ),
              obscuringCharacter: '*',
              onEditingComplete: () {
                if (widget.nextNode != null) {
                  widget.nextNode!.requestFocus();
                } else {
                  currentNode.unfocus();
                }
                if (widget.onSubmit != null) {
                  widget.onSubmit!.call();
                }
              },
              maxLength: widget.tfMaxLength,
            ),
          ),
        ),
      ],
    );
  }
}
