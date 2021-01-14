import 'package:flutter/material.dart';
import 'package:project/constants_colors.dart';
import 'package:project/view/services_tabs_screens/car_search_stream.dart';
import 'package:project/view/services_tabs_screens/tour_search_stream.dart';
import '../drawer_screens/profile_screen.dart';
import 'hotel_search_stream.dart';

class ServicesScreen extends StatefulWidget {

  int selectedIndex=0;
  ServicesScreen({this.selectedIndex});

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: widget.selectedIndex, length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Services',
            style: TextStyle(
                color: blackColor, fontSize: 24, fontWeight: FontWeight.w600),
          ),
          backgroundColor: grey50Color,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: primaryColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfileScreen();
                }));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10, top: 6,left: 10),
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: primaryColor,
                  child: CircleAvatar(
                    backgroundColor: whiteColor,
                    radius: 23,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/pro.jpg'),
                      radius: 21.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.10,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                indicatorPadding:
                EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                controller: _tabController,
                labelColor: primaryColor,
                indicatorColor: primaryColor,
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelColor: grey600Color,
                tabs: [
                  Text("Hotels"),
                  Text("Tours"),
                  Text("Cars"),
                ],
              ),
            ),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  HotelSearchStream(),
                  TourSearchStream(),
                  CarSearchStream(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}