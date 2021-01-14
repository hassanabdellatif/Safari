import 'package:cloud_firestore/cloud_firestore.dart';

class Cars {
  String id, carName, carOverview, carCountry, carCity, categoryName, carType;
  double carRate, priceOfDay;
  List<String> carPhotos;

  Cars(
      {this.id,
      this.carName,
      this.carOverview,
      this.carCountry,
      this.carCity,
      this.categoryName,
      this.carType,
      this.carRate,
      this.priceOfDay,
      this.carPhotos});

  List<Cars> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Cars(
        carName: doc.get('CarName') ?? '',
        carCity: doc.get('CarCity') ?? '',
        carCountry: doc.get('CarCountry') ?? '',
        carRate: doc.get('CarRate') != null
            ? doc.get('CarRate') is double
                ? doc.get('CarRate')
                : doc.get('CarRate') is String
                    ? double.parse(doc.get('CarRate'))
                    : doc.get('CarRate').toDouble()
            : '',
        carOverview: doc.get('CarOverview') ?? '',
        priceOfDay: doc.get('PriceOfDay') != null
            ? doc.get('PriceOfDay') is double
                ? doc.get('PriceOfDay')
                : doc.get('PriceOfDay') is String
                    ? double.parse(doc.get('PriceOfDay'))
                    : doc.get('PriceOfDay').toDouble() : '',

        categoryName: doc.get('CategoryName') ?? '',
        carPhotos: List.from(doc.get('CarPhotos')) ?? [],
        carType: doc.get('CarType') ?? '',
      );
    }).toList();
  }



  Map<String, dynamic> toJson() {
    return {
      'CarCity': carCity,
      'CarCountry': carCountry,
      'CarName': carName,
      'CarRate': carRate,
      'CarOverview': carOverview,
      'PriceOfDay': priceOfDay,
      'CategoryName': categoryName,
      'CarPhotos': carPhotos,
      'CarType': carType,
    };
  }
}
