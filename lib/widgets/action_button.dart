import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/widgets/text_style_custom.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ActionButton extends StatelessWidget {
  String image;
  String title;
  Function()? onTap;
  ActionButton({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            image,
            height: 30,
          ),
          Text(
            title,
            style: textStyleCustom(
              fontSize: 10,
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}
