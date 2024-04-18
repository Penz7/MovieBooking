import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking/generated/assets.gen.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/models/cinema.dart';
import 'package:movie_booking/network/models/cinema_room.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class CinemaItem extends StatelessWidget {
  const CinemaItem({
    super.key,
    required this.cinema,
    required this.cinemaRooms,
    required this.movieId,
  });

  final Cinema cinema;
  final List<CinemaRoom> cinemaRooms;
  final String movieId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CusInternetImage(
              url: cinema.urlImage ?? "",
              borderRadius: 6,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CusText.medium(
                    cinema.name ?? "",
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  CusText.medium(
                    'Bạn đang cách rạp này ${cinema.distance} km',
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: UIColors.d9d9d9,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Assets.icons.icHeart.svg(
                  color: UIColors.d9d9d9,
                  height: 12,
                  width: 12,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: () {},
              child: Assets.icons.icDropdown.svg(
                color: UIColors.d9d9d9,
                height: 12,
                width: 12,
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: CusText.medium(
            cinema.addressAll ?? "",
            fontSize: FontSizes.medium,
            color: UIColors.d9d9d9,
          ),
        ),
        CusText.bold(
          '2D Phụ đề',
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 45,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: cinemaRooms.length,
            itemBuilder: (context, index) {
              final data = cinemaRooms[index];
              return GestureDetector(
                onTap: () {
                  context.push(
                    '/home/movie-detail/$movieId/booking/$movieId/seat',
                    extra: {
                      'movie_id': movieId,
                      'cinema_id': cinema.id,
                      'cinema_room_id': data.idRoom,
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: UIColors.d9d9d9,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: data.name ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSizes.big,
                          ),
                        ),
                        const TextSpan(
                          text: '',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: FontSizes.medium,
                            color: UIColors.d9d9d9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 15,
              );
            },
          ),
        ),
      ],
    );
  }
}
