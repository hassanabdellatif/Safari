import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project/Controllers/firestore/DataBase.dart';
import 'package:project/constants_colors.dart';
import 'package:project/models/tour.dart';
import 'package:provider/provider.dart';

import '../locale_language/localization_delegate.dart';

class TourStream extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Tour>>.value(
      value: DataBase().getTours,
      catchError: (_, err) => throw Exception(err),
      child: TourWidget(),
    );
  }
}

class TourWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final tourList = Provider.of<List<Tour>>(context);

    return Container(
      height: MediaQuery.of(context).size.height*0.85,
      child: StaggeredGridView.countBuilder(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          itemCount:
          tourList != null && tourList.length > 0 ? tourList.length : 0,
          itemBuilder: (context, index) {
            final Tour currentTour = tourList[index];
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(currentTour.tourPhotos[1]),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10),),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10),),
                      color: blackColor.withOpacity(0.4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: AppLocalization.of(context).locale.languageCode ==
                              'ar'
                              ? const EdgeInsets.only(right: 8, top: 4)
                              : const EdgeInsets.only(left: 8, top: 4),
                          child: Text(currentTour.placeName,style: TextStyle(color: whiteColor,fontSize: 13),),
                        ),
                        Padding(
                          padding: AppLocalization.of(context).locale.languageCode ==
                              'ar'
                              ? const EdgeInsets.only(right: 5, top: 2)
                              : const EdgeInsets.only(left: 5, top: 2),
                          child: Row(
                            children: [
                              Icon(Icons.location_on_sharp,color:redAccentColor,size: 16,),
                              Text(currentTour.tourCity,style: TextStyle(color: whiteColor,fontSize: 11),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          staggeredTileBuilder: (index){
            return  StaggeredTile.count(1, index.isEven ? 1.8 : 1.2);
          }
      ),
    );

  }
}


