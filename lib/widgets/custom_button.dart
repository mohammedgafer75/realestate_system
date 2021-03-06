import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({Key? key, required this.lable, required this.ontap})
      : super(key: key);
  final String lable;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return TextButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.only(
              top: height / 45,
              bottom: height / 45,
              left: width / 10,
              right: width / 10)),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromRGBO(19, 26, 44, 1.0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                  side: const BorderSide(
                      color: Color.fromRGBO(19, 26, 44, 1.0))))),
      onPressed: ontap,
      child: Text(
        lable,
        style: const TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
}
