import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:real_estate/Screens/myprofil.dart';
import 'package:real_estate/Screens/new.dart';
import 'package:real_estate/Screens/settings_page.dart';
import 'package:real_estate/controller/auth_controller.dart';

import 'homepage.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _currentTabIndex = 0;
  final _KTabPages = <Widget>[
    HomePage(),
    const SettingsPage(),
    const Profile(),
    // Wallet(),
  ];
  final _bottomBar = <BottomNavyBarItem>[
    BottomNavyBarItem(
        activeColor: Colors.amber,
        inactiveColor: Colors.white,
        icon: const Icon(Icons.home_outlined, color: Colors.white),
        title: const Text('Home Page')),
    BottomNavyBarItem(
        activeColor: Colors.amber,
        inactiveColor: Colors.white,
        icon: const Icon(Icons.settings, color: Colors.white),
        title: const Text('Settings')),
    BottomNavyBarItem(
        activeColor: Colors.amber,
        inactiveColor: Colors.white,
        icon: const Icon(Icons.person_pin_circle_rounded, color: Colors.white),
        title: const Text('My Profile')),
    // BottomNavyBarItem(
    //     icon: const Icon(Icons.account_balance_wallet_outlined,
    //         color: Colors.black),
    //     title: const Text('المحفظة')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // extendBodyBehindAppBar: false,
      // appBar: AppBar(
      //   backgroundColor: Colors.amberAccent,
      //   actions: [
      //     IconButton(onPressed: () {}, icon: Icon(Icons.arrow_drop_down)),
      //     IconButton(onPressed: () {}, icon: Icon(Icons.search))
      //   ],
      // ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
        onPressed: () {
          Get.to(New_RealEstate());
        },
        child: const Icon(Icons.add),
      ),
      // appBar: AppBar(
      //   title: const Text('RealEstate'),
      //   leading: IconButton(
      //     icon: Icon(Icons.logout),
      //     onPressed: () async {
      //       AuthController authController = AuthController();
      //       authController.signout();
      //     },
      //   ),
      // ),
      body: Container(
          color: const Color.fromRGBO(19, 26, 44, 1.0),
          child: _KTabPages[_currentTabIndex]),
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 24,
        showElevation: true,
        backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
        items: _bottomBar,
        selectedIndex: _currentTabIndex,
        curve: Curves.easeIn,
        onItemSelected: (int value) {
          setState(() {
            _currentTabIndex = value;
          });
        },
      ),
    );
  }
}
