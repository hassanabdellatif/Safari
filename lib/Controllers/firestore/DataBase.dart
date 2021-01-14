import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/car.dart';
import 'package:project/models/hotel.dart';
import 'package:project/models/tour.dart';
import 'package:project/models/users.dart';

class DataBase {
 final CollectionReference hotelCollection= FirebaseFirestore.instance.collection("Hotels");
 final CollectionReference carCollection= FirebaseFirestore.instance.collection("Cars");
 final CollectionReference tourCollection= FirebaseFirestore.instance.collection("Tours");
 final CollectionReference travelerCollection= FirebaseFirestore.instance.collection("Travelers");

  Future<void> addTraveler(Travelers travelers) async {

     return await travelerCollection.doc(travelers.id).set(travelers.toJson());
  }


  // stream for hotels
  Stream<List<Hotel>> get getAllHotels {
    return hotelCollection.snapshots().map(Hotel().fromQuery);
  }

  // stream for hotels
  Stream<List<Hotel>> get getHotels {
  return hotelCollection.limit(4).snapshots().map(Hotel().fromQuery);
  }

  // Future<void> addNewHotel(Hotel hotel)async{
  //   await hotelCollection.doc().set(hotel.toJson());
  // }


  // stream for cars
  Stream<List<Cars>> get getAllCars {
    return carCollection.snapshots().map(Cars().fromQuery);
  }

  // stream for cars
  Stream<List<Cars>> get getCars {
    return carCollection.limit(4).snapshots().map(Cars().fromQuery);
  }

  // Future<void> addNewCar(Cars car)async{
  //   await carCollection.doc().set(car.toJson());
  // }


  // stream for tours
  Stream<List<Tour>> get getAllTours {
    return tourCollection.snapshots().map(Tour().fromQuery);
  }

  // stream for tours
  Stream<List<Tour>> get getTours {
    return tourCollection.limit(4).snapshots().map(Tour().fromQuery);
  }

  // Future<void> addNewTour(Tour tour)async{
  //   await tourCollection.doc().set(tour.toJson());
  // }

}
