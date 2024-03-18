import 'package:flutter/material.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class MoviesComming extends StatefulWidget {
  const MoviesComming({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MoviesCommingState();
  }
}

class _MoviesCommingState extends State<MoviesComming> {
  static const List<Map<String, dynamic>> data = [
    {
      'name': 'Movies',
      'url':
          'https://images.pexels.com/photos/7299586/pexels-photo-7299586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'category': ' Horror, Action, Romantic',
      'date': '27/03/2024'
    },
    {
      'name': 'Movies',
      'url':
          'https://images.pexels.com/photos/7299586/pexels-photo-7299586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'category': ' Horror, Action, Romantic',
      'date': '27/03/2024'
    },
    {
      'name': 'Movies',
      'url':
          'https://images.pexels.com/photos/7299586/pexels-photo-7299586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'category': ' Horror, Action, Romantic',
      'date': '27/03/2024'
    },
    {
      'name': 'Movies',
      'url':
          'https://images.pexels.com/photos/7299586/pexels-photo-7299586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'category': ' Horror, Action, Romantic',
      'date': '27/03/2024'
    },
    {
      'name': 'Movies',
      'url':
          'https://images.pexels.com/photos/7299586/pexels-photo-7299586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'category': ' Horror, Action, Romantic',
      'date': '27/03/2024'
    },
    {
      'name': 'Movies',
      'url':
          'https://images.pexels.com/photos/7299586/pexels-photo-7299586.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'category': ' Horror, Action, Romantic',
      'date': '27/03/2024'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 2.5,
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
              CusText.semiBold(
                data[index]['date'].toString(),
                fontSize: FontSizes.moreSmall,
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
                child: CusText.bold(
                  data[index]['category'].toString(),
                  fontSize: FontSizes.small,
                  color: UIColors.d9d9d9,
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
