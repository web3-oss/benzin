import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  var dataMap;

  CardWidget({super.key, this.dataMap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: Stack(children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: Stack(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          cryptoIcon(),
                          SizedBox(
                            height: 15,
                          ),
                          cryptoNameSymbol(),
                          Spacer(),
                          cryptoChange(),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[cryptoAmount()],
                      )
                    ],
                  ))
            ],
          ),
        )
      ]),
    );
  }

  Widget cryptoIcon() {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            dataMap["iconLogo"],
            width: 25,
            color: Colors.black87,
          ),
          /*Icon(
            CryptoFontIcons.ETH,
            color: Colors.black,
            size: 40,
          )),*/
        ));
  }

  Widget cryptoNameSymbol() {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: ' ' + dataMap["name"],
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22),
          children: <TextSpan>[
            TextSpan(
                text: '\n ' + dataMap["code"],
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget cryptoChange() {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text: '\$' + dataMap["usdValue"],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xfffc3d2c),
              fontSize: 24),
        ),
      ),
    );
  }

  Widget cryptoAmount() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: '\n ' + dataMap["gweiValue"].toString() + ' Gwei',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
