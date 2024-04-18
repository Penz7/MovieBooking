import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_booking/generated/assets.gen.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/auth_controller.dart';
import 'package:movie_booking/utils/common/cus_inkwel.dart';
import 'package:movie_booking/utils/common/cus_loading.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/common/cus_text_field.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';
import 'package:movie_booking/utils/constants/input_validatior.dart';
import 'package:movie_booking/utils/dialog/dialog_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cnfPassController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cnfPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      backgroundColor: UIColors.splash,
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Container(
                color: Colors.transparent,
                height: size.height,
                width: size.width,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  scrollDirection: Axis.vertical,
                  children: [
                    Assets.icons.splashIcon.svg(
                      height: 50,
                      alignment: Alignment.topCenter,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CusText.semiBold(
                      'Welcome you!',
                      color: UIColors.white,
                      fontSize: FontSizes.moreExtra,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CusText.medium(
                      'Login to book your seat, I said its your seat',
                      color: UIColors.white,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(19),
                      decoration: BoxDecoration(
                        color: UIColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CusText.semiBold(
                            'Create your account',
                            fontSize: FontSizes.big,
                            color: UIColors.splash,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CusTextField(
                            bgColor: UIColors.greyColor,
                            controller: _nameController,
                            hintText: 'Fullname',
                            hasBorder: false,
                            hintTextColor: UIColors.text,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CusTextField(
                            bgColor: UIColors.greyColor,
                            controller: _emailController,
                            hintText: 'Email',
                            hasBorder: false,
                            hintTextColor: UIColors.text,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CusTextField(
                            bgColor: UIColors.greyColor,
                            controller: _passwordController,
                            hintText: 'Password',
                            isPassword: true,
                            hasBorder: false,
                            hintTextColor: UIColors.text,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CusTextField(
                            bgColor: UIColors.greyColor,
                            controller: _cnfPassController,
                            hintText: 'Confirm password',
                            hasBorder: false,
                            isPassword: true,
                            hintTextColor: UIColors.text,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: _authController.isLoading.value
                                ? null
                                : () {
                                    if (InputValidator.validateField(
                                          "Name",
                                          _nameController.text.trim(),
                                        ) &&
                                        InputValidator.validateField(
                                          "Email",
                                          _emailController.text.trim(),
                                        )) {
                                      if (InputValidator.validatePassword(
                                        _passwordController.text,
                                        _cnfPassController.text,
                                      )) {
                                        AuthController.instance.registerUser(
                                          context,
                                          _emailController.text.trim(),
                                          _passwordController.text.trim(),
                                        );
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: UIColors.splash,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: CusText.semiBold(
                                  'SIGNUP',
                                  fontSize: FontSizes.big,
                                  color: UIColors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: UIColors.black.withOpacity(0.3),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: CusText.regular(
                                  "Or",
                                  color: UIColors.text,
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: UIColors.black.withOpacity(0.3),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CusInkWel.padding(
                                onTap: () {
                                  AuthController.instance.googleLogin(context);
                                },
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children: [
                                    Assets.icons.google.svg(),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    CusText.base(
                                      'Google',
                                      fontSize: FontSizes.medium,
                                    ),
                                  ],
                                ),
                              ),
                              CusInkWel.padding(
                                onTap: () {
                                  DialogProvider.instance.showMessageDialog(
                                    context,
                                    message:
                                        'This feature is maintaining! Please comback later!!',
                                  );
                                },
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children: [
                                    Assets.icons.facebook.svg(),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    CusText.base(
                                      'Facebook',
                                      fontSize: FontSizes.medium,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account ? ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: GoogleFonts.quicksand().fontFamily,
                            ),
                          ),
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700,
                              fontFamily: GoogleFonts.quicksand().fontFamily,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              },
                          ),
                          TextSpan(
                            text: " here.",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: GoogleFonts.quicksand().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(
              () {
                return _authController.isLoading.value
                    ? const Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: CusLoading(),
                      )
                    : const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
