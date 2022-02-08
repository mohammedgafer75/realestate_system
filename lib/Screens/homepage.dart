import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/Screens/myprofil.dart';
import 'package:real_estate/Screens/search.dart';
import 'package:real_estate/Screens/settings_page.dart';
import 'package:real_estate/Screens/details.dart';
import 'package:real_estate/Screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:real_estate/controller/auth_controller.dart';
import 'package:real_estate/controller/home_controller.dart';
import 'package:real_estate/widgets/property.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => const SearchPage());
                    },
                    icon: const Icon(Icons.search, color: Colors.white),
                  )),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    onPressed: () {
                      controller.signout();
                    },
                    icon: const Icon(Icons.logout, color: Colors.white),
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: data.padding.left * 2,
              right: data.padding.right * 2,
              top: data.padding.top * 2,
            ),
            child: const Text('Find Your Dream Home',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: data.padding.left * .5,
              right: data.padding.right * 2,
              top: data.padding.top * .5,
              bottom: data.padding.top * .5,
            ),
          ),
          Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: Colors.white,
                  ),
                  // color: Color.fromRGBO(19, 26, 44, 1.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GetX<HomeController>(
                      autoRemove: false,
                      init: HomeController(),
                      builder: (controller) {
                        if (controller.realestates.isEmpty) {
                          return const Center(
                              child: Text('No RealEstate Founded'));
                        } else {
                          return ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return Hero(
                                  tag: Image.network(
                                    controller.realestates[index].images![0],
                                    fit: BoxFit.fill,
                                  ),
                                  child: Property(
                                      property: controller.realestates[index]));
                            },
                            itemCount: controller.realestates.length,
                          );
                        }
                      }))),
        ],
      ),
    );
  }
}
