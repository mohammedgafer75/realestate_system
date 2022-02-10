import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:real_estate/Screens/details.dart';
import 'package:real_estate/controller/drawer_controller.dart';
import 'package:real_estate/controller/profile_controller.dart';
import 'package:real_estate/widgets/drawer.dart';

import 'homepage.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return GetBuilder<DrawerControllers>(
        init: DrawerControllers(),
        builder: (darw) {
          return AdvancedDrawer(
              drawer: const Drawer_w(),
              backdropColor: const Color.fromRGBO(19, 26, 44, 1.0),
              controller: darw.advancedDrawerController,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 300),
              animateChildDecoration: true,
              rtlOpening: false,
              disabledGestures: false,
              childDecoration: const BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: Scaffold(
                backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
                body: GetBuilder<ProfileController>(
                  autoRemove: false,
                  init: ProfileController(),
                  builder: (logic) {
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
                                        border: Border.all(
                                            color:
                                                Colors.white.withOpacity(0.4)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: IconButton(
                                      onPressed: () {
                                        darw.handleMenuButtonPressed();
                                      },
                                      icon: ValueListenableBuilder<
                                          AdvancedDrawerValue>(
                                        valueListenable:
                                            darw.advancedDrawerController,
                                        builder: (_, value, __) {
                                          return AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 250),
                                            child: Icon(
                                              value.visible
                                                  ? Icons.clear
                                                  : Icons.menu,
                                              key:
                                                  ValueKey<bool>(value.visible),
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: data.padding.left * 2,
                                right: data.padding.right * 2,
                                top: data.padding.top * 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 50,
                                right: 50,
                                top: 10,
                                bottom: 10,
                              ),
                              child: SizedBox(
                                height: 30,
                                //width:70,
                                child: ListView.builder(
                                  padding: EdgeInsets.only(left: 40),
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: logic.categoryList.length,
                                  itemBuilder: (context, index) {
                                    return _buildCategory(context, index);
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                    // color: Color.fromRGBO(19, 26, 44, 1.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: !logic.loading.value
                                        ? logic.realEstates.isEmpty
                                            ? const Center(
                                                child: Text(
                                                  'No available RealEstates ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              )
                                            : GetX<ProfileController>(
                                                builder: (logic) {
                                                  return ListView.builder(
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Hero(
                                                          tag: Image.network(
                                                              logic
                                                                  .realEstates[
                                                                      index]
                                                                  .images![0]),
                                                          child: buildProperty(
                                                              context,
                                                              logic.realEstates[
                                                                  index]));
                                                    },
                                                    itemCount: logic
                                                        .realEstates.length,
                                                  );
                                                },
                                              )
                                        : const Center(
                                            child: CircularProgressIndicator(),
                                          )

                                    //  ListView(
                                    //   physics: BouncingScrollPhysics(),
                                    //   scrollDirection: Axis.vertical,
                                    //   children: buildProperties(),
                                    // ),
                                    )),
                          ]),
                    );
                  },
                ),
              ));
        });
  }

  Widget buildProperty(BuildContext context, dynamic property) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return GestureDetector(
      onTap: () {
        Get.to(
          () => Details(
            uid: property.uid,
            purpose: property.purpose,
            location: property.location,
            num_bark: property.num_bark,
            num_bath: property.num_bath,
            num_bed: property.num_bed,
            num_ket: property.num_ket,
            sqm: property.sqm,
            description: property.description,
            price: property.price,
            owner: property.owner,
            owner_image: property.owner_image,
            images: property.images,
            user_number: property.user_number,
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: data.size.width / 12),
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          height: data.size.height / 2.35,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(property.images[0]))),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  width: width * 0.3,
                  height: height * 0.06,
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: Center(
                    child: Text(
                      "FOR " + property.purpose,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: width * .02,
                            ),
                            Text(
                              property.location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: data.size.height / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.zoom_out_map,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: width * .02,
                            ),
                            Text(
                              "${property.sqm}" " sq/m",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          Text(
                            r"$" " ${property.price} SDG",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ])
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, int index) {
    return GetX<ProfileController>(
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            switch (index) {
              case 0:
                logic.selectedCategoryIndex.value = index;
                logic.getAllRealEstate();
                break;
              case 1:
                logic.selectedCategoryIndex.value = index;
                logic.getAllRealEstate();
                break;
              case 2:
                logic.selectedCategoryIndex.value = index;
                logic.getAllRealEstate();
                break;
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 3),
            child: Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                  color: logic.selectedCategoryIndex.value == index
                      ? Colors.blue
                      : Colors.black.withOpacity(.1),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  logic.categoryList[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: logic.selectedCategoryIndex.value == index
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
