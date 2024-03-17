import 'package:flutter/material.dart';
import 'package:movie_booking/network/controller/auth_controller.dart';
import 'package:movie_booking/utils/common/cus_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          AuthController.instance.signOut();
        },
        child: CusText.base('Logout'),
      ),
    );
  }
}
