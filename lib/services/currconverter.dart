import 'dart:convert';

import 'package:http/http.dart'; //You can also import the browser version

class ConverterApi {
  Future<num> getUsdEth() async {
    //reloading data from the HTTPS request
    var url = Uri.parse(
        "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=BTC,USD,EUR");

    var httpClient = Client();
    var responseUSD = await httpClient.get(url);
    Map<String, dynamic> dataEth = jsonDecode(responseUSD.body);
    return dataEth["USD"];
  }

  Future<num> getUsdBnb() async {
    //reloading data from the HTTPS request
    var url = Uri.parse(
        "https://min-api.cryptocompare.com/data/price?fsym=BNB&tsyms=BTC,USD,EUR");

    var httpClient = Client();
    var responseUSD = await httpClient.get(url);
    Map<String, dynamic> dataBnb = jsonDecode(responseUSD.body);
    return dataBnb["USD"];
  }

  Future<num> getUsdPos() async {
    //reloading data from the HTTPS request
    var url = Uri.parse(
        "https://api.polygonscan.com/api?module=stats&action=maticprice");

    var httpClient = Client();
    var responseUSD = await httpClient.get(url);
    Map<String, dynamic> data = jsonDecode(responseUSD.body);
    return double.parse(data["result"]["maticusd"]);
  }
}
