import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loca;
import 'package:location/location.dart';
import 'package:path/path.dart';
import 'package:real_estate/models/real_estate.dart';
import 'package:real_estate/widgets/loading.dart';
import 'package:real_estate/widgets/snackbar.dart';

class RealEstateController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController description, price, sqm;
  late LatLng mapLocation;
  late int number;
  int ch = 0;
  RxInt numBed = 0.obs;
  RxInt numBath = 0.obs;
  RxInt num_ket = 0.obs;
  RxInt num_bark = 0.obs;
  RxString purpose = "Sell".obs;
  RxString location = "Khartoum".obs;
  RxList _imageFileList = [].obs;
  RxList images_url = [].obs;

  // Firestore operation
   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;
  auth.User? user;
  RxList<RealEstate> realestates = RxList<RealEstate>([]);

  @override
  void onInit() {
    user = FirebaseAuth.instance.currentUser;
    super.onInit();
    getLoc();
    description = TextEditingController();
    price = TextEditingController();
    sqm = TextEditingController();
    getUserNumber(user!.uid);
     collectionReference = firebaseFirestore.collection("RealEstate");
    // realestates.bindStream(getAllRealEstate());
  }

  getlist() => _imageFileList;
  void clearList() {
    _imageFileList.clear();
    images_url.clear();
  }


  Future getUserNumber(String uid) async {
    var res = await FirebaseFirestore.instance
      .collection("users").where('uid',isEqualTo: uid).get();
    number = int.tryParse(res.docs.first['number'].toString())! ;
      }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "This field can be empty";
    }
    return null;
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return "This field can not be empty";
    }
    return null;
  }

  void updateList(String value, RxString type) {
    type.value = value;
  }

  void increment(RxInt type) {
    type.value++;
  }

  void decrement(RxInt type) {
    type.value--;
  }

  late LocationData _currentPosition;
  loca.Location geolocation = loca.Location();
  Future getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await geolocation.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await geolocation.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await geolocation.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await geolocation.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _currentPosition = await geolocation.getLocation();
    // var addresses = await placemarkFromCoordinates(
    //     _currentPosition.latitude!, _currentPosition.longitude!,
    //     localeIdentifier: "ar");

    // print(addresses);
    // adress = addresses;
    mapLocation =
        LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
    return _currentPosition;
  }

  final ImagePicker _picker = ImagePicker();
  void imageSelect() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage!.path.isNotEmpty) {
      _imageFileList.add(selectedImage);
    }
  }

  Future uploadImageToFirebase() async {
    for (var item in _imageFileList) {
      String fileName = basename(item.path);

      var _imageFile = File(item.path);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('realestate/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      await taskSnapshot.ref.getDownloadURL().then(
            (value) => images_url.add(value),
          );
    }
  }

  late Map<String, dynamic> re;
  void addRealEstate() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (_imageFileList.isEmpty) {
      showbar("Error", "Error", "Select at least one image", false);
    } else {
      auth.User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;
      String? name = user.displayName;
      String? url = user.photoURL;
      if (ch == 0) {
        re = <String, dynamic>{
          "uid": uid,
          "name": name,
          "userImage": url,
          "description": description.text,
          "images": images_url,
          "user_number": number,
          "location": location.string,
          "num_bark": int.tryParse(num_bark.string),
          "num_bath": int.tryParse(numBath.string),
          "num_bed": int.tryParse(numBed.string),
          "num_ket": int.tryParse(num_ket.string),
          "price": int.tryParse(price.text),
          "purpose": purpose.string,
          "sqm": int.tryParse(sqm.text),
          "status":2
        };
      } else {
        re = <String, dynamic>{
          "map_location":
              GeoPoint(mapLocation.latitude, mapLocation.longitude),
          "uid": uid,
          "name": name,
          "userImage": url,
          "description": description.text,
          "images": images_url,
          "user_number": number,
          "location": location.string,
          "num_bark": int.tryParse(num_bark.string),
          "num_bath": int.tryParse(numBath.string),
          "num_bed": int.tryParse(numBed.string),
          "num_ket": int.tryParse(num_ket.string),
          "price": int.tryParse(price.text),
          "purpose": purpose.string,
          "sqm": int.tryParse(sqm.text),
          "status":2
        };
      }


      showdilog();
      await uploadImageToFirebase();
      collectionReference.doc().set(re).whenComplete(() {
        images_url.clear();
        Get.back();
        showbar("Employee Added", "Employee Added",
            "Employee added successfully", true);
      }).catchError((error) {
        Get.back();
        showbar("Error", "Error", error.toString(), false);
      });
    }
  }
}
