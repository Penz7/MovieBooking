import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_booking/generated/assets.gen.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controller/auth_controller.dart';
import 'package:movie_booking/screens/auth/signup_screen.dart';
import 'package:movie_booking/utils/common/cus_inkwel.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotEmailController = TextEditingController();

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
                    TextFormField(
                      controller: emailController,
                      style: const TextStyle(
                        color: UIColors.text,
                        fontSize: FontSizes.medium,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Username",
                        hintStyle: const TextStyle(
                          color: Colors.black45,
                          fontSize: FontSizes.medium,
                        ),
                        fillColor: UIColors.greyColor,
                        filled: true,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: passwordController,
                      style: const TextStyle(
                        color: UIColors.text,
                        fontSize: FontSizes.medium,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          color: Colors.black45,
                          fontSize: FontSizes.medium,
                        ),
                        fillColor: UIColors.greyColor,
                        filled: true,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                           AuthController.instance.forgorPassword(forgotEmailController.text.trim(),);
                                forgotEmailController.text = "";
                                Get.back();
                        },
                        child: CusText.base(
                          "Forgot Password?",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        AuthController.instance.login(emailController.text.trim(), passwordController.text.trim(),);
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
                          onTap: () {},
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
                          onTap: () {},
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
                          Get.to(const SignUpScreen());
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
    );
  }
}
