import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/Screens/homepage.dart';
import 'package:real_estate/Screens/myprofil.dart';
import 'package:real_estate/Screens/settings_page.dart';
import 'package:real_estate/Screens/signin.dart';

class Drawer_w extends StatelessWidget {
  const Drawer_w({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    auth.User? user = FirebaseAuth.instance.currentUser;
    String url = user!.photoURL!;

    return SafeArea(
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
              decoration: const BoxDecoration(
                //color: Color.fromRGBO(19, 26, 44, 1.0),
                shape: BoxShape.circle,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                },
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: url,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) =>
                      (const Icon(Icons.error)),
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
    );
  }
}
