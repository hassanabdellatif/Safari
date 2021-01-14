import 'package:flutter/material.dart';
import 'package:project/Controllers/firestore/DataBase.dart';
import 'package:project/constants_colors.dart';
import 'package:project/locale_language/localization_delegate.dart';
import 'package:project/models/hotel.dart';
import 'package:project/view/details_screens/hotel_details.dart';
import 'package:provider/provider.dart';
import 'hotel_service.dart';

class HotelSearchStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Hotel>>.value(
      value: DataBase().getAllHotels,
      catchError: (_, err) => throw Exception(err),
      child: HotelsService(),
    );
  }
}

class hotelSearch extends StatelessWidget {
  final hotelList;
  hotelSearch({@required this.hotelList});

  @override
  Widget build(BuildContext context) {
    final Locale appLocale = Localizations.localeOf(context);
    return Expanded(
      child: ListView.builder(
          itemCount:
              hotelList != null && hotelList.length > 0 ? hotelList.length : 0,
          itemBuilder: (context, index) {
            final Hotel currentHotel = hotelList[index];

            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: AppLocalization.of(context)
                                        .locale
                                        .languageCode ==
                                    "ar"
                                ? Radius.circular(0)
                                : Radius.circular(15),
                            right: AppLocalization.of(context)
                                        .locale
                                        .languageCode ==
                                    "ar"
                                ? Radius.circular(15)
                                : Radius.circular(0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(currentHotel.images[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      currentHotel.hotelName,
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 9, top: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_sharp,
                                        color: primaryColor,
                                        size: 16,
                                      ),
                                      Text(
                                        currentHotel.hotelCity,
                                        style: TextStyle(),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 12, top: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${currentHotel.priceOfDay.toInt()}' +
                                            ' EGP',
                                        style: TextStyle(
                                          color: pink600Color.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 12, bottom: 14, right: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.favorite,
                                      color: redAccentColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_rate_rounded,
                                        size: 19,
                                        color: orangeColor,
                                      ),
                                      Text(
                                        '${currentHotel.hotelRate}',
                                        style: TextStyle(
                                            color: grey700Color,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HotelsDetailsScreen()));
                },
              ),
            );
          }),
    );
  }
}
