import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:real_estate/models/real_estate.dart';

class ProfileController extends GetxController{
  RxInt selectedCategoryIndex = 0.obs;
  List categoryList = ['Reject', 'Active', 'Waiting'];
  int active = 1;
  int waiting = 2;
  int reject = 0;
  RxList<RealEstate> realEstates = RxList<RealEstate>([]);
  late CollectionReference collectionReference;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  auth.User? user;
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
  @override
  void onInit() {
    user = FirebaseAuth.instance.currentUser;
    collectionReference = firebaseFirestore.collection("RealEstate");
    getAllRealEstate();
    super.onInit();
  }

   getAllRealEstate() async {
    loading.value = true;
    realEstates.clear();
     var res = await FirebaseFirestore.instance
         .collection('RealEstate').where('uid',isEqualTo:user!.uid)
         .where('status',isEqualTo: selectedCategoryIndex.value)
         .get();
     for (var element in res.docs) {
         realEstates.add(RealEstate.fromMap(element));
         }
    loading.value = false;
     update();
   }
}