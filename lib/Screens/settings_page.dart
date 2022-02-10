import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:real_estate/controller/drawer_controller.dart';
import 'package:real_estate/controller/setting_controller.dart';
import 'package:real_estate/widgets/drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
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
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Scaffold(
              backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
              body: Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(15)),
                            child: IconButton(
                              onPressed: () {
                                darw.handleMenuButtonPressed();
                              },
                              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                                valueListenable: darw.advancedDrawerController,
                                builder: (_, value, __) {
                                  return AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 250),
                                    child: Icon(
                                      value.visible ? Icons.clear : Icons.menu,
                                      key: ValueKey<bool>(value.visible),
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            )),
                      ],
                    ),
                    GetBuilder<SettingController>(
                        autoRemove: false,
                        init: SettingController(),
                        builder: (logic) {
                          return logic.loading.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: data.padding.left * 2,
                                        right: data.padding.right * 2,
                                        top: data.padding.top * 2,
                                      ),
                                      // decoration: BoxDecoration(
                                      //   color: Colors.grey[500]!.withOpacity(0.5),
                                      //   borderRadius: BorderRadius.circular(16),
                                      // ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Stack(
                                            children: [
                                              Center(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    logic.changeImage();
                                                  },
                                                  child: Container(
                                                    width: 128.0,
                                                    height: 128.0,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      top: 24.0,
                                                      bottom: 64.0,
                                                    ),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      //color: Color.fromRGBO(19, 26, 44, 1.0),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl:
                                                              logic.url.value,
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      downloadProgress) =>
                                                                  Center(
                                                            child: CircularProgressIndicator(
                                                                value: downloadProgress
                                                                    .progress),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              (const Icon(
                                                                  Icons.error)),
                                                          width: 1000,
                                                        ),
                                                        const Center(
                                                            child: Icon(
                                                          Icons.add_a_photo,
                                                          color: Colors.white,
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ListTile(
                                            title: Text(logic.userName.value,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            trailing: IconButton(
                                              icon: const Icon(Icons.edit,
                                                  color: Colors.white),
                                              onPressed: () {
                                                logic.changeName();
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: Text('${logic.user_email}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            trailing: IconButton(
                                              icon: const Icon(Icons.edit,
                                                  color: Colors.white),
                                              onPressed: () {
                                                logic.changeEmail();
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: const Text('Password',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            trailing: IconButton(
                                              icon: const Icon(Icons.edit,
                                                  color: Colors.white),
                                              onPressed: () {
                                                logic.changePassword();
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: Text('${logic.number.value}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            trailing: IconButton(
                                              icon: const Icon(
                                                Icons.edit_sharp,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                logic.changePhone();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
