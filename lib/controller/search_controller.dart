import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:real_estate/Screens/map_result.dart';
import 'package:real_estate/Screens/search_result.dart';

class SearchController extends GetxController{
  final GlobalKey<FormState>  formKey = GlobalKey<FormState>();

 late TextEditingController min ;
 late TextEditingController max ;
  List<dynamic> data = [];
  List<String> category = ["Khartoum", "Omdurman", "Bahri"];
  String currentCategorySelected = "Khartoum";
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
@override
  void onInit() {
  min =  TextEditingController();
  max =  TextEditingController();
  getLoc();
    super.onInit();
  }

  String? validate(String value) {
    if (value.isEmpty) {
      return "This field can be empty";
    }
    return null;
  }
  search()async{
    if(formKey.currentState!.validate()){
     await getData(currentCategorySelected, int.parse(min.text.toString()), int.parse(max.text.toString()));
      Get.to(()=> const SearchResult());
    } else{
      return;
      }
  }
   clear(){
  data.clear();
  }
  Future getData(String location,int minSalary,int maxSalary ) async {
    data.clear();
    _loading.value = true;
    var res = await FirebaseFirestore.instance.collection('RealEstate').get();

    for (var element in res.docs) {

      if (element['location'] == location &&
          element['price'] >= minSalary &&
          element['price'] <= maxSalary &&
          element['status'] == 1) {
        data.add(element);
      }
      _loading.value = false;
      update();
    }
    // return data;
  }
  late CameraPosition initialCameraPosition;
   Set<Marker> markers = {};
  List<dynamic> contacts = [];

  late LocationData _currentPosition;

  Location geolocation = Location();
  Future getLoc() async {
    _loading.value = true;
    _currentPosition = await geolocation.getLocation();
    initialCameraPosition = CameraPosition(
      target: LatLng(_currentPosition.longitude!, _currentPosition.latitude!),
      zoom: 14.4746,
    );
    var res = await FirebaseFirestore.instance
        .collection('RealEstate')
        .orderBy('map_location')
        .get();
    contacts = [];
    for (var element in res.docs) {
      GeoPoint geoPoint = element['map_location'];
      double lat = geoPoint.latitude;
      double lng = geoPoint.longitude;
      LatLng latLng =  LatLng(lng, lat);
      var _id = element.id;
      contacts.add({"location": latLng, "id": _id});
    }
    createMarkers();
    _loading.value = false;
  }
  createMarkers() {
    Marker marker;
    for (var contact in contacts){
      marker = Marker(
        markerId: MarkerId(contact['id']),
        position: contact['location'],
        infoWindow: InfoWindow(
            title: 'RealEstate',
            snippet: 'Tap top Open',
            onTap: () async{
             await getMapResult(contact['id']);
              Get.to(() => const MapResult());
            }),
      );

      markers.add(marker);
    }
  }
  List<dynamic> mapResult = [];
  Future getMapResult(String id) async {
    mapResult.clear();
    _loading.value = true;
    var res = await FirebaseFirestore.instance.collection('RealEstate').get();
    for (var element in res.docs) {

      if (element.id == id) {
        mapResult.add(element);
      }
    }
    _loading.value = false;

    return mapResult;

  }
}