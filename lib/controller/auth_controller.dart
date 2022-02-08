import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:real_estate/Screens/nav.dart';
import 'package:real_estate/Screens/signin.dart';
import 'package:real_estate/Screens/homepage.dart';
import 'package:get/get.dart';
import 'package:real_estate/widgets/loading.dart';
import 'package:real_estate/widgets/snackbar.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  late TextEditingController email,
      name,
      password,
      Rpassword,
      repassword,
      number;

  bool ob = false;
  //AuthController.intsance..

  static AuthController instance = Get.find();

  //email, password, name...
  late Rx<User?> _user;
  static FirebaseAuth auth = FirebaseAuth.instance;
  late Widget route;
  @override
  void onReady() {
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    super.onReady();
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    Rpassword = TextEditingController();
    repassword = TextEditingController();
    number = TextEditingController();
    name = TextEditingController();
    _user = Rx<User?>(auth.currentUser);
    //our user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    super.onInit();
  }

  String? get user_ch => _user.value!.email;
  _initialScreen(User? user) {
    if (user == null) {
      route = SignIn();
      // Get.offAll(() => const SignIn());
    } else {
      route = Nav();
      // Get.offAll(() => HomePage());
    }
  }

  String? validate(String value) {
    if (value.isEmpty) {
      return "please enter your name";
    }

    return null;
  }

  String? validateNumber(String value) {
    if (value.isEmpty) {
      return "please enter your Phone";
    }
    if (value.length < 10) {
      return "Phone length must be more than 10";
    }

    return null;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (value.isEmpty) {
      return "please enter your email";
    }

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    return null;
  }

  String? validateRePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    if (Rpassword.text != value) {
      return "password length must be more than 6 ";
    }
    return null;
  }

  changeOb() {
    ob = !ob;
    update(['password']);
  }

  void signout() async {
    await auth.signOut().then((value) => Get.offAll(() => SignIn()));
  }

  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  int ch = 0;
  void imageSelect() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage!.path.isNotEmpty) {
      ch = 1;
      imageFile = File(selectedImage.path);
    }
    update(['image']);
  }

  void register() async {
    if (ch == 1) {
      try {
        // SmartDialog.showLoading();
        showdilog();
        final credential = await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        String fileName = basename(imageFile!.path);
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('uploads/$fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        taskSnapshot.ref.getDownloadURL().then(
              (value) => print("Done: $value"),
            );
        String url;
        url = await taskSnapshot.ref.getDownloadURL();
        credential.user!.updatePhotoURL(url);
        credential.user!.updateDisplayName(name.text);
        await credential.user!.reload();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'name': name.text,
          'email': email.text,
          'number': int.tryParse(number.text.toString()),
          'uid': credential.user!.uid,
        });
        Get.back();
        // SmartDialog.dismiss();
        showbar("About User", "User message", "User Created", true);
      } catch (e) {
        Get.back();
        showbar("About User", "User message", e.toString(), false);
      }
    } else {
      showbar("About User", "User message", 'please select an image', false);
    }
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        showdilog();
        await auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        Get.back();
        Get.offAll(() => Nav());
      } catch (e) {
        Get.back();
        showbar("About Login", "Login message", e.toString(), false);
      }
    }
  }
}
