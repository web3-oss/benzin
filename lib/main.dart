// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:benzin/widgets/bottomdrawer.dart';
import 'package:benzin/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:benzin/services/web3client.dart';
import 'package:benzin/widgets/rain.dart';
import 'dart:math' as math;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:web3dart/web3dart.dart';
import 'package:benzin/services/currconverter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor mycolor = MaterialColor(
      0xDD000000,
      <int, Color>{
        50: Colors.black87,
        100: Colors.black87,
        200: Colors.black87,
        300: Colors.black87,
        400: Colors.black87,
        500: Colors.black87,
        600: Colors.black87,
        700: Colors.black87,
        800: Colors.black87,
        900: Colors.black87,
      },
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Benzin',
      theme: ThemeData(primarySwatch: mycolor),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isLoaded = false;

  @override
  void initState() {
    ethMap.addAll({
      'name': 'Ethereum',
      'code': 'ETH',
      'iconLogo': 'assets/images/eth.png',
      'gweiValue': '30',
      'ethValue': '',
      'usdValue': '0.5'
    });
    posMap.addAll({
      'name': 'Polygon',
      'code': 'MATIC',
      'iconLogo': 'assets/images/pos.png',
      'gweiValue': '200',
      'ethValue': '',
      'usdValue': '0.0025'
    });
    bscMap.addAll({
      'name': 'Binance ',
      'code': 'BNB',
      'iconLogo': 'assets/images/bsc.png',
      'gweiValue': '3',
      'ethValue': '',
      'usdValue': '0.015'
    });
    _handleRefresh().then((value) {
      log.i('Async done');
      setState(() {
        isLoaded = true;
      });
    });
    super.initState();
  }

  final log = Logger();
  var ethMap = {};
  var bscMap = {};
  var posMap = {};

  final Key parallaxOne = GlobalKey();
  DateTime nowDate = DateTime.now(); // 30/09/2021 15:54:30

  Future _handleRefresh() async {
    EtherAmount responseEth = await Web3RemoteCall().getEthCall();
    EtherAmount responsePos = await Web3RemoteCall().getPosCall();
    var responseBsc = await Web3RemoteCall().postBscCall();

    var usdEthValue = await ConverterApi().getUsdEth();
    var usdBnbValue = await ConverterApi().getUsdBnb();
    var usdPosValue = await ConverterApi().getUsdPos();

    if (responseEth != 'Error') {
      setState(() {
        isLoaded = true;
        ethMap["gweiValue"] = responseEth.getValueInUnitBI(EtherUnit.gwei);
        ethMap["ethValue"] = ethMap["gweiValue"].toInt() * pow(10, -9);
        ethMap["usdValue"] =
            (ethMap["ethValue"] * usdEthValue * 21000).toStringAsFixed(3);

        log.i(ethMap);
      });
    }

    if (responsePos != 'Error') {
      setState(() {
        isLoaded = true;
        posMap["gweiValue"] = responsePos.getValueInUnitBI(EtherUnit.gwei);
        posMap["ethValue"] = posMap["gweiValue"].toInt() * pow(10, -9);
        posMap["usdValue"] =
            (posMap["ethValue"] * usdPosValue * 21000).toStringAsFixed(4);
        log.i(posMap);
      });

      if (responseBsc["result"] != 'Error') {
        setState(() {
          isLoaded = true;
          bscMap["gweiValue"] = int.parse(responseBsc["result"]) * pow(10, -9);
          bscMap["ethValue"] = bscMap["gweiValue"] * pow(10, -9);
          bscMap["usdValue"] =
              (bscMap["ethValue"] * usdBnbValue * 21000).toStringAsFixed(4);
          log.i(bscMap);
        });
      }
    }
  }

  bool showdate = true;

  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          setState(() {
            showdate = false;
          });
          showModalBottomSheet(
              context: context,
              elevation: 0,
              barrierColor: Colors.black.withAlpha(1),
              backgroundColor: Colors.transparent,
              builder: (builder) {
                return BottomDrawerWidget();
              }).whenComplete(() {
            setState(() {
              showdate = true;
            });
          });
        },
        child: Container(
          //add ClipRRect widget for Round Corner
          color: Colors.black87,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 13, right: 13, top: 13, bottom: 26),
                child: ListTile(
                    leading: SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child:
                            Icon(Icons.info, color: Colors.black38, size: 30)),
                    title: Text(
                      'Info',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: res_height * 1,
        color: Colors.black87,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 600),
              height: showdate ? res_height * 0.15 : res_height * 0.125,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50))),
              child: Padding(
                padding: EdgeInsets.only(top: res_height * 0.06, left: 20),
                child: Row(
                  children: [
                    SizedBox(
                        height: 35.0,
                        width: 33.0,
                        child: Image.asset('assets/images/logo.png')),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'BENZIN',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50)),
                child: Center(
                  child: AnimatedContainer(
                    width: 70,
                    height: showdate ? 130 : 0,
                    color: Color(0xfffc523c),
                    duration: Duration(milliseconds: 400),
                    alignment: Alignment.center,
                    child: Text(
                        '\n ' +
                            DateFormat.d().format(nowDate) +
                            '\n' +
                            DateFormat.MMM().format(nowDate),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: res_height * 1,
                child: ParallaxRain(
                  key: parallaxOne,
                  dropColors: [
                    Colors.white,
                  ],
                  trail: true,
                ),
              ),
            ),
            Positioned(
                top: 130,
                width: res_width * 1,
                child: SizedBox(
                  height: 800,
                  child: LiquidPullToRefresh(
                    animSpeedFactor: 3,
                    showChildOpacityTransition: false,
                    onRefresh: _handleRefresh,
                    child: ListView(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: 150,
                                  color: Colors.white,
                                  child: Card(
                                      elevation: 25,
                                      child: CardWidget(dataMap: ethMap)),
                                ))),
                        Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: 150,
                                  color: Colors.white,
                                  child: Card(
                                      elevation: 25,
                                      child: CardWidget(dataMap: bscMap)),
                                ))),
                        Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: 150,
                                  color: Colors.white,
                                  child: Card(
                                      elevation: 25,
                                      child: CardWidget(dataMap: posMap)),
                                ))),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
