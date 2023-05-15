import 'package:crypto_wallet/authentication/authenticate_user.dart';
import 'package:crypto_wallet/constants/api_keys.dart';
import 'package:crypto_wallet/database/mysql_connection.dart';
import 'package:crypto_wallet/models/payment_model.dart';
import 'package:crypto_wallet/models/transactions_model.dart';
import 'package:localstore/localstore.dart';

class DataBaseQueries {
  static Future<int> getBalance() async {
    Map<String, dynamic>? user = await Localstore.instance
        .collection('credential')
        .doc('credential')
        .get();
    int? balance;
    var mysql = await MySql().getConnection();
    String value = 'SELECT balance FROM user_account WHERE user_email =?';
    var qurey = await mysql.query(value, [user!['email']]);
    for (var row in qurey) {
      balance = row[0];
    }

    return balance!;
  }

  static Future<int> getReceiverBalance({required String recieverEmail}) async {
    int? balance;
    var mysql = await MySql().getConnection();
    String value = 'SELECT balance FROM user_account WHERE user_email =?';
    var qurey = await mysql.query(value, [recieverEmail]);
    for (var row in qurey) {
      balance = row[0];
    }

    return balance!;
  }

  static Future<void> updateSenderBalance({required int newBalance}) async {
    MySql mySql = MySql();
    Map<String, dynamic>? userEmail = await ApiKeys.userEmail();
    var connection = await mySql.getConnection();
    String query = 'UPDATE user_account SET balance = ? WHERE user_email = ? ';
    connection.query(
      query,
      [
        newBalance,
        userEmail!['email'],
      ],
    );
  }

  static Future<void> updateReceiverBalance(
      {required int newBalance, required String email}) async {
    MySql mySql = MySql();

    var connection = await mySql.getConnection();
    String query = 'UPDATE user_account SET balance = ? WHERE user_email = ? ';
    connection.query(query, [
      newBalance,
      email,
    ]);
  }

  static Future<void> addTranscation(
      {required PaymentModel paymentModel}) async {
    MySql mySql = MySql();
    var connection = await mySql.getConnection();
    String query =
        'INSERT INTO ${paymentModel.userName.toLowerCase()}(actionType,amount,sender,receiver,transaction_date) VALUES(?,?,?,?,?)';
    await connection.query(query, [
      paymentModel.paymentType,
      paymentModel.amount,
      paymentModel.sender,
      paymentModel.reciever,
      paymentModel.date,
    ]);
  }

  static Future<List<TransactionModels>> getAllTransaction() async {
    List<TransactionModels> transaction = [];
    MySql mySql = MySql();
    var connection = await mySql.getConnection();
    AuthenticateUser authenticateUser = AuthenticateUser();
    Map<String, dynamic>? userEmail = await ApiKeys.userEmail();
    String? getUsername =
        await authenticateUser.getUserName(emailAddress: userEmail!['email']);
    String query = 'SELECT * FROM $getUsername ORDER BY id DESC';
    await connection
        .query(
      query,
    )
        .then((result) {
      for (var row in result) {
        DateTime date = row[5];

        transaction.add(TransactionModels(
            dateTime: '${date.year}-${date.month}-${date.day}',
            amount: row[2].toString(),
            transactionType: row[1].toString()));
      }
    });
    return transaction;
  }
}
