import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/Screens/signin.dart';
import 'package:real_estate/Screens/homepage.dart';
import 'package:real_estate/Screens/myprofil.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:real_estate/controller/setting_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Stack(
      children: [
        // BackgroundImage(image: 'images/1.jpg'),
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
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                        margin: const EdgeInsets.only(
                                          top: 24.0,
                                          bottom: 64.0,
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          //color: Color.fromRGBO(19, 26, 44, 1.0),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: logic.url.value,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      (const Icon(Icons.error)),
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
                                        fontWeight: FontWeight.bold)),
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
                                        fontWeight: FontWeight.bold)),
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
                                        fontWeight: FontWeight.bold)),
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
                                        fontWeight: FontWeight.bold)),
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
    );
  }

  void showBar(BuildContext context, String msg, int ch) {
    var bar = SnackBar(
      backgroundColor: ch == 0 ? Colors.red : Colors.green,
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }
}

class Drawer_w extends StatelessWidget {
  const Drawer_w({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    auth.User? user = FirebaseAuth.instance.currentUser;
    String url = user!.photoURL!;

    return SafeArea(
      child: Container(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  //color: Color.fromRGBO(19, 26, 44, 1.0),
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: url,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) => (Icon(Icons.error)),
                    width: 1000,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                leading: Icon(Icons.account_circle_rounded),
                title: Text('My RealEstate'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              Spacer(),
              Column(
                children: [
                  // SizedBox(
                  //   height: data.size.height * 0.02,
                  // ),
                  ListTile(
                    title: const Text(
                      'LogOut',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    leading: const Icon(
                      Icons.input,
                      color: Colors.black,
                    ),
                    onTap: () async {
                      final FirebaseAuth _auth = FirebaseAuth.instance;
                      await _auth.signOut();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
