import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/screens/checkout/thank/components/thank_section.dart';

class ThankScreen extends StatelessWidget {
  const ThankScreen({
    super.key,
  });

  Widget bottomBar(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: AppBar().preferredSize.height,
        child: ElevatedButton(
          onPressed: () {
            context.go('/home');
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: const Center(
            child: Text(
              'Tiếp tục chọn phim',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(context),
      backgroundColor: UIColors.splash,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: UIColors.white,
          child: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ThanksSection(),
                SizedBox(
                  height: 48,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
