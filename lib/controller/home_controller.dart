import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:real_estate/models/real_estate.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class HomeController extends GetxController {
  RxList<RealEstate> realestates = RxList<RealEstate>([]);
  late CollectionReference collectionReference;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  auth.User? user;
  @override
  void onInit() {
    user = FirebaseAuth.instance.currentUser;
    collectionReference = firebaseFirestore.collection("RealEstate");
    realestates.bindStream(getAllRealEstate());
    super.onInit();
  }

  Stream<List<RealEstate>> getAllRealEstate() =>
      collectionReference.snapshots().map((query) => query.docs
          .where((element) => element['uid'] != user!.uid)
          .where((element) => element['status'] == 1)
          .map((item) => RealEstate.fromMap(item))
          .toList());
}
