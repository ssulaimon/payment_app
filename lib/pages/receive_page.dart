import 'package:clipboard/clipboard.dart';
import 'package:crypto_wallet/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/text_style_custom.dart';

class Receive extends StatelessWidget {
  const Receive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.black,
        title: Text(
          'Receive Money',
          style: textStyleCustom(
            fontSize: 20,
            color: AppColors.white,
          ),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ssalaudeen10@gmail.com',
              style: textStyleCustom(
                fontSize: 15,
                color: AppColors.white,
              ),
            ),
            IconButton(
              onPressed: () => copyEmailAddress(
                context: context,
              ),
              icon: Icon(
                Icons.copy,
                color: AppColors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

void copyEmailAddress({
  required BuildContext context,
}) {
  FlutterClipboard.copy('ssalaudeen10@gmail.com');
  ScaffoldMessenger.of(context)
      .showSnackBar(customSnackBar(message: 'Address Copied'));
}
