import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_booking/utils/common/cus_text.dart';


class ThanksSection extends StatelessWidget {
  const ThanksSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          'assets/files/order_success.json',
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
       const SizedBox(height: 16,),
        CusText.semiBold(
          'CẢM ƠN BẠN ĐÃ ĐẶT VÉ TẠI ỨNG DỤNG CỦA CHÚNG TÔI',
          fontSize: 16,
          textAlign: TextAlign.center,
          maxLines: 4,
        ),
        const SizedBox(height: 32,),
       Lottie.asset(
          'assets/files/order_happy.json',
          width:300,
          height:300,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
