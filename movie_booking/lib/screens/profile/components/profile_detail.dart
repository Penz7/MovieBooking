import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/auth_controller.dart';
import 'package:movie_booking/utils/common/appbutton.dart';
import 'package:movie_booking/utils/common/cus_appbar.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/common/cus_text_field.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class AccountDetailScreen extends StatefulWidget {
  const AccountDetailScreen({super.key});

  @override
  AccountDetailScreenState createState() => AccountDetailScreenState();
}

class AccountDetailScreenState extends State<AccountDetailScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? name = AuthController.instance.user!.displayName ?? "NO Name";
    String? email = AuthController.instance.user!.email;
    String? phone = AuthController.instance.user!.phoneNumber ?? "0000000000";
    _phoneController.text = phone;
    _nameController.text = name;
    _emailController.text = email.toString();

    void refresh(){
        setState(() {
      _nameController.text = _authController.updateName.value;
    });
    }
  

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CusAppbar.customTitle(
        backgroundColor: UIColors.appBarColor,
        title: CusText.semiBold(
          'Infomation account',
          fontSize: FontSizes.big,
          color: UIColors.white,
        ),

      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  color: UIColors.white,
                  margin: const EdgeInsets.only(
                    top: 16,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CusText.semiBold(
                        'Fullname',
                      ),
                      CusTextField(
                        controller: _nameController,
                        hintText: '',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CusText.semiBold(
                        'Phonenumber',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: UIColors.text,
                          ),
                        ),
                        child: CusText.medium(
                          'This service is not update',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CusText.semiBold(
                        'Email',
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: UIColors.text,
                          ),
                        ),
                        child: CusText.medium(
                          email ?? '',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: 24,
                ),
                decoration: BoxDecoration(
                  color: UIColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: UIColors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: AppButton.fill(
                  title: 'Update account',
                  width: size.width,
                  hideKeyboardWhenClick: true,
                  onPressed: () async {
                    final fullName = _nameController.text.trim();
                    _authController.updateProfile(
                      context,
                      newDisplayName: fullName,
                    );
                    refresh();
                  },
                ),
              ),
            ),
            //          Obx(
            //   () {
            //     return _authController.isLoading.value
            //         ? const Positioned.fill(
            //             top: 0,
            //             left: 0,
            //             right: 0,
            //             bottom: 0,
            //             child: CusLoading(),
            //           )
            //         : const SizedBox.shrink();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
