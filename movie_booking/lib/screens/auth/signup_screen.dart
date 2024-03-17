import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_booking/generated/assets.gen.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controller/auth_controller.dart';
import 'package:movie_booking/utils/common/cus_inkwel.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';
import 'package:movie_booking/utils/constants/input_validatior.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cnfPassController = TextEditingController();

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
               const SizedBox(
                height: 20,
              ),
             Assets.icons.splashIcon.svg(
                height: 50,
                alignment: Alignment.topCenter,
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
                    TextFormField(
                      style: const TextStyle(
                        color: UIColors.black,
                      ),
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Name",
                        hintStyle: const TextStyle(
                          color: Colors.black45,
                        ),
                        fillColor: UIColors.greyColor,
                        filled: true,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: const TextStyle(
                        color: UIColors.black,
                      ),
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Email Address",
                        hintStyle: const TextStyle(
                          color: Colors.black45,
                        ),
                        fillColor: UIColors.greyColor,
                        filled: true,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: const TextStyle(
                        color: UIColors.black,
                      ),
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          color: Colors.black45,
                        ),
                        fillColor: UIColors.greyColor,
                        filled: true,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: const TextStyle(color: UIColors.black),
                      controller: cnfPassController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(color: Colors.black45),
                        fillColor: UIColors.greyColor,
                        filled: true,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (InputValidator.validateField("Name", nameController.text.trim()) &&
                            InputValidator.validateField("Email", emailController.text.trim())) {
                          if (InputValidator.validatePassword(passwordController.text, cnfPassController.text)) {
                            AuthController.instance.registerUser(emailController.text.trim(), passwordController.text.trim());
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
              const SizedBox(height: 16,),
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
                          Get.back();
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
    );
  }
}
