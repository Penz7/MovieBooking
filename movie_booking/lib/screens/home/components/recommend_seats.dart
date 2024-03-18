import 'package:flutter/material.dart';
import 'package:movie_booking/generated/assets.gen.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class RecommendSeats extends StatefulWidget {
  const RecommendSeats({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RecommendSeatsState();
  }
}

class _RecommendSeatsState extends State<RecommendSeats> {
  static const List<Map<String, dynamic>> data = [
    {
      'name': 'Movies',
      'url': 'https://images.pexels.com/photos/7299586/pexels-photo-7299586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'rating': 80
    },
    {
      'name': 'Events',
           'url': 'https://images.pexels.com/photos/7299586/pexels-photo-7299586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'rating': 80
    },
    {
      'name': 'Plays',
          'url': 'https://images.pexels.com/photos/7299586/pexels-photo-7299586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'rating': 80
    },
    {
      'name': 'Sports',
           'url': 'https://images.pexels.com/photos/7299586/pexels-photo-7299586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'rating': 80
    },
    {
      'name': 'Activity',
          'url': 'https://images.pexels.com/photos/7299586/pexels-photo-7299586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'rating': 80
    },
    {
      'name': 'Monum',
          'url': 'https://images.pexels.com/photos/7299586/pexels-photo-7299586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'rating': 80
    },
    {
      'name': 'Monum',
        'url': 'https://images.pexels.com/photos/7299586/pexels-photo-7299586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'rating': 80
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 2.7,
      color: UIColors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ListView.separated(
        
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CusInternetImage(
                borderRadius: 20,
                url: data[index]['url'].toString(),
                fit: BoxFit.fitHeight,
                width: 150,
                height: 230,
              ),
              const SizedBox(
                height: 8,
              ),
              CusText.bold(
                data[index]['name'].toString(),
                fontSize: FontSizes.big,
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: Row(
                  children: [
                    Assets.icons.icHeart.svg(
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CusText.medium(
                      '${data[index]['rating'].toString()}%',
                      fontSize: FontSizes.medium,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 30,
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
