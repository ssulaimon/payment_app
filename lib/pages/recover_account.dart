import 'package:crypto_wallet/authentication/authenticate_user.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/constants/const.dart';
import 'package:crypto_wallet/widgets/button_custom.dart';
import 'package:crypto_wallet/widgets/custom_snack_bar.dart';
import 'package:crypto_wallet/widgets/custom_text_form.dart';

import 'package:flutter/material.dart';

class RecoverAccount extends StatelessWidget {
  RecoverAccount({super.key});
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController secreteKey = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Form(
          key: formState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                validator: (text) => secreteKeyValidator(text),
                textEditingController: secreteKey,
                hint: 'Secret Key',
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonCustom(
                  title: 'Recover Account',
                  onTap: () async {
                    AuthenticateUser authenticateUser = AuthenticateUser();
                    String loginUser = await authenticateUser.signInAccount(
                        secreteKey: secreteKey.text);
                    if (loginUser == 'successful') {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          PagesRoutesNames.homePage, (route) => false);
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(customSnackBar(message: loginUser));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

String? secreteKeyValidator(String? text) {
  if (text!.isEmpty) {
    return 'Secrete key cannot be empty';
  } else if (text.length < 6) {
    return 'Invalid secrete key';
  } else {
    return null;
  }
}
