import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/utils/common/appbutton.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class MainTabBarScreen extends StatefulWidget {
  const MainTabBarScreen({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<MainTabBarScreen> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.navigationShell,
      bottomNavigationBar: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
           
            padding: const EdgeInsets.only(
              bottom: 8,
            ),
            decoration: BoxDecoration(
              color: UIColors.white,
              boxShadow: [
                BoxShadow(
                  color: UIColors.black.withOpacity(0.15),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  rowItem(
                    image: 'ic_home',
                    text: 'Home',
                    index: 0,
                  ),
                  rowItem(
                    image: 'ic_explore',
                    text: 'Booking',
                    index: 1,
                  ),
                  rowItem(
                    image: 'ic_practice',
                    text: 'Notification',
                    index: 2,
                  ),
                  rowItem(
                    image: 'ic_account',
                    text: 'Account',
                    index: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
    );
  }

  Widget rowItem({
    required String image,
    required String text,
    required int index,
    int? badge,
  }) {
    final selected = widget.navigationShell.currentIndex == index;
    return AppButton.widget(
      onPressed: () {
        _onTap(index, context);
      },
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                SvgPicture.asset(
                  selected
                      ? 'assets/icons/navigation/${image}_active.svg'
                      : 'assets/icons/navigation/$image.svg',
                  width: 24,
                  height: 24,
                ),
                if (badge != null) _buildBadge(badge),
              ],
            ),
            CusText.regular(
              text,
              fontSize: 10,
              color: selected ? UIColors.splash : UIColors.text,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(int badge) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: UIColors.splash,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: CusText.regular(
          '1',
          fontSize: FontSizes.extraSmall,
          color: UIColors.white,
        ),
      ),
    );
  }

  Future<void> _onTap(int index, BuildContext context) async {
    final auth = FirebaseAuth.instance;

    switch (index) {
      case 3:
        final user = auth.currentUser;
        if (user == null) {
          // TempData.prePath = '/profile';
          Navigator.of(context).pushNamed('/login');
        } else {
          widget.navigationShell.goBranch(index);
        }
        break;
      default:
        widget.navigationShell.goBranch(index);
    }
  }
}
