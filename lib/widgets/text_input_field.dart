import 'package:flutter/material.dart';
import 'package:techtest_phase1_agnesty/resources/constants.dart';

class TextInputField extends StatelessWidget {
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final String labelText;
  final bool isObsecure;
  final IconData icon;
  final String? Function(String?)? validator;
  const TextInputField({
    Key? key,
    required this.textInputType,
    required this.textInputAction,
    required this.controller,
    required this.labelText,
    required this.icon,
    required this.validator,
    this.isObsecure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      textInputAction: textInputAction,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(14),
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: ColorManager.borderColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: ColorManager.borderColor,
            )),
      ),
      obscureText: isObsecure,
    );
  }
}
