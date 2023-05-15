// ignore_for_file: use_build_context_synchronously

import 'package:crypto_wallet/authentication/authenticate_user.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/constants/const.dart';
import 'package:crypto_wallet/widgets/button_custom.dart';
import 'package:crypto_wallet/widgets/custom_snack_bar.dart';
import 'package:crypto_wallet/widgets/custom_text_form.dart';
import 'package:crypto_wallet/widgets/text_style_custom.dart';
import 'package:flutter/material.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({super.key});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  TextEditingController amount = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.black,
        title: Text(
          'Send Money',
          style: textStyleCustom(
            fontSize: 20,
            color: AppColors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Form(
          key: formState,
          child: Column(
            children: [
              CustomTextFormField(
                hint: 'Receiver email address',
                textEditingController: email,
                validator: (text) => emailValdator(text),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                validator: (text) => amountValidator(text),
                hint: 'Amount',
                textInputType: TextInputType.number,
                textEditingController: amount,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Checkbox(
                      value: checked,
                      onChanged: (value) {
                        setState(() {
                          checked = value!;
                        });
                      }),
                  Text(
                    'I confirm the email address i entered is correct.',
                    style:
                        textStyleCustom(fontSize: 10, color: AppColors.white),
                  ),
                ],
              ),
              ButtonCustom(
                title: 'Send',
                onTap: () async {
                  if (formState.currentState!.validate() && checked == true) {
                    AuthenticateUser authenticateUser = AuthenticateUser();
                    String? userName = await authenticateUser.getUserName(
                        emailAddress: email.text);
                    if (userName == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          customSnackBar(message: 'User not found'));
                    } else {
                      Navigator.pushNamed(context, PagesRoutesNames.verify,
                          arguments: {
                            "userName": userName,
                            "amount": amount.text,
                            'email': email.text
                          });
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

String? amountValidator(String? text) {
  if (text!.isEmpty) {
    return 'Please Enter an amount';
  } else {
    return null;
  }
}
