import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/widgets/text_style_custom.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonCustom extends StatelessWidget {
  String title;
  Function()? onTap;
  ButtonCustom({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          color: AppColors.primaryColor,
        ),
        alignment: Alignment.center,
        child: Text(title,
            style: textStyleCustom(
              fontSize: 15,
              color: AppColors.white,
            )),
      ),
    );
  }
}
