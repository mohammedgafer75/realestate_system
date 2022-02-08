import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as loca;
import 'package:path/path.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate/controller/real_estate_controller.dart';
import 'package:real_estate/models/real_estate.dart';
import 'package:real_estate/services/http.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:real_estate/widgets/loading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class New_RealEstate extends StatelessWidget {
  List<String> _category = ["Khartoum", "Omdrman", "Bahri"];
  // var _currentcategorySelected = "Khartoum";
  List<String> _for = ["Rent", "Sell"];
  // var _currentFor = "Sell";
  // RealEstateController controller = Get.put(RealEstateController());
  @override
  Widget build(BuildContext context) {
    print('object');
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('New'),
        backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
      ),
      backgroundColor: Colors.white,
      body: GetX<RealEstateController>(
          autoRemove: false,
          init: RealEstateController(),
          builder: (controller) {
            return Form(
              key: controller.formKey,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  TextFormField(
                    controller: controller.sqm,
                    decoration: const InputDecoration(
                      labelText: 'Space',
                      hintStyle: TextStyle(color: Colors.black),
                      // hintText: '1700 sqm',
                    ),
                    style: const TextStyle(fontSize: 14),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return controller.validateName(value!);
                    },
                  ),
                  TextFormField(
                    controller: controller.description,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintStyle: TextStyle(color: Colors.black),
                      // hintText: 'Description',
                      hintMaxLines: 120,
                    ),
                    maxLines: null,
                    validator: (value) {
                      return controller.validateName(value!);
                    },
                  ),
                  TextFormField(
                    controller: controller.price,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      hintStyle: TextStyle(color: Colors.black),
                      // hintText: '3000 SDG',
                    ),
                    style: const TextStyle(fontSize: 14),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return controller.validateName(value!);
                    },
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Number of Bedroom: ',
                          style: TextStyle(color: Colors.black)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            controller.decrement(controller.numBed);
                          },
                          icon: const Icon(Icons.remove)),
                      Center(
                          child: Text(
                        "${controller.numBed.value}",
                      )),
                      IconButton(
                          onPressed: () {
                            controller.increment(controller.numBed);
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Number of Pathroom: ',
                          style: TextStyle(color: Colors.black)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            controller.decrement(controller.numBath);
                          },
                          icon: const Icon(Icons.remove)),
                      Center(
                          child: Text(
                        "${controller.numBath.value}",
                      )),
                      IconButton(
                          onPressed: () {
                            controller.increment(controller.numBath);
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Number of kitchen: ',
                          style: TextStyle(color: Colors.black)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            controller.decrement(controller.num_ket);
                          },
                          icon: const Icon(Icons.remove)),
                      Center(
                          child: Text(
                        "${controller.num_ket.value}",
                      )),
                      IconButton(
                          onPressed: () {
                            controller.increment(controller.num_ket);
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Number of Parking: ',
                          style: TextStyle(color: Colors.black)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            controller.decrement(controller.num_bark);
                          },
                          icon: const Icon(Icons.remove)),
                      Center(
                          child: Text(
                        "${controller.num_bark.value}",
                      )),
                      IconButton(
                          onPressed: () {
                            controller.increment(controller.num_bark);
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Text(
                        "Location List:",
                        style: TextStyle(color: Colors.black),
                      )),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButton<String>(
                            icon: const Icon(Icons.location_on_outlined,
                                color: Colors.black),
                            iconEnabledColor: Colors.white,
                            items: _category.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (String? newValueSelected) {
                              controller.updateList(
                                  newValueSelected!, controller.location);
                            },
                            value: controller.location.string,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Text(
                        "For:",
                        style: TextStyle(color: Colors.black),
                      )),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: DropdownButton<String>(
                            iconEnabledColor: Colors.white,
                            items: _for.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (String? newValueSelected) {
                              controller.updateList(
                                  newValueSelected!, controller.purpose);
                            },
                            value: controller.purpose.string,
                          ),
                        ),
                      ),
                    ],
                  ),
                  controller.getlist()!.isEmpty
                      ? Container()
                      : controller.getlist()!.length == 1
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(29),
                              ),
                              padding: const EdgeInsets.all(15),
                              child: Center(
                                  child: Image.file(
                                      File(controller.getlist()![0].path),
                                      fit: BoxFit.cover,
                                      width: 800)),
                            )
                          : CarouselSlider(
                              options: CarouselOptions(
                                //aspectRatio: 2.0,
                                enlargeCenterPage: true,
                              ),
                              items: controller
                                  .getlist()!
                                  .map<Widget>((item) => Center(
                                      child: Image.file(File(item.path),
                                          fit: BoxFit.cover, width: 1000)))
                                  .toList(),
                            ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Center(
                    child: TextButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 15, right: 15)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(19, 26, 44, 1.0)),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        side: const BorderSide(
                                            color: Color.fromRGBO(
                                                19, 26, 44, 1.0))))),
                        onPressed: () {
                          controller.imageSelect();
                        },
                        child: const Text('add image',
                            style: TextStyle(color: Colors.white))),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(10)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        side: const BorderSide(
                                            color: Colors.red)))),
                            onPressed: () {
                              controller.clearList();
                            },
                            child: const Text('Reset',
                                style: TextStyle(color: Colors.white))),
                        Center(
                          child: TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 15,
                                      right: 15)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromRGBO(19, 26, 44, 1.0)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          side: const BorderSide(
                                              color: Color.fromRGBO(
                                                  19, 26, 44, 1.0))))),
                              onPressed: () {
                                Get.dialog(AlertDialog(
                                  title: const Text('Add Location'),
                                  content: const Text(
                                      'Save your current location !!!'),
                                  actions: [
                                    DialogButton(
                                        child: const Text('Save'),
                                        onPressed: () async {
                                          showdilog();

                                          await controller.getLoc();
                                          controller.ch = 1;
                                          Get.back();
                                          Get.back();
                                        }),
                                    DialogButton(
                                        child: const Text('close'),
                                        onPressed: () {
                                          Get.back();
                                        }),
                                  ],
                                ));

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => GoogleMapScreen()));
                              },
                              child: const Text('Add Realestate geolocation ',
                                  style: TextStyle(color: Colors.white))),
                        ),
                        TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(10)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(19, 26, 44, 1.0)),
                                shape:
                                    MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            side: const BorderSide(
                                                color: Color.fromRGBO(
                                                    19, 26, 44, 1.0))))),
                            onPressed: () async {
                              controller.addRealEstate();
                            },
                            child: const Text('Save',
                                style: TextStyle(color: Colors.white))),
                      ]),
                ],
              ),
            );
          }),
    );
  }
}

// final ImagePicker _picker = ImagePicker();
// List<XFile>? _imageFileList = [];
// late File _imageFile;
// List images_url = [];
// final _formKey = GlobalKey<FormState>();
// void imageSelect() async {
//   final XFile? selectedImage =
//       await _picker.pickImage(source: ImageSource.gallery);
//   if (selectedImage!.path.isNotEmpty) {
//     _imageFileList!.add(selectedImage);
//   }
// }

//   // Future uploadFiles() async {
//   //   List<File> images = [];
//   //   _imageFileList!.map((e) => images.add(File(e.path)));
//   //   print(_imageFileList!.length);
//   //   var imageUrls = await Future.wait(
//   //      images.map((_image) => uploadImageToFirebase(_image)));
//   //  return images_url = imageUrls;
// //  }

// Future uploadImageToFirebase() async {
//   for (var item in _imageFileList!) {
//     String fileName = basename(item.path);

//     _imageFile = File(item.path);

//     Reference firebaseStorageRef =
//         FirebaseStorage.instance.ref().child('realestate/$fileName');
//     UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
//     TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

//     await taskSnapshot.ref.getDownloadURL().then(
//           (value) => images_url.add(value),
//         );
//   }
// }

  // late LocationData _currentPosition;
  // loca.Location geolocation = loca.Location();
  // Future getLoc() async {
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;

  //   _serviceEnabled = await geolocation.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await geolocation.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }

  //   _permissionGranted = await geolocation.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await geolocation.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //   _currentPosition = await geolocation.getLocation();
  //   // var addresses = await placemarkFromCoordinates(
  //   //     _currentPosition.latitude!, _currentPosition.longitude!,
  //   //     localeIdentifier: "ar");

  //   // print(addresses);
  //   // adress = addresses;
  //   map_location =
  //       LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
  //   return _currentPosition;
  // }

//   int loc = 0;
//   Future add(BuildContext context) async {
//     auth.User? user = FirebaseAuth.instance.currentUser;
//     String name = user!.displayName!;
//     String url = user.photoURL!;
//     if (loc == 0) {
//       dynamic res = await addItem(
//         uid: user.uid,
//         description: description.text.trim(),
//         purpose: purpose,
//         location: location,
//         price: int.tryParse(price.text.trim()),
//         sqm: int.tryParse(sqm.text.trim()),
//         num_bed: num_bed,
//         num_bath: num_bath,
//         num_ket: num_ket,
//         num_bark: num_bark,
//         name: name,
//         url: url,
//         image: images_url,
//       );
//       if (res.ch == 1) {
//         setState(() {
//           description.clear();
//           price.clear();
//           sqm.clear();
//           _imageFileList = [];
//           images_url = [];
//           Navigator.of(context).pop();
//           showBar(context, "RealEtate Added!!", 1);
//         });
//       } else {
//         setState(() {
//           Navigator.of(context).pop();
//           showBar(context, res.data, 0);
//         });
//       }
//     } else {
//       GeoPoint lo = GeoPoint(map_location.latitude, map_location.longitude);
//       dynamic res = await addItemWithLocation(
//         uid: user.uid,
//         description: description.text.trim(),
//         purpose: purpose,
//         location: location,
//         price: int.tryParse(price.text.trim()),
//         sqm: int.tryParse(sqm.text.trim()),
//         num_bed: num_bed,
//         num_bath: num_bath,
//         num_ket: num_ket,
//         num_bark: num_bark,
//         name: name,
//         url: url,
//         image: images_url,
//         map_location: lo,
//       );
//       if (res.ch == 1) {
//         setState(() {
//           description.clear();
//           price.clear();
//           sqm.clear();
//           _imageFileList = [];
//           images_url = [];
//           Navigator.of(context).pop();
//           showBar(context, "RealEtate Added!!", 1);
//         });
//       } else {
//         setState(() {
//           Navigator.of(context).pop();
//           showBar(context, res.data, 0);
//         });
//       }
//     }
//   }
// }
