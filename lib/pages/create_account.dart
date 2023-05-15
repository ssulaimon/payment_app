import 'dart:developer';

import 'package:crypto_wallet/authentication/authenticate_user.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/constants/const.dart';
import 'package:crypto_wallet/widgets/button_custom.dart';
import 'package:crypto_wallet/widgets/custom_snack_bar.dart';
import 'package:crypto_wallet/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';

import '../widgets/text_style_custom.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userName = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                validator: (text) => emailValdator(text),
                textEditingController: email,
                hint: 'Email Address',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                validator: (text) => userNameValidator(text),
                textEditingController: userName,
                hint: 'User Name',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                textEditingController: password,
                validator: (text) => passwordValidator(text),
                hint: 'Spending Password',
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Please save your secret key safely',
                style: textStyleCustom(
                  fontSize: 15,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonCustom(
                title: 'Create Wallet',
                onTap: () async {
                  AuthenticateUser authenticateUser = AuthenticateUser();
                  if (formState.currentState!.validate()) {
                    String? result = await authenticateUser.createUserAccount(
                      email: email.text,
                      password: password.text,
                      userName: userName.text,
                    );
                    if (result!.contains('user_name')) {
                      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                          message: 'User name have been picked'));
                    } else if (result.contains('user_email')) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          customSnackBar(message: 'Email address used'));
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                          context, PagesRoutesNames.homePage, (route) => false);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

String? emailValdator(String? text) {
  if (text!.isEmpty) {
    return 'Please Enter your email address';
  } else if (text.length < 4) {
    return 'Email is too short';
  } else if (!text.contains("@") || !text.contains('.')) {
    return 'Invalid email type';
  } else {
    return null;
  }
}

String? passwordValidator(String? text) {
  if (text!.isEmpty) {
    return 'Please enter password';
  } else if (text.length < 5) {
    return 'Password choice is too short';
  } else {
    return null;
  }
}

String? userNameValidator(String? text) {
  if (text!.isEmpty) {
    return 'Please enter Your full name';
  } else if (text.length < 5) {
    return 'Full name is too short';
  } else {
    return null;
  }
}
