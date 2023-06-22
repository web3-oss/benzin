// ignore_for_file: prefer_const_constructors

import 'dart:math';
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
  @override
  void initState() {
    _handleRefresh().then((value) {
      log.i('Async done');
    });
    super.initState();
  }

  final log = Logger();
  var ethMap = {};
  var bscMap = {};
  var posMap = {};

  final Key parallaxOne = GlobalKey();
  DateTime nowDate = DateTime.now(); // 30/09/2021 15:54:30

  var isLoaded = false;

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
    ethMap.addAll({
      'name': 'Ethereum',
      'code': 'ETH',
      'iconLogo': 'assets/images/eth.png'
    });
    posMap.addAll({
      'name': 'Polygon',
      'code': 'MATIC',
      'iconLogo': 'assets/images/pos.png'
    });
    bscMap.addAll({
      'name': 'Binance ',
      'code': 'BNB',
      'iconLogo': 'assets/images/bsc.png'
    });
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
                return Container(
                  height: 600.0,
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: res_height * 0.04,
                            ),
                            Row(
                              children: [
                                Icon(Icons.info, color: Colors.black, size: 30),
                                SizedBox(
                                  width: res_width * 0.04,
                                ),
                                Text(
                                  "About Us",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: res_height * 0.04,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Color(0xff763bd7).withOpacity(0.1),
                                      radius: 25,
                                      child: Image.asset(
                                        'assets/images/twitter.png',
                                        width: 25,
                                      ),
                                    ),
                                    Text(
                                      "@DrakeShot10559",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Color(0xffff5580).withOpacity(0.1),
                                      radius: 25,
                                      child: Image.asset(
                                        'assets/images/github.png',
                                        width: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "web3-oss/benzin",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: res_height * 0.04,
                            ),
                            /*Expanded(
                              child: ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TimeWidget(
                                          data: data[index],
                                          active: index == 1,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Divider(color: Colors.grey)
                                      ],
                                    );
                                  }),
                            )*/
                          ],
                        ),
                      )),
                );
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
                  /*Container(
                      width: 70,
                      height: 120,
                      color: Color(0xffff5580),
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),*/
                  child: AnimatedContainer(
                    width: 70,
                    height: showdate ? 130 : 0,
                    color: Color(0xfffc523c),
                    duration: Duration(milliseconds: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.d().format(nowDate),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(DateFormat.MMM().format(nowDate),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
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

            /*
            Positioned(
              right: 0,
              top: res_height * 0.275,
              child: Image.asset(
                'assets/images/girl.png',
                height: res_height * 0.5,
              ),
            ),
            
            Positioned(
              left: 50,
              top: res_height * 0.175,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '19°',
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                  Text(
                    'Current Ethereum Gas Price',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.local_gas_station,
                    color: Colors.white,
                    size: 40,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: res_height * 0.02,
              left: 20,
              child: Text(
                'Gas Price',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),*/
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
/*
var data = [
  {'time': '09:00 AM', 'temp': '19°'},
  {'time': '10:00 AM', 'temp': '20°'},
  {'time': '11:00 AM', 'temp': '21°'},
];*/
