import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie_booking/generated/assets.gen.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controllers/cinema_controller.dart';
import 'package:movie_booking/network/controllers/cinema_room_controller.dart';
import 'package:movie_booking/network/controllers/location_controller.dart';
import 'package:movie_booking/network/models/cinema.dart';
import 'package:movie_booking/network/models/cinema_room.dart';
import 'package:movie_booking/screens/booking/components/cinema_item.dart';
import 'package:movie_booking/screens/booking/components/list_cinema.dart';
import 'package:movie_booking/screens/booking/components/list_date.dart';
import 'package:movie_booking/utils/common/cus_appbar.dart';
import 'package:movie_booking/utils/common/cus_text.dart';
import 'package:movie_booking/utils/constants/font_sizes.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({
    super.key,
    required this.movieId,
  });
  final String movieId;
  @override
  State<StatefulWidget> createState() {
    return _BookingScreenState();
  }
}

class _BookingScreenState extends State<BookingScreen> {
  final LocationController _locationController = Get.put(LocationController());
  final CinemaController _cinemaController = Get.find<CinemaController>();
  final CinemaRoomController _cinemaRoomController =
      Get.put(CinemaRoomController());
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    _cinemaController.getCinemaByID(_cinemaController.allCinema.first.id ?? "");
    _cinemaRoomController.getCinemaRoomById(_cinemaController.selectedCinema.first.id ?? '', widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: UIColors.d9d9d9,
        appBar: CusAppbar.base(
          textColor: UIColors.white,
          title: widget.movieId,
          backgroundColor: UIColors.splash,
        ),
        body: ListView(
          children: [
            ListDate(
              onDateSelected: (DateTime date) {
                _locationController.updateSelectedDate(date);
              },
            ),
            ListCinema(
                date: _locationController.selectedDate.value,
                onCinemaSelected: (Cinema data) {
                  _cinemaController.getCinemaByID(data.id ?? "");
                  _cinemaRoomController.getCinemaRoomById(
                      data.id ?? "", widget.movieId);
                }),
            Obx(() {
              List<Cinema> datas = _cinemaController.selectedCinema.toList();

              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CusText.bold(
                      (datas.isNotEmpty)
                          ? _cinemaController.selectedCinema.first.name ?? ""
                          : "",
                      fontSize: FontSizes.extra,
                      color: UIColors.black,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: UIColors.splash,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Row(
                          children: [
                            Assets.icons.facebook.svg(
                              color: UIColors.splash,
                              fit: BoxFit.scaleDown,
                              width: 12,
                              height: 12,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            CusText.semiBold(
                              _locationController.city.value,
                              maxLines: 1,
                              color: UIColors.splash,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
            Obx(
              () {
                if (_cinemaController.selectedCinema.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                } else {
                  List<Cinema> cinema =
                      _cinemaController.selectedCinema.toList();
                  List<CinemaRoom> allCinemaRoom =
                      _cinemaRoomController.allCinemaRoombyID.toList();

                  if (cinema.isEmpty || allCinemaRoom.isEmpty) {
                    return Container(
                      alignment: Alignment.center,
                      child: FutureBuilder(
                        future: Future.delayed(const Duration(
                          milliseconds: 500,
                        )),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            return CusText.bold('Hiện không có suất chiếu');
                          }
                        },
                      ),
                    );
                  } else {
                    return Container(
                      color: UIColors.white,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CinemaItem(
                            cinema: cinema[index],
                            cinemaRooms: allCinemaRoom,
                            movieId: widget.movieId,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            child: Divider(
                              color: UIColors.d9d9d9,
                              height: 1,
                              thickness: 1,
                            ),
                          );
                        },
                        itemCount: cinema.length,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
