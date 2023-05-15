import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/constants/const.dart';
import 'package:crypto_wallet/widgets/button_custom.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonCustom(
            title: 'Create New Wallet',
            onTap: () => Navigator.pushNamed(
              context,
              PagesRoutesNames.createAccount,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonCustom(
            title: 'Recover Wallet',
            onTap: () => Navigator.pushNamed(
              context,
              PagesRoutesNames.recoverAccount,
            ),
          )
        ],
      ),
    );
  }
}
