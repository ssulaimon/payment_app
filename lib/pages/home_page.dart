// ignore_for_file: use_build_context_synchronously

import 'package:clipboard/clipboard.dart';
import 'package:crypto_wallet/api_call/api_call.dart';
import 'package:crypto_wallet/authentication/authenticate_user.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/constants/const.dart';
import 'package:crypto_wallet/constants/images_const.dart';
import 'package:crypto_wallet/database/data_base.dart';
import 'package:crypto_wallet/models/coins_model.dart';
import 'package:crypto_wallet/widgets/action_button.dart';
import 'package:crypto_wallet/widgets/button_custom.dart';
import 'package:crypto_wallet/widgets/crypto_widget.dart';
import 'package:crypto_wallet/widgets/custom_snack_bar.dart';
import 'package:crypto_wallet/widgets/custom_text_form.dart';
import 'package:crypto_wallet/widgets/text_style_custom.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController spendingPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.black,
        title: Text(
          'My Wallet',
          style: textStyleCustom(
            fontSize: 20,
            color: AppColors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async => securityCheck(
                context: context, textEditingController: spendingPassword),
            icon: Icon(
              Icons.enhanced_encryption,
              color: AppColors.white,
            ),
          ),
          IconButton(
            onPressed: () async {
              AuthenticateUser authenticateUser = AuthenticateUser();
              await authenticateUser.logoutUser();
              Navigator.popAndPushNamed(context, PagesRoutesNames.welcomePage);
            },
            icon: Icon(
              Icons.logout,
              color: AppColors.white,
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(
                Icons.refresh,
                color: AppColors.white,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                gradient: LinearGradient(
                  colors: [AppColors.blue, AppColors.purple],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              height: 150,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Balance',
                    style: textStyleCustom(
                      fontSize: 20,
                      color: AppColors.white,
                    ),
                  ),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          "Getting balance",
                          style: textStyleCustom(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          "Something Went Wrong",
                          style: textStyleCustom(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        );
                      } else {
                        int balance = snapshot.data as int;
                        return Text(
                          "\$${balance.toString()}",
                          style: textStyleCustom(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        );
                      }
                    },
                    future: DataBaseQueries.getBalance(),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                  image: ImagesConst.send,
                  title: 'Send',
                  onTap: () => Navigator.pushNamed(
                    context,
                    PagesRoutesNames.sendMoney,
                  ),
                ),
                ActionButton(
                  image: ImagesConst.receive,
                  title: 'Receive',
                  onTap: () => Navigator.pushNamed(
                    context,
                    PagesRoutesNames.receiveMoney,
                  ),
                ),
                ActionButton(
                  image: ImagesConst.transaction,
                  title: 'Transactions',
                  onTap: () => Navigator.pushNamed(
                    context,
                    PagesRoutesNames.transactions,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Crypto Price',
              style: textStyleCustom(
                fontSize: 15,
                color: AppColors.white,
              ),
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder(
                future: ApiCall.getCryptoPrices(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.purple,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Something went wrong!!!',
                        style: textStyleCustom(
                          fontSize: 20,
                          color: AppColors.white,
                        ),
                      ),
                    );
                  } else {
                    List<CoinModels> coinsModels =
                        snapshot.data as List<CoinModels>;
                    return ListView.separated(
                      itemCount: coinsModels.length,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: AppColors.white,
                        );
                      },
                      itemBuilder: (context, index) {
                        return CryptoWidget(
                            color: coinsModels[index].change.contains('-')
                                ? AppColors.error
                                : AppColors.green,
                            image: coinsModels[index].image,
                            name: coinsModels[index].name,
                            price: "\$${coinsModels[index].price}",
                            symbol: coinsModels[index].symbol);
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> securityCheck({
  required BuildContext context,
  required TextEditingController textEditingController,
}) async {
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Security Check',
            style: textStyleCustom(fontSize: 15, color: AppColors.white),
          ),
          backgroundColor: AppColors.grey,
          content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(
                textEditingController: textEditingController,
                hint: 'Enter Spending Password',
                obsecure: true,
              )),
          actions: [
            ButtonCustom(
              onTap: () async {
                AuthenticateUser authenticateUser = AuthenticateUser();
                String spendingPassword =
                    await authenticateUser.getSpendingPassword();

                if (textEditingController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(message: 'Spending Password is empty'));
                } else if (textEditingController.text != spendingPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                      message: 'Spending Password is Incorrect'));
                } else {
                  String secreteKey = await authenticateUser.getKey();
                  reavealKey(context: context, userKey: secreteKey);
                }
              },
              title: 'Verify',
            ),
          ],
        );
      });
}

Future<void> reavealKey(
    {required BuildContext context, required String userKey}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Your Secrete Key',
            style: textStyleCustom(fontSize: 15, color: AppColors.white),
          ),
          backgroundColor: AppColors.black,
          content: Row(
            children: [
              Expanded(
                child: Text(
                  userKey,
                  style: textStyleCustom(
                    fontSize: 15,
                    color: AppColors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  FlutterClipboard.copy(userKey);
                  ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(message: 'Secrete key Copied'));
                },
                icon: Icon(
                  Icons.copy,
                  color: AppColors.white,
                ),
              )
            ],
          ),
        );
      });
}
