import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/controller/auth_controller.dart';
import 'package:real_estate/Screens/signup.dart';
import 'package:real_estate/widgets/custom_button.dart';
import 'package:real_estate/widgets/custom_password_textfiled.dart';
import 'package:real_estate/widgets/custom_textfield.dart';
import '../widgets/background-image.dart';

class SignIn extends StatelessWidget {
  TextStyle kBodyText =
      const TextStyle(fontSize: 14, color: Colors.white, height: 1.5);

  AuthController controller = Get.find();

  SignIn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final height = data.size.height;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            const BackgroundImage(image: 'images/1.jpg'),
            Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height / 5.0),
                    child: const Center(
                      child: Text(
                        'RealEstate',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: data.padding.top * .7,
                      // bottom: data.padding.bottom * .3),
                    ),
                    height: height * 0.4,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: controller.email,
                          validator: (value) {
                            controller.validateEmail(value!);
                          },
                          lable: 'Email',
                        ),
                        GetBuilder<AuthController>(
                          id: 'password',
                          builder: (controller) {
                            return CustomPasswordTextField(
                                obscureText: controller.ob,
                                controller: controller.password,
                                validator: (value) {
                                  controller.validatePassword(value!);
                                },
                                onTap: () {
                                  controller.changeOb();
                                });
                          },
                        ),
                        SizedBox(height: height * 0.03),
                        Center(
                            child: CustomTextButton(
                          lable: 'Sign In',
                          ontap: () {
                            controller.login();
                          },
                        )),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: kBodyText,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => Sign());
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
