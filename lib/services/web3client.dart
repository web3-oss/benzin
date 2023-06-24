import 'package:http/http.dart'; //You can also import the browser version
import 'package:web3dart/web3dart.dart';
import 'dart:convert';

class Web3RemoteCall {
  Future<EtherAmount> getEthCall() async {
    //reloading data from the HTTPS request
    const ethUrl =
        "https://eth-mainnet.g.alchemy.com/v2/JOzEFgQfsx-d__b7tUXuEF2jYudxi3Qz";
    var httpClient = Client();
    var ethClient = Web3Client(ethUrl, httpClient);
    var ethPrice = await ethClient.getGasPrice();
    return ethPrice;
  }

  Future<EtherAmount> getPosCall() async {
    //reloading data from the HTTPS request
    const posUrl =
        "https://polygon-mainnet.g.alchemy.com/v2/n6ZvQpps2HtwrK8yNY7Yjibzoyb6aGdk";
    var httpClient = Client();
    var posClient = Web3Client(posUrl, httpClient);
    var posPrice = await posClient.getGasPrice();
    return posPrice;
  }

  Future<Map> getBscCall() async {
    //reloading data from the HTTPS request
    final bscUrl = Uri.parse(
        "https://api.bscscan.com/api?module=gastracker&action=gasoracle&apikey=S7PJRSHG38TFDSDSSR2N3Y6B61S8A58H5U");
    var httpClient = Client();
    var responseUSD = await httpClient.get(bscUrl);
    Map<String, dynamic> bscResponse = jsonDecode(responseUSD.body);
    return bscResponse;
  }

  Future<Map> postBscCall() async {
    //reloading data from the HTTPS request
    final bscUrl = Uri.parse("https://bsc.getblock.io/mainnet/");
    final headers = {
      'x-api-key': '7ef1a7fe-1449-403d-9f2a-480bf5718761',
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
