import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/Controllers/authentication/provider_auth.dart';
import 'package:project/constants_colors.dart';
import 'package:project/locale_language/localization_delegate.dart';
import 'package:project/models/Provider_Offset.dart';
import 'package:project/view/drawer_screens/settings_screen.dart';
import 'favorite/favorites_screen.dart';
import 'package:project/view/login_screen.dart';
import 'package:project/view/drawer_screens/contactus_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification/notifications_screen.dart';
import 'profile_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  CollectionReference travelerCollection = FirebaseFirestore.instance.collection('Travelers');

  @override
  Widget build(BuildContext context) {
     var providerType = Provider.of<ProviderOffset>(context,listen: false);

    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: AppLocalization.of(context).locale.languageCode=='ar'?EdgeInsets.only(top: 50, bottom: 45, right: 15):EdgeInsets.only(top: 50, bottom: 45,left: 15 ),
        color: primaryColor,
        child: FutureBuilder<DocumentSnapshot>(
          future: travelerCollection.doc(FirebaseAuth.instance.currentUser.uid).get(),
          builder: (context,AsyncSnapshot<DocumentSnapshot>snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
                break;

              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;

              case ConnectionState.none:
                return Text("No Connection");
                break;

              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(snapshot.error);
                } else if (snapshot.hasData){
                  Map<String,dynamic>  data = snapshot.data.data();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: whiteColor,
                            child: Container(
                              height: 46,
                              width: 46,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: transparent,
                                image: DecorationImage(
                                  image: NetworkImage(data["image"]==null?"https://www.flaticon.com/svg/vstatic/svg/929/929422.svg?token=exp=1610581352~hmac=3289dc6e4527b339241852ba4be792f9":data["image"]),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: AppLocalization.of(context).locale.languageCode=='ar'? const EdgeInsets.only(right: 15) :  const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data["fullName"]==null?"Profile Name":data["fullName"],
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  data["username"]==null?"UserName":data["username"],
                                  style: TextStyle(color: grey400Color, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                providerType.drawerClose();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.home,
                                    color: whiteColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    AppLocalization.of(context).getTranslated("text_home"),
                                    style: TextStyle(
                                        color: whiteColor, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return FavoritesScreen();
                                    }));
                                providerType.drawerClose();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: whiteColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    AppLocalization.of(context).getTranslated("text_favorites"),
                                    style: TextStyle(
                                        color: whiteColor, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return NotificationScreen();
                                    }));
                                providerType.drawerClose();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    color: whiteColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    AppLocalization.of(context).getTranslated("text_notification"),
                                    style: TextStyle(
                                        color: whiteColor, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return ProfileScreen();
                                    }));
                                providerType.drawerClose();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidUserCircle,
                                    color: whiteColor,
                                    size: 22,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    AppLocalization.of(context).getTranslated("text_profile"),
                                    style: TextStyle(
                                        color: whiteColor, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return ContactUsScreen();
                                    }));
                                providerType.drawerClose();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.help,
                                    color: whiteColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      AppLocalization.of(context).getTranslated("text_contact_us"),
                                    style: TextStyle(
                                        color: whiteColor, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return SettingScreen();
                                  }));
                              providerType.drawerClose();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: whiteColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  AppLocalization.of(context).getTranslated("text_settings"),
                                  style: TextStyle(
                                      color: whiteColor, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 2,
                            height: 20,
                            color: whiteColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),

                          InkWell(
                            onTap: () async {

                              _logout(context,providerType);
                            },
                            child: Text(
                              AppLocalization.of(context).getTranslated("text_logout"),
                              style: TextStyle(
                                  color: whiteColor, fontWeight: FontWeight.bold),
                            ),
                          ),

                        ],
                      ),
                    ],
                  );

                }
                break;
            }
            return null;
          },
        ),
    );
  }

  void _logout(BuildContext context, ProviderOffset offset) async{
    var authProvider = Provider.of<AuthProvider>(context,listen: false);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("KeepMeLoggedIn");
    await authProvider.logout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    offset.drawerClose();
  }
}
