import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/widgets/text_style_custom.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  TextEditingController? textEditingController;
  String hint;
  TextInputType? textInputType;
  bool? obsecure;
  String? Function(String?)? validator;

  CustomTextFormField(
      {super.key,
      required this.hint,
      this.textInputType,
      this.obsecure,
      this.textEditingController,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: textEditingController,
      obscureText: obsecure ?? false,
      style: TextStyle(color: AppColors.white),
      keyboardType: textInputType,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.white,
        )),
        hintText: hint,
        hintStyle: textStyleCustom(
          fontSize: 12,
          color: AppColors.white,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.white,
        )),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.error,
          ),
        ),
      ),
    );
  }
}
