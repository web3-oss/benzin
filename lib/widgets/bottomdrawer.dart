import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomDrawerWidget extends StatelessWidget {
  BottomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return Container(
      height: 600.0,
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0))),
          child: SingleChildScrollView(
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
                      "Information",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: res_height * 0.04,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                        text: TextSpan(
                      text:
                          '''A fee denominated in small fractions of ETH required to conduct a transaction on the open-source Ethereum blockchain.\n\nThe Ethereum gas fee exists to pay network validators for their work securing the blockchain and network \n\nEth gas = gas units(limit) x (base fee + tip or priority fee)\n\nThe ether gas limit refers to the maximum amount of gas a user can consume to conduct a transaction.The standard limit on an Ethereum gas fee is 21,000 units. \n\nBase fee acts as a reservation price to include transaction in the block. When the block is mined the base fee is ‘burned’, removing it from circulation. \n\nBase fee (max) for next block= Base fee (current) * 12.5% \n\nWith every block the base fee getting burned, a priority fee (tip) introduced via EIP-1559 to incentivize miners for including a transaction in the block.\n''',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16),
                    ))),
                SizedBox(
                    height: res_height * 0.04,
                    child: Center(child: Text('Get in touch with us:'))),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: webUrlLaunch,
                        child:
                            Icon(Icons.language, color: Colors.black, size: 30),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.white70, // <-- Button color
                        ),
                      ),
                      ElevatedButton(
                        onPressed: mailUrlLaunch,
                        child: Icon(Icons.email, color: Colors.black, size: 30),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.white70, // <-- Button color
                        ),
                      ),
                      ElevatedButton(
                        onPressed: GithubUrlLaunch,
                        child: Image.asset(
                          'assets/images/github.png',
                          width: 30,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.white70, // <-- Button color
                        ),
                      ),
                    ]),
                SizedBox(
                  height: res_height * 0.04,
                ),
              ],
            ),
          ))),
    );
  }

  final Uri _mailtourl = Uri.parse('mailto:drakeshot10559@gmail.com');
  final Uri _weburl = Uri.parse('https://web3-oss.github.io');
  final Uri _githuburl = Uri.parse('https://github.com/web3-oss/benzin');

  mailUrlLaunch() async {
    if (!await launchUrl(_mailtourl)) {
      throw Exception('Could not launch $_mailtourl');
    }
  }

  webUrlLaunch() async {
    if (!await launchUrl(_weburl)) {
      throw Exception('Could not launch $_weburl');
    }
  }

  GithubUrlLaunch() async {
    if (!await launchUrl(_githuburl)) {
      throw Exception('Could not launch $_githuburl');
    }
  }
}
