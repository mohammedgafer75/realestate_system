import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate/controller/auth_controller.dart';
import 'package:real_estate/services/http.dart';
import 'package:real_estate/widgets/background-image.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate/widgets/custom_button.dart';
import 'package:real_estate/widgets/custom_password_textfiled.dart';
import 'package:real_estate/widgets/custom_textfield.dart';
import 'package:real_estate/widgets/snackbar.dart';

class Sign extends StatelessWidget {
  AuthController controller = Get.find();

  Sign({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
      ),
      body: Stack(
        children: [
          const BackgroundImage(image: 'images/1.jpg'),
          Form(
            key: controller.formKey2,
            child: ListView(
              padding: EdgeInsets.only(top: height * 0.05),
              children: <Widget>[
                InkWell(
                  child: Center(
                    child: Stack(
                      children: [
                        GetBuilder<AuthController>(
                          id: 'image',
                          builder: (controller) {
                            return CircleAvatar(
                              maxRadius: 70,
                              backgroundImage: controller.imageFile == null
                                  ? const AssetImage('assets/images/user.png')
                                  : Image.file(controller.imageFile!).image,
                              child: const Icon(Icons.add_a_photo,
                                  color: Colors.white),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    controller.imageSelect();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                      padding:
                          EdgeInsets.only(right: width / 8, left: width / 8),
                      height: height * 0.1,
                      width: width * 1.0,
                      child: CustomTextField(
                        lable: 'Name',
                        controller: controller.name,
                        validator: (value) {
                          controller.validate(value!);
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                      padding:
                          EdgeInsets.only(right: width / 8, left: width / 8),
                      height: height * 0.1,
                      width: width * 1.0,
                      child: CustomTextField(
                        lable: 'Email',
                        controller: controller.email,
                        validator: (value) {
                          controller.validateEmail(value!);
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                      padding:
                          EdgeInsets.only(right: width / 8, left: width / 8),
                      height: height * 0.1,
                      width: width * 1.0,
                      child: GetBuilder<AuthController>(
                        id: 'password',
                        builder: (controller) {
                          return CustomPasswordTextField(
                            controller: controller.password,
                            obscureText: controller.ob,
                            validator: (value) {
                              controller.validatePassword(value!);
                            },
                            onTap: () {
                              controller.changeOb();
                            },
                          );
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                      padding:
                          EdgeInsets.only(right: width / 8, left: width / 8),
                      height: height * 0.1,
                      width: width * 1.0,
                      child: GetBuilder<AuthController>(
                        id: 'password',
                        builder: (controller) {
                          return CustomPasswordTextField(
                            controller: controller.repassword,
                            obscureText: controller.ob,
                            validator: (value) {
                              controller.validateRePassword(value!);
                            },
                            onTap: () {
                              controller.changeOb();
                            },
                          );
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                      padding:
                          EdgeInsets.only(right: width / 8, left: width / 8),
                      height: height * 0.1,
                      width: width * 1.0,
                      child: CustomTextField(
                        lable: 'Phone Number',
                        controller: controller.number,
                        validator: (value) {
                          controller.validateNumber(value!);
                        },
                      )),
                ),
                Center(
                    child: CustomTextButton(
                  lable: 'Sign Up',
                  ontap: () {
                    controller.register();
                  },
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
