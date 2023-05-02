import 'package:http/http.dart'; //You can also import the browser version
import 'package:web3dart/web3dart.dart';

class Web3RemoteCall {
  Future<String?> getEthCall() async {
    //reloading data from the HTTPS request
    const ethUrl =
        "https://polygon-mainnet.g.alchemy.com/v2/n6ZvQpps2HtwrK8yNY7Yjibzoyb6aGdk";
    var httpClient = Client();
    var ethClient = Web3Client(ethUrl, httpClient);
    var ethPrice = await ethClient.getGasPrice();
    return ethPrice.toString();
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

  Future<String?> getOptCall() async {
    //reloading data from the HTTPS request
    const optUrl =
        "https://opt-mainnet.g.alchemy.com/v2/a-QNxg1LGrP9CHYxjS1IWTKF7SttITtp";
    var httpClient = Client();
    var optClient = Web3Client(optUrl, httpClient);
    var optPrice = await optClient.getGasPrice();
    return optPrice.toString();
  }
}
