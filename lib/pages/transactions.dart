import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/database/data_base.dart';
import 'package:crypto_wallet/models/transactions_model.dart';
import 'package:crypto_wallet/widgets/text_style_custom.dart';
import 'package:crypto_wallet/widgets/transaction_widget.dart';
import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.black,
        title: Text(
          'Transaction History',
          style: textStyleCustom(
            fontSize: 20,
            color: AppColors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder(
            future: DataBaseQueries.getAllTransaction(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blue,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Something went wrong",
                    style: textStyleCustom(
                      fontSize: 20,
                      color: AppColors.white,
                    ),
                  ),
                );
              } else {
                List<TransactionModels> transactionModel =
                    snapshot.data as List<TransactionModels>;
                return ListView.builder(
                  itemCount: transactionModel.length,
                  itemBuilder: (context, index) {
                    return TransactionWidget(
                        type: transactionModel[index].transactionType,
                        date: transactionModel[index].dateTime,
                        amount: transactionModel[index].amount);
                  },
                );
              }
            }),
      ),
    );
  }
}
