import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:real_estate/Screens/map_result.dart';
import 'package:real_estate/controller/search_controller.dart';
import 'package:real_estate/models/map_style.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'dart:typed_data';

class FindRealEstate extends StatelessWidget {
  const FindRealEstate({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('RealEstats Maps'),
          backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
        ),
        body: GetBuilder<SearchController>(
            builder: (logic) {
              if (logic.loading.value == false) {
                return logic.contacts.isEmpty
                    ? const Center(
                  child: Text('No Locations Founded'),
                )
                    : Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: logic.initialCameraPosition,
                      markers: logic.markers,
                      myLocationButtonEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        controller.setMapStyle(MapStyle().aubergine);
                      },
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

}
