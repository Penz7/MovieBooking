import 'package:flutter/material.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/models/movie.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({
    super.key,
    required this.movie,
    required this.cinemaId,
    required this.cinemaRoomId,
    required this.seatId,
  });

  final Movie movie;
  final String cinemaId;
  final String cinemaRoomId;
  final String seatId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: UIColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: UIColors.black.withOpacity(
                  0.015,
                ),
                blurRadius: 8,
                offset: const Offset(
                  0,
                  2,
                ))
          ],),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 20,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CusInternetImage(
            url: movie.imageUrl ?? "",
            width: 100,
            height: 150,
            borderRadius: 8,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(
            width: 16,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CusText.bold(
                  'Tên phim: ${movie.name}',
                  fontSize: FontSizes.big,
                  maxLines: 2,
                ),
                const SizedBox(height: 8,),
                CusText.medium(
                  'Rạp: $cinemaId',
                  maxLines: 1,
                  fontSize: FontSizes.medium,
                ),
                const SizedBox(height: 8,),
                CusText.medium(
                  'Phòng chiếu: $cinemaRoomId',
                  maxLines: 1,
                  
                ),
                const SizedBox(height: 8,),
                CusText.medium(
                  'Ghế: $seatId',
                  maxLines: 1,
                
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
