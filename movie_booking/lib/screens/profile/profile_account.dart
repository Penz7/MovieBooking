import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking/generated/assets.gen.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controller/auth_controller.dart';
import 'package:movie_booking/screens/home/components/title_heading.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_loading.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/dialog/dialog_provider.dart';
import 'package:movie_booking/utils/dialog/view/confirm_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: UIColors.appBarColor,
    ));
    String? picUrl = AuthController.instance.user!.photoURL;
    picUrl = picUrl ?? "Constants.dummyAvatar";
    String? name = AuthController.instance.user!.displayName;
    String? email = AuthController.instance.user!.email;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: UIColors.fafafa,
      body: Stack(
        children: [
          SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 40,
                      ),
                      height: 150,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: UIColors.appBarColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: size.width * 0.5 - 50,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: CusInternetImage(
                            fit: BoxFit.cover,
                            url: picUrl,
                            height: 150,
                            width: 150,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: size.width * 0.5 + 20,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: UIColors.appBarColor,
                        ),
                        child: Assets.icons.icCamera.svg(
                          // ignore: deprecated_member_use_from_same_package
                          color: UIColors.white,
                          width: 13,
                          height: 13,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
                TitleHeading(
                  title: "Information: ",
                  onTap: () {
                    context.go('/profile/account-detail');
                  },
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  color: UIColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: CusText.semiBold('Fullname: '),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: CusText.medium(
                              name ?? "NO Name",
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: CusText.semiBold('Email: '),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: CusText.medium(
                              email.toString(),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: CusText.semiBold('Phone: '),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: CusText.medium(
                              "This service is maintaining",
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: UIColors.greyColor,
                ),
                Container(
                  color: UIColors.white,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: CusText.bold(
                    'Documentation: ',
                  ),
                ),
                Container(
                  color: UIColors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.privacy_tip_outlined,
                          size: 20,
                        ),
                        title: CusText.medium(
                          'Privacy Policy',
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.share,
                          size: 20,
                        ),
                        title: CusText.medium(
                          'Share',
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.logout_outlined,
                          size: 20,
                          color: Colors.red,
                        ),
                        title: CusText.medium(
                          'Logout',
                          color: Colors.red,
                        ),
                        onTap: _authController.isLoading.value
                            ? null
                            : () async {
                                final result = await DialogProvider.instance
                                    .showCustomDialog(
                                  context,
                                  dialog: const ConfirmDialog(
                                    title: '',
                                    message: 'You want to log out?',
                                    confirmButtonTitle: 'Agree',
                                    cancelButtonTitle: 'Cancel',
                                  ),
                                );
                                if (result == true && context.mounted) {
                                  _authController
                                      .signOut(context); 
                                }
                              },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () {
              return _authController.isLoading.value
                  ? const Positioned.fill(
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
    );
  }
}
