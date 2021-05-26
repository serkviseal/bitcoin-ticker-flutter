import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC', 'DOGE'];

const coinAPIURL = 'https://min-api.cryptocompare.com/data/price';
const apiKey = '808d7f843e874a37eee20c82029ba70a05ec4f79dd50607f21d72f1e8247d5a0';

class CoinData {
  Future getCoinData(String currency) async {
    Map<String, String> coinDataMap = Map();

    for (String crypto in cryptoList) {
      Uri uri = Uri.parse('$coinAPIURL?fsym=$crypto&tsyms=$currency&apiKey=$apiKey');
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        double rate = data[currency];
        coinDataMap[crypto] = rate.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }

    return coinDataMap;
  }
}
