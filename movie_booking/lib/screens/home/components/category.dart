import 'package:flutter/material.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategoriesState();
  }
}

class _CategoriesState extends State<Categories> {
  static const List<Map<String, String>> data = [
    {
      'name': 'Movies',
      'url': 'https://cdn-icons-png.flaticon.com/512/686/686458.png'
    },
    {
      'name': 'Events',
      'url': 'https://cdn-icons-png.flaticon.com/512/686/686458.png'
    },
    {
      'name': 'Plays',
      'url': 'https://cdn-icons-png.flaticon.com/512/686/686458.png'
    },
    {
      'name': 'Sports',
      'url': 'https://cdn-icons-png.flaticon.com/512/686/686458.png'
    },
    {
      'name': 'Activity',
      'url': 'https://cdn-icons-png.flaticon.com/512/686/686458.png'
    },
    {
      'name': 'Monum',
      'url': 'https://cdn-icons-png.flaticon.com/512/686/686458.png'
    },
    {
      'name': 'Monum',
      'url': 'https://cdn-icons-png.flaticon.com/512/686/686458.png'
    },
    {
      'name': 'Monum',
      'url': 'https://cdn-icons-png.flaticon.com/512/686/686458.png'
    },
    {
      'name': 'Monum',
      'url': 'https://cdn-icons-png.flaticon.com/512/686/686458.png'
    },
    {
      'name': 'Monum',
      'url': 'https://cdn-icons-png.flaticon.com/512/686/686458.png'
    },
    {
      'name': 'Monum',
      'url': 'https://cdn-icons-png.flaticon.com/512/686/686458.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 8,
        left: 16,
        right: 16,
      ),
      color: UIColors.white,
      width: size.width,
      height: size.height / 10,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          return Column(
            children: [
              CusInternetImage(
                url: data[index]['url'].toString(),
                height: 24,
                width: 24,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: CusText.base(
                  data[index]['name'].toString(),
                  fontSize: FontSizes.medium,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 40,
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
