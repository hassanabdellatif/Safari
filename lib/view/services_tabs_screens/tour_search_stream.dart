import 'package:flutter/material.dart';
import 'package:project/Controllers/firestore/DataBase.dart';
import 'package:project/constants_colors.dart';
import 'package:project/models/tour.dart';
import 'package:project/view/details_screens/tour_details.dart';
import 'package:project/view/services_tabs_screens/tour_service.dart';
import 'package:provider/provider.dart';

class TourSearchStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Tour>>.value(
      value: DataBase().getAllTours,
      catchError: (_, err) => throw Exception(err),
      child: ToursService(),
    );
  }
}

class TourSearch extends StatelessWidget {

  final tourList;

  TourSearch({@required this.tourList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount:
              tourList != null && tourList.length > 0 ? tourList.length : 0,
          itemBuilder: (context, index) {
            final Tour currentTour = tourList[index];

            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ToursDetailsScreen()));
                },
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
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(currentTour.tourPhotos[0]),
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
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 12, top: 12),
                                  child: Text(
                                    currentTour.placeName,
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500),
                                  ),
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
                                        currentTour.tourCity,
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
                                        '${currentTour.tourPrice.toInt()}' +
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
                                        '${currentTour.tourRate}',
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
              ),
            );
          }),
    );
  }
}
