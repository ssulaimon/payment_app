// ignore_for_file: must_be_immutable

import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/widgets/text_style_custom.dart';
import 'package:flutter/cupertino.dart';

class TransactionWidget extends StatelessWidget {
  String type;
  String date;
  String amount;
  TransactionWidget({
    super.key,
    required this.type,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        color: AppColors.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration:
                BoxDecoration(color: AppColors.purple, shape: BoxShape.circle),
            child: Text(type,
                style: textStyleCustom(fontSize: 15, color: AppColors.white)),
          ),
          Text(
            date,
            style: textStyleCustom(fontSize: 15, color: AppColors.white),
          ),
          Text(type == 'R' ? "+\$$amount" : "-\$$amount",
              style: textStyleCustom(
                fontSize: 15,
                color: type == 'R' ? AppColors.green : AppColors.error,
              )),
        ],
      ),
    );
  }
}
