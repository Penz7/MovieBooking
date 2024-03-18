import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_booking/generated/assets.gen.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controller/auth_controller.dart';
import 'package:movie_booking/utils/common/cus_inkwel.dart';
import 'package:movie_booking/utils/common/cus_loading.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/common/cus_text_field.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';
import 'package:movie_booking/utils/constants/input_validatior.dart';
import 'package:movie_booking/utils/dialog/dialog_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _forgotEmailController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _forgotEmailController.dispose();
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
                      height: 40,
                    ),
                    Container(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      height: size.height / 1.8,
                      decoration: BoxDecoration(
                        color: UIColors.white,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: UIColors.black.withOpacity(
                              0.04,
                            ),
                            offset: const Offset(
                              0,
                              2,
                            ),
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CusText.semiBold(
                            'Login to your account',
                            color: UIColors.splash,
                            fontSize: FontSizes.big,
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
                            controller: _passwordController,
                            bgColor: UIColors.greyColor,
                            hintText: 'Password',
                            hintTextColor: UIColors.text,
                            isPassword: true,
                            hasBorder: false,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () async {
                                final result = await DialogProvider.instance
                                    .showCustomDialog(
                                  context,
                                  dialog: AlertDialog(
                                    backgroundColor: UIColors.splash,
                                    title: CusText.semiBold(
                                      "Forgot password?",
                                      fontSize: FontSizes.medium,
                                      color: UIColors.white,
                                    ),
                                    content: CusTextField(
                                      controller: _forgotEmailController,
                                      hintText: "Enter your email",
                                      hasBorder: false,
                                      hintTextColor: UIColors.text,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: CusText.base(
                                          "Cancel",
                                          fontSize: FontSizes.medium,
                                          color: UIColors.white,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          String email = _forgotEmailController
                                              .text
                                              .trim();
                                          if (InputValidator.validateField(
                                            "ForgotPassword",
                                            _forgotEmailController.text.trim(),
                                          )) {
                                            AuthController.instance
                                                .forgotPassword(context, email);
                                            _forgotEmailController.text = "";
                                            Navigator.of(context).pop(true);
                                          }
                                        },
                                        child: CusText.base(
                                          "Send",
                                          fontSize: FontSizes.medium,
                                          color: UIColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                                if (result == true && context.mounted) {
                                  Get.back();
                                }
                              },
                              child: CusText.base("Forgot Password?"),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ElevatedButton(
                            onPressed: _authController.isLoading.value
                                ? null
                                : () {
                                    _authController.login(context,
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: UIColors.splash,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: CusText.semiBold(
                                  "LOGIN",
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
                                  color: UIColors.black.withOpacity(
                                    0.3,
                                  ),
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
                                  color: UIColors.black.withOpacity(
                                    0.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
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
                            text: "Don’t have an account ? ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: GoogleFonts.quicksand().fontFamily,
                            ),
                          ),
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700,
                              fontFamily: GoogleFonts.quicksand().fontFamily,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/login/sign-up');
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
                    ),
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
