import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends GetxController{
  late CameraPosition _initialCameraPosition;
  Set<Marker> _markers = {};
  List<dynamic> _contacts = [];
  late LocationData _currentPosition;
}