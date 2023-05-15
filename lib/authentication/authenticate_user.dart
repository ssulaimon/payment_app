import 'package:crypto_wallet/constants/api_keys.dart';
import 'package:crypto_wallet/database/mysql_connection.dart';
import 'package:localstore/localstore.dart';
import 'package:uuid/uuid.dart';

class AuthenticateUser {
  Future<String?> createUserAccount({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      var secreteKey = const Uuid().v4();
      MySql mySql = MySql();
      var connection = await mySql.getConnection();
      String addToTable =
          "INSERT INTO user_account(user_secrete_key, user_email,user_password, user_name)VALUES(?, ? ,? ,? )";
      await connection.query(addToTable, [
        secreteKey.toString(),
        email,
        password,
        userName,
      ]).then((value) async {
        String createTable =
            'CREATE TABLE ${userName.toLowerCase()}(id INT AUTO_INCREMENT, actionType VARCHAR(1), amount INT, sender VARCHAR(50), receiver VARCHAR(50), transaction_date DATE, PRIMARY KEY(id))';
        await connection.query(createTable);
        await connection.close();
        var localStorage = Localstore.instance;
        await localStorage
            .collection('credential')
            .doc('credential')
            .set({'email': email});
      });
      return 'Completed';
    } catch (erorr) {
      return erorr.toString();
    }
  }

  Future<String> signInAccount({required String secreteKey}) async {
    late String message;
    MySql mySql = MySql();

    var connection = await mySql.getConnection();
    String query =
        'SELECT user_email FROM user_account WHERE user_secrete_key = ?';
    await connection.query(query, [secreteKey]).then((result) {
      if (result.length == 1) {
        for (var row in result) {
          Localstore.instance
              .collection('credential')
              .doc('credential')
              .set({'email': row[0]});
        }

        message = 'successful';
      } else {
        message = 'Account not found';
      }
    });
    return message;
  }

  Future<String> logoutUser() async {
    await Localstore.instance
        .collection('credential')
        .doc('credential')
        .delete();
    return 'successful';
  }

  Future<String> getSpendingPassword() async {
    late String spendingPassword;
    MySql mySql = MySql();
    Map<String, dynamic>? userEmail = await ApiKeys.userEmail();
    var connection = await mySql.getConnection();
    String password =
        'SELECT user_password FROM user_account WHERE user_email =?';
    var query = await connection.query(password, [userEmail!['email']]);
    for (var row in query) {
      spendingPassword = row[0];
    }
    return spendingPassword;
  }

  Future<String> getKey() async {
    late String spendingPassword;
    MySql mySql = MySql();
    Map<String, dynamic>? userEmail = await ApiKeys.userEmail();
    var connection = await mySql.getConnection();
    String password =
        'SELECT user_secrete_key FROM user_account WHERE user_email =?';
    var query = await connection.query(password, [userEmail!['email']]);
    for (var row in query) {
      spendingPassword = row[0];
    }
    return spendingPassword;
  }

  Future<String?> getUserName({required String emailAddress}) async {
    String? userName;
    MySql mySql = MySql();

    var connection = await mySql.getConnection();
    String password = 'SELECT user_name FROM user_account WHERE user_email =?';
    var query = await connection.query(password, [emailAddress]);
    for (var row in query) {
      userName = row[0];
    }
    return userName;
  }
}
