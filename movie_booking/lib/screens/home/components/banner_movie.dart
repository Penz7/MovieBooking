import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/utils/common/cus_image.dart';
import 'package:movie_booking/utils/common/cus_inkwel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerMovie extends StatefulWidget {
  const BannerMovie({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BannerMovieState();
  }
}

class _BannerMovieState extends State<BannerMovie> {
  static const List<Map<String, String>> data = [
    {
      'url':
          'https://images.pexels.com/photos/19597529/pexels-photo-19597529/free-photo-of-dan-ong-b-bi-n-cat-cho.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
    },
    {
      'url':
          'https://images.pexels.com/photos/20623990/pexels-photo-20623990/free-photo-of-b-c-ma-xanh-m-ng-m.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
    },
    {
      'url':
          'https://images.pexels.com/photos/17867773/pexels-photo-17867773/free-photo-of-h-u-di-b.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
    },
    {
      'url':
          'https://images.pexels.com/photos/19245513/pexels-photo-19245513/free-photo-of-dan-ong-di-d-o-may-nh-nhi-p-nh-gia.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
    },
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          width: size.width,
          height: size.height / 7,
          child: CarouselSlider.builder(
            itemCount: data.length,
            itemBuilder: (
              BuildContext context,
              int index,
              int pageIndex,
            ) {
              return CusInkWel.base(
                child: CusInternetImage(
                  url: data[index]['url'].toString(),
                  fit: BoxFit.fitHeight,
                  height: 30,
                  width: size.width,
                ),
                onTap: () {},
              );
            },
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
              enlargeCenterPage: false,
              enableInfiniteScroll: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.5,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: data.length,
            effect: const WormEffect(
              dotColor: UIColors.appBarColor,
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: UIColors.splash,
            ),
            axisDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
