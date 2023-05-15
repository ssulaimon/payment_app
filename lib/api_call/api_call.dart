import 'dart:convert';

import 'package:crypto_wallet/constants/api_keys.dart';
import 'package:crypto_wallet/constants/images_const.dart';
import 'package:crypto_wallet/models/coins_model.dart';
import 'package:http/http.dart';

class ApiCall {
  static Future<List<CoinModels>?> getCryptoPrices() async {
    var url = Uri.parse(ApiKeys.apiUrl).replace(queryParameters: {
      "ids": ApiKeys.id,
      "vs_currencies": ApiKeys.vsCurrency,
      "include_24hr_change": 'true',
    });
    Response response = await get(
      url,
      headers: {
        ApiKeys.key: ApiKeys.apikey,
        ApiKeys.hostKey: ApiKeys.host,
      },
    );
    if (response.statusCode == 200) {
      Map data = await jsonDecode(response.body);
      List<CoinModels> coinModels = [
        CoinModels(
          symbol: 'BTC',
          image: ImagesConst.bitcoin,
          name: 'Bitcoin',
          price: data['bitcoin']['usd'].toString(),
          change: data['bitcoin']['usd_24h_change'].toString(),
        ),
        CoinModels(
          symbol: 'ETH',
          image: ImagesConst.ethereum,
          name: "Ethereum",
          price: data['ethereum']['usd'].toString(),
          change: data['ethereum']['usd_24h_change'].toString(),
        ),
        CoinModels(
            change: data['cardano']['usd_24h_change'].toString(),
            symbol: 'ADA',
            image: ImagesConst.cardano,
            name: 'Cardano',
            price: data['cardano']['usd'].toString()),
        CoinModels(
            change: data['tether']['usd_24h_change'].toString(),
            symbol: 'USDT',
            image: ImagesConst.usdt,
            name: 'Tether',
            price: data['tether']['usd'].toString()),
        CoinModels(
            change: data['dogecoin']['usd_24h_change'].toString(),
            symbol: 'DOGE',
            image: ImagesConst.doge,
            name: 'Dogecoin',
            price: data['dogecoin']['usd'].toString()),
        CoinModels(
            change: data['matic-network']['usd_24h_change'].toString(),
            symbol: 'MATIC',
            image: ImagesConst.polygon,
            name: 'Polygon',
            price: data['matic-network']['usd'].toString()),
        CoinModels(
            change: data['solana']['usd_24h_change'].toString(),
            symbol: 'SOL',
            image: ImagesConst.solana,
            name: 'Solana',
            price: data['solana']['usd'].toString()),
      ];
      return coinModels;
    } else {
      return Future.error(
        response.statusCode,
      );
    }
  }
}
