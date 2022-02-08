import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.validator,
    required this.lable,
  }) : super(key: key);
  // final double width, height;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String lable;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.only(right: width / 100, left: width / 100),
        height: height * 0.1,
        width: width * 0.8,
        child: TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 3.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.white70.withOpacity(.7), width: 1.0),
            ),
            prefixIcon: const Icon(
              Icons.lock,
              size: 28,
              color: Colors.white,
            ),

            labelText: lable,

            labelStyle: const TextStyle(color: Colors.white),
            // hintText: hint,
            hintStyle: const TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),

          //  style: kBodyText,
        ),
      ),
    );
  }
}
