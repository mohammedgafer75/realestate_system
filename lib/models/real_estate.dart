import 'package:cloud_firestore/cloud_firestore.dart';

class RealEstate {
  String? docId;
  String? uid;
  String? name;
  String? userImage;
  String? description;
  String? purpose;
  String? location;
  int? user_number;
  int? price;
  int? sqm;
  int? num_bed;
  int? num_bath;
  int? num_ket;
  int? num_bark;
  List? images;
  GeoPoint? map_location;
  int? status;

  RealEstate({
    this.docId,
    required this.uid,
    required this.name,
    required this.userImage,
    required this.description,
    required this.images,
    required this.location,
    required this.user_number,
    this.map_location,
    this.status,
    required this.num_bark,
    required this.num_bath,
    required this.num_bed,
    required this.num_ket,
    required this.price,
    required this.purpose,
    required this.sqm,
  });

  RealEstate.fromMap(DocumentSnapshot data) {
    docId = data.id;
    uid = data["uid"];
    name = data["name"];
    userImage = data["userImage"];
    description = data["description"];
    images = data["images"];
    location = data["location"];
    user_number = data["user_number"];
    // map_location = data["map_location"];
    num_bark = data["num_bark"];
    num_bath = data["num_bath"];
    num_bed = data["num_bed"];
    num_ket = data["num_ket"];
    price = data["price"];
    purpose = data["purpose"];
    sqm = data["sqm"];
    status = data["status"];
  }
}
