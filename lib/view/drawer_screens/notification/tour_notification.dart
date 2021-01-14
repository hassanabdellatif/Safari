import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/constants_colors.dart';

class ToursNotifications extends StatefulWidget {
  @override
  _ToursNotificationsState createState() => _ToursNotificationsState();
}

class _ToursNotificationsState extends State<ToursNotifications> {

  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 10,
                bottom: 5,
              ),
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(15),
                ),
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
                            image: NetworkImage(
                                'https://images.pexels.com/photos/189296/pexels-photo-189296.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
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
                                    'Horus Hotel',
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
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5,right: 3,left: 3),
                                        child: Icon(FontAwesomeIcons.calendarAlt,size: 16,color: primaryColor,),
                                      ),
                                      Text(
                                        '16/8/2020',
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
                                      Row(
                                        children: [
                                          Text(
                                            '1000' + ' L.E',
                                            style: TextStyle(
                                              color: pink600Color.withOpacity(0.8),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 12,bottom: 10 ),
                                child: SizedBox(
                                  height: 30,
                                  width: 80,
                                  child: RaisedButton(
                                    onPressed: (){

                                    },
                                    child: Text('Cancel',style: TextStyle(color: whiteColor),),
                                    color: red900Color,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    // minWidth: 70,
                                    // height: 30,
                                    elevation: 8,
                                    splashColor: whiteColor,
                                  ),
                                ),
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
          });
  }
}