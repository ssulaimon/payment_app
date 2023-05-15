import 'package:crypto_wallet/constants/api_keys.dart';
import 'package:mysql1/mysql1.dart';

class MySql {
  Future<MySqlConnection> getConnection() async {
    var connection = ConnectionSettings(
      host: ApiKeys.hostMysql,
      db: ApiKeys.db,
      port: ApiKeys.port,
      password: ApiKeys.password,
      user: ApiKeys.userName,
    );
    return await MySqlConnection.connect(
      connection,
    );
  }
}
