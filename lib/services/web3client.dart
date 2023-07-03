import 'package:http/http.dart'; //You can also import the browser version
import 'package:web3dart/web3dart.dart';
import 'dart:convert';

class Web3RemoteCall {
  Future<EtherAmount> getEthCall() async {
    //reloading data from the HTTPS request
    const eth_key = String.fromEnvironment('eth_key');
    const ethUrl = "https://eth-mainnet.g.alchemy.com/v2/" + eth_key;
    var httpClient = Client();
    var ethClient = Web3Client(ethUrl, httpClient);
    var ethPrice = await ethClient.getGasPrice();
    return ethPrice;
  }

  Future<EtherAmount> getPosCall() async {
    //reloading data from the HTTPS request
    const poly_key = String.fromEnvironment('eth_key');
    const posUrl = "https://polygon-mainnet.g.alchemy.com/v2/" + poly_key;
    var httpClient = Client();
    var posClient = Web3Client(posUrl, httpClient);
    var posPrice = await posClient.getGasPrice();
    return posPrice;
  }

  Future<Map> getBscCall() async {
    //reloading data from the HTTPS request
    const bsc_get_key = String.fromEnvironment('bsc_get_key');

    final bscUrl = Uri.parse(
        "https://api.bscscan.com/api?module=gastracker&action=gasoracle&apikey=" +
            bsc_get_key);
    var httpClient = Client();
    var responseUSD = await httpClient.get(bscUrl);
    Map<String, dynamic> bscResponse = jsonDecode(responseUSD.body);
    return bscResponse;
  }

  Future<Map> postBscCall() async {
    //reloading data from the HTTPS request
    const bsc_post_key = String.fromEnvironment('bsc_post_key');
    final bscUrl = Uri.parse("https://bsc.getblock.io/mainnet/");
    final headers = {
      'x-api-key': bsc_post_key,
      'Content-Type': 'application/json'
    };
    Map<String, dynamic> body = {
      "jsonrpc": "2.0",
      "method": "eth_gasPrice",
      "params": [],
      "id": "getblock.io"
    };
    String jsonBody = json.encode(body);

    Response response = await post(
      bscUrl,
      headers: headers,
      body: jsonBody,
    );
    Map<String, dynamic> bscResponse = {};
    bscResponse = jsonDecode(response.body);
    return bscResponse;
  }
}
