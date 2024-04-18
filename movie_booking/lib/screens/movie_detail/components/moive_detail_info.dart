import 'package:flutter/material.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/models/movie.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class MovieDetailInfo extends StatelessWidget {
  const MovieDetailInfo({
    required this.data,
    super.key,
  });

  final Movie data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: UIColors.black.withOpacity(
                        0.015,
                      ),
                      offset: const Offset(
                        0,
                        2,
                      ),
                      spreadRadius: 10,
                    )
                  ],
                ),
                child: CusInternetImage(
                  url:
                      data.imageUrl ?? '',
                  height: 200,
                  width: 150,
                  fit: BoxFit.cover,
                  borderRadius: 20,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 36,
                    ),
                    CusText.bold(
                      data.name ?? '',
                      fontSize: FontSizes.big,
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CusText.medium(
                      data.categoryName ?? '',
                      maxLines: 2,
                      color: UIColors.d9d9d9,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CusText.medium(
                      'Phim được phép phổ biến đến người xem mọi độ tuổi',
                      maxLines: 3,
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              infor(
                info: data.formatDate(data.createDate!),
                title: 'Ngày khởi chiếu',
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                color: UIColors.d9d9d9,
                height: 20,
                width: 1,
              ),
              infor(
                info: '${data.time.toString()} phút',
                title: 'Thời lượng',
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                color: UIColors.d9d9d9,
                height: 20,
                width: 1,
              ),
              infor(
                info: 'Lồng tiếng',
                title: 'Ngôn ngữ',
              ),
            ],
          ),
         
        ],
      ),
    );
  }
}

Widget infor({
  required info,
  required title,
}) {
  return Column(
    children: [
      CusText.bold(
        title,
        color: UIColors.d9d9d9,
        textAlign: TextAlign.center,
      ),
      CusText.medium(
        info,
        textAlign: TextAlign.center,
      )
    ],
  );
}
