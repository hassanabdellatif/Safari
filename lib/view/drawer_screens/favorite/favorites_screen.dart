import 'package:flutter/material.dart';
import 'package:project/constants_colors.dart';
import 'package:project/view/drawer_screens/profile_screen.dart';

import '../../../locale_language/localization_delegate.dart';
import 'favorite_cars.dart';
import 'favorite_hotels.dart';
import 'favorite_tours.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorites',
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
              padding: AppLocalization.of(context).locale.languageCode=='ar'? const EdgeInsets.only(left: 10, top: 6) : const EdgeInsets.only(right: 10, top: 6),
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
                FavoritesHotels(),
                FavoritesTours(),
                FavoritesCars(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}