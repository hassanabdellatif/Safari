import 'package:cloud_firestore/cloud_firestore.dart';

class Tour{
  String placeName,tourOverview,tourCountry,tourCity,categoryName;
  double tourRate,tourPrice;
  List<String> tourPhotos;


  Tour({
      this.placeName,
      this.tourOverview,
      this.tourCountry,
      this.tourCity,
      this.categoryName,
      this.tourRate,
      this.tourPrice,
      this.tourPhotos});

  List<Tour> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Tour(
        placeName: doc.get('PlaceName') ?? '',
        tourCity: doc.get('TourCity') ?? '',
        tourCountry: doc.get('TourCountry') ?? '',
        tourRate: doc.get('TourRate') !=null ?doc.get(
            'TourRate') is double ? doc.get('TourRate') : doc.get(
            'TourRate') is String ? double.parse(
            doc.get('TourRate')):doc.get('TourRate').toDouble() : '',
        tourOverview: doc.get('TourOverview') ?? '',
        tourPrice: doc.get('TourPrice') !=null ?doc.get(
            'TourPrice') is double ? doc.get('TourPrice') : doc.get(
            'TourPrice') is String ? double.parse(
            doc.get('TourPrice')):doc.get('TourPrice').toDouble() : '',
        categoryName: doc.get('CategoryName') ?? '',
        tourPhotos: List.from(doc.get('TourPhotos')) ?? [],
      );
    }).toList();
  }


  Map<String, dynamic> toJson() {
    return {
      'TourCity': tourCity,
      'TourCountry': tourCountry,
      'PlaceName': placeName,
      'TourRate': tourRate,
      'TourOverview': tourOverview,
      'TourPrice': tourPrice,
      'CategoryName': categoryName,
      'TourPhotos': tourPhotos,
    };
  }
}