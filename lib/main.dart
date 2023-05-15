import 'package:crypto_wallet/constants/const.dart';
import 'package:crypto_wallet/pages/create_account.dart';
import 'package:crypto_wallet/pages/home_page.dart';
import 'package:crypto_wallet/pages/receive_page.dart';
import 'package:crypto_wallet/pages/recover_account.dart';
import 'package:crypto_wallet/pages/send_money.dart';
import 'package:crypto_wallet/pages/transactions.dart';
import 'package:crypto_wallet/pages/verify_payment.dart';
import 'package:crypto_wallet/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Localstore.instance.collection('credential');
  Map<String, dynamic>? user = await Localstore.instance
      .collection('credential')
      .doc('credential')
      .get();
  runApp(
    MaterialApp(
      initialRoute: user?['email'] == null
          ? PagesRoutesNames.welcomePage
          : PagesRoutesNames.homePage,
      routes: {
        PagesRoutesNames.welcomePage: (context) => const WelcomePage(),
        PagesRoutesNames.createAccount: (context) => CreateAccount(),
        PagesRoutesNames.recoverAccount: (context) => RecoverAccount(),
        PagesRoutesNames.homePage: (context) => HomePage(),
        PagesRoutesNames.sendMoney: (context) => const SendMoney(),
        PagesRoutesNames.transactions: (context) => const Transactions(),
        PagesRoutesNames.receiveMoney: (context) => const Receive(),
        PagesRoutesNames.verify: (context) => const VerifyPayment(),
      },
    ),
  );
}
