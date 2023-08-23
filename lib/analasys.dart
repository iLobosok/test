import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

import 'enum.dart';

class AnalysisDetailsPage extends StatefulWidget {
  final ForexPairsEnum forexPair;
  const AnalysisDetailsPage({
    Key? key,
    required this.forexPair,
  }) : super(key: key);

  @override
  State<AnalysisDetailsPage> createState() => _AnalysisDetailsPageState();
}

class _AnalysisDetailsPageState extends State<AnalysisDetailsPage> {
  double ix = 0;
  bool isButtonEnabled = true;
  int countdown = 30;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    calculateTotalSum();
  }

  void startCountdown() {
    isButtonEnabled = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
      });
      if (countdown <= 0) {
        timer.cancel();
        isButtonEnabled = true;
        countdown = 30;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<String> calculateTotalSum() async {
    final rxPrefs = await RxSharedPreferences.getInstance();
    final assetListJson = (await rxPrefs.getStringList('assets')) ?? [];
    final assetDataList = assetListJson.map((assetJson) {
      final assetDataMap = json.decode(assetJson) as Map<String, dynamic>;
      return assetDataMap['price'] as String;
    }).toList();
    double totalSum = 0.0;
    for (final price in assetDataList) {
      totalSum += double.tryParse(price) ?? 0.0;
      setState(() {
        ix = totalSum;
      });
    }
    return totalSum.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 28, 28),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.forexPair.name,
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFFFFFF).withOpacity(1),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).width,
            width: MediaQuery.sizeOf(context).width,
            child: InAppWebView(
              initialData: InAppWebViewInitialData(
                  data: """<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div id="tradingview_e8211"></div>
  <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">Track all markets on TradingView</span></a></div>
  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
  <script type="text/javascript">
  new TradingView.widget(
  {
  "autosize": true,
  "symbol": "FX:${widget.forexPair.name}",
  "interval": "D",
  "timezone": "Etc/UTC",
  "theme": "dark",
  "style": "1",
  "locale": "en",
  "enable_publishing": false,
  "allow_symbol_change": true,
  "container_id": "tradingview_e8211"
}
  );
  </script>
</div>
<!-- TradingView Widget END -->"""),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            'Simulator Trading',
            style: GoogleFonts.dmSans(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
          )),
          const SizedBox(
            height: 10,
          ),
          isButtonEnabled == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timelapse,
                      color: Color.fromARGB(255, 76, 86, 94),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      countdown.toString(),
                      style: TextStyle(
                        color: Color.fromARGB(255, 76, 86, 94),
                      ),
                    )
                  ],
                )
              : const SizedBox(),
          isButtonEnabled == false
              ? const SizedBox(
                  height: 30,
                )
              : const SizedBox(),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 46, 42, 53),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 38, 38, 38),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        '${ix.toString()}\$',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: isButtonEnabled
                            ? () {
                                startCountdown();

                                Random random = Random();
                                int randomNumber = random.nextInt(2) + 1;
                                setState(() {
                                  if (randomNumber == 2) {
                                    ix -= 100;
                                  } else {
                                    ix += 100;
                                  }
                                });
                              }
                            : null,
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 129, 30, 23),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'SELL',
                              style: GoogleFonts.dmSans(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: isButtonEnabled
                            ? () {
                                startCountdown();

                                Random random = Random();
                                int randomNumber = random.nextInt(2) + 1;
                                setState(() {
                                  if (randomNumber == 2) {
                                    ix -= 100;
                                  } else {
                                    ix += 100;
                                  }
                                });
                              }
                            : null,
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 5, 125, 33),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'BUY',
                              style: GoogleFonts.dmSans(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
