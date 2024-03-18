import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_booking/network/controller/auth_controller.dart';
import 'package:movie_booking/utils/common/appbutton.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class ProfileAccountScreen extends StatefulWidget {
  const ProfileAccountScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileAccountScreenState();
  }
}

class _ProfileAccountScreenState extends State<ProfileAccountScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
          children: [
            CusText.semiBold(
              'This is profile screen',
              fontSize: FontSizes.extra,
            ),
            ElevatedButton(
              child: CusText.base("Sign out"),
              onPressed: () {
                _authController.signOut();
              },
            )
          ],
        ),
    );
  }
}
