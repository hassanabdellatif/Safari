import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/constants_colors.dart';
import 'package:project/locale_language/localization_delegate.dart';

class CarsDetailsScreen extends StatefulWidget {
  @override
  _CarsDetailsScreenState createState() => _CarsDetailsScreenState();
}

class _CarsDetailsScreenState extends State<CarsDetailsScreen>
    with SingleTickerProviderStateMixin {
  List<String> photos = [
    'assets/images/horus.jpg',
    'assets/images/haram.jpg',
    'assets/images/ramses.jpg',
    'assets/images/horus.jpg',
    'assets/images/haram.jpg',
    'assets/images/ramses.jpg',
    'assets/images/horus.jpg',
    'assets/images/haram.jpg',
    'assets/images/ramses.jpg',
  ];

  DateTime startOfStay;
  DateTime endOfStay;

  TabController _tabController;
  bool favoriteSelect = false;
  double currentSliderValue = 1;
  double numberOfPerson = 1;
  String roomType;
  double priceOfDay = 90;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    startOfStay = DateTime.now();
    endOfStay = DateTime.now();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        _background(context),
        Scaffold(
          backgroundColor: transparent,
          appBar: AppBar(
            title: Text(
              AppLocalization.of(context).getTranslated("details_title"),
              style: TextStyle(color: whiteColor),
            ),
            centerTitle: true,
            backgroundColor: transparent,
            elevation: 0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 30),
                child: Text(
                  "Horus",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Row(
                  children: [
                    Icon(
                      (Icons.star_rate_rounded),
                      color: whiteColor,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "4.5",
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: _bodyContent(context),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 168,
          right: 25,
          child: MaterialButton(
            height: 25,
            minWidth: 25,
            color: whiteColor,
            onPressed: () {
              setState(() {
                favoriteSelect = !favoriteSelect;
              });
            },
            child: favoriteSelect
                ? Icon(
              Icons.favorite,
              color: redAccentColor,
              size: 30,
            )
                : Icon(
              Icons.favorite_border_outlined,
              color: redAccentColor,
              size: 30,
            ),
            padding: EdgeInsets.all(14),
            shape: CircleBorder(),
          ),
        ),
      ],
    );
  }

  Widget _background(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.30,
      imageUrl:
      "https://images.pexels.com/photos/453201/pexels-photo-453201.jpeg?cs=srgb&dl=pexels-ahmed-abdelaziz-453201.jpg&fm=jpg",
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Widget _bodyContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 36, left: 36, top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: roomType,
                icon: Icon(FontAwesomeIcons.chevronDown),
                iconSize: 16,
                hint: Text(AppLocalization.of(context).getTranslated("text_car_type"),
                ),
                style: TextStyle(color: blackColor),
                onChanged: (String newValue) {
                  setState(() {
                    roomType = newValue;
                  });
                },
                items: <String>[
                  AppLocalization.of(context).getTranslated("text_car_1"),
                  AppLocalization.of(context).getTranslated("text_car_2"),
                  AppLocalization.of(context).getTranslated("text_car_3"),
                  AppLocalization.of(context).getTranslated("text_car_4"),
                ]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    color: deepPurpleColor,
                    size: 18,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "Giza",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalization.of(context).getTranslated("text_start_of_stay"),
                style: TextStyle(color: grey700Color),
              ),
              InkWell(
                child: Row(
                  children: [
                    Text(
                        "${startOfStay.day} - ${startOfStay.month} - ${startOfStay.year}"),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
                onTap: pickDateStart,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalization.of(context).getTranslated("text_end_of_stay"),
                style: TextStyle(color: grey700Color),
              ),
              InkWell(
                child: Row(
                  children: [
                    Text(
                        "${endOfStay.day} - ${endOfStay.month} - ${endOfStay.year}"),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
                onTap: pickDateEnd,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    AppLocalization.of(context).getTranslated("text_duration"),
                    style: TextStyle(color: grey700Color),
                  ),
                  Text(
                    Duration(startOfStay, endOfStay)
                        .durationCalculate()
                        .toString() +
                        AppLocalization.of(context).getTranslated("text_days"),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    AppLocalization.of(context)
                        .getTranslated("text_price_of_day"),                    style: TextStyle(color: grey700Color),
                  ),
                  Text(
                    PriceOfDay(priceOfDay, roomType)
                        .priceOfDayCalculate()
                        .toString() +
                        ' \$',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.12,
            child: TabBar(
              controller: _tabController,
              labelColor: primaryColor,
              indicatorColor: primaryColor,
              unselectedLabelColor: grey800Color,
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              indicatorPadding:
              EdgeInsets.symmetric(vertical: 8, horizontal: 40),
              tabs: [
                Text(AppLocalization.of(context).getTranslated("text_overview")),
                Text(AppLocalization.of(context).getTranslated("text_photos")),
                Text(AppLocalization.of(context).getTranslated("text_reviews")),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Text(
                    "Horus House Hotel’s rooms each have satellite TV and a work desk. A mini bar is also provided, and guests can order in room breakfast and room service"
                        "Horus House Hotel’s rooms each have satellite TV and a work desk. A mini bar is also provided, and guests can order in room breakfast and room service"
                        "Horus House Hotel’s rooms each have satellite TV and a work desk. A mini bar is also provided, and guests can order in room breakfast and room service",
                    style: TextStyle(color: grey700Color, fontSize: 16),
                  ),
                ),
                GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(photos.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        color: redColor,
                        width: 60,
                        height: 60,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                          "https://images.pexels.com/photos/453201/pexels-photo-453201.jpeg?cs=srgb&dl=pexels-ahmed-abdelaziz-453201.jpg&fm=jpg",
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    );
                  }),
                ),
                Text("Reviews"),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    TotalPrice(
                        currentSliderValue,
                        PriceOfDay(priceOfDay, roomType)
                            .priceOfDayCalculate())
                        .totalPriceCalculate()
                        .toString()+ AppLocalization.of(context).getTranslated("text_le"),
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: pink600Color),
                  ),

                  Text(
                    AppLocalization.of(context)
                        .getTranslated("text_total_price"),                    style: TextStyle(
                      color: grey800Color,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
                width: 170,
                child: RaisedButton(
                  color: primaryColor,
                  colorBrightness: Brightness.dark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    AppLocalization.of(context).getTranslated("button_book"),
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 18,
                      letterSpacing: 1.1,
                    ),
                  ),
                  onPressed: () {

                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Future<DateTime> pickDateStart() async {
    final DateTime dateStart = await showDatePicker(
      context: context,
      initialDate: startOfStay,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (dateStart != null) {
      setState(() {
        startOfStay = dateStart;
      });
    }
  }

  Future<DateTime> pickDateEnd() async {
    DateTime dateEnd = await showDatePicker(
      context: context,
      initialDate: endOfStay,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (dateEnd != null) {
      setState(() {
        endOfStay = dateEnd;
      });
    }
  }
}

class Duration {
  DateTime startOfStay;
  DateTime endOfStay;

  Duration(this.startOfStay, this.endOfStay);

  durationCalculate() {
    int duration = endOfStay.difference(startOfStay).inDays + 1;
    return duration;
  }
}

class PriceOfDay {
  String roomType;
  double priceOfDay;

  PriceOfDay(this.priceOfDay, this.roomType);

  priceOfDayCalculate() {
    switch (roomType) {
      case 'Single':
        priceOfDay = priceOfDay;
        break;
      case 'Double':
        priceOfDay = priceOfDay + priceOfDay * 5 / 100;
        break;
      case 'Triple':
        priceOfDay = priceOfDay + priceOfDay * 10 / 100;
        break;
      case 'Quad':
        priceOfDay = priceOfDay + priceOfDay * 15 / 100;
        break;
      default:
        priceOfDay = 0.0;
        break;
    }
    return priceOfDay;
  }
}

class NumberOfPerson {
  double numberOfPerson;
  String roomType;

  NumberOfPerson(this.roomType, this.numberOfPerson);

  numberOfPersonMax() {
    switch (roomType) {
      case 'Single':
        numberOfPerson = 1;
        break;
      case 'Double':
        numberOfPerson = 2;
        break;
      case 'Triple':
        numberOfPerson = 5;
        break;
      case 'Quad':
        numberOfPerson = 5;
        break;
      default:
        numberOfPerson = 1;
        break;
    }
    return numberOfPerson;
  }
}

class TotalPrice {
  double currentSliderValue;
  double priceOfDay;

  TotalPrice(this.priceOfDay, this.currentSliderValue);

  totalPriceCalculate() {
    double total = currentSliderValue * priceOfDay.ceilToDouble();
    return total;
  }
}