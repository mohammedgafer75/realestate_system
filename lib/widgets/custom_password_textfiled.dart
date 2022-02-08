import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatelessWidget {
  const CustomPasswordTextField(
      {Key? key,
      required this.obscureText,
      required this.controller,
      required this.validator,
      required this.onTap})
      : super(key: key);
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function() onTap;

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
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
                onTap: onTap,
                child: Icon(
                  obscureText == true ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                )),
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

            labelText: 'Password',

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
