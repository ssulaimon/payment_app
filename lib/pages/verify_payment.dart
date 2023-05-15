import 'dart:developer';

import 'package:crypto_wallet/authentication/authenticate_user.dart';
import 'package:crypto_wallet/constants/api_keys.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/database/data_base.dart';
import 'package:crypto_wallet/models/payment_model.dart';
import 'package:crypto_wallet/widgets/button_custom.dart';
import 'package:crypto_wallet/widgets/custom_snack_bar.dart';
import 'package:crypto_wallet/widgets/text_style_custom.dart';
import 'package:flutter/material.dart';

class VerifyPayment extends StatelessWidget {
  const VerifyPayment({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguement =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.black,
        title: Text(
          'Verify Payment',
          style: textStyleCustom(
            fontSize: 20,
            color: AppColors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'UserName:  ${arguement['userName']}',
              style: textStyleCustom(
                fontSize: 18,
                color: AppColors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Amount: \$${arguement['amount']}',
              style: textStyleCustom(
                fontSize: 18,
                color: AppColors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Email: ${arguement['email']}',
              style: textStyleCustom(
                fontSize: 18,
                color: AppColors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonCustom(
              title: "Send Money",
              onTap: () => send(
                receiverUsername: arguement['userName'],
                receiver: arguement['email'],
                amount: arguement['amount'],
                context: context,
              ),
            )
          ],
        ),
      ),
    );
  }
}

void send(
    {required String amount,
    required BuildContext context,
    required String receiver,
    required String receiverUsername}) async {
  int balance = await DataBaseQueries.getBalance();
  int getReceiverBalance =
      await DataBaseQueries.getReceiverBalance(recieverEmail: receiver);
  int amountSent = int.parse(amount);
  if (amountSent > balance) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(customSnackBar(message: "Insufficent Balance"));
  } else {
    Map<String, dynamic>? sendEmail = await ApiKeys.userEmail();
    DateTime dateTime = DateTime.now();
    balance = balance - amountSent;
    getReceiverBalance = getReceiverBalance + amountSent;
    await DataBaseQueries.updateReceiverBalance(
        newBalance: getReceiverBalance, email: receiver);
    await DataBaseQueries.updateSenderBalance(newBalance: balance);

    PaymentModel recieverTransaction = PaymentModel(
        amount: amountSent,
        date:
            '${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()}',
        paymentType: 'R',
        reciever: receiverUsername,
        sender: sendEmail!['email'],
        userName: receiverUsername);
    await DataBaseQueries.addTranscation(paymentModel: recieverTransaction);
    AuthenticateUser authenticateUser = AuthenticateUser();
    String? senderUserName = await authenticateUser.getUserName(
      emailAddress: sendEmail['email'],
    );

    PaymentModel senderPaymentTransaction = PaymentModel(
        amount: amountSent,
        date:
            '${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()}',
        paymentType: 'T',
        reciever: receiver,
        sender: sendEmail['email'],
        userName: senderUserName!);
    await DataBaseQueries.addTranscation(
        paymentModel: senderPaymentTransaction);
    await showCompletedMessage(context: context);
  }
}

Future<void> showCompletedMessage({required BuildContext context}) async {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.black,
          title: Text(
            'Transfer completed',
            style: textStyleCustom(
              fontSize: 15,
              color: AppColors.white,
            ),
          ),
          content: Icon(
            Icons.check,
            color: AppColors.green,
            size: 50,
          ),
        );
      });
}
