import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data.dart';
import 'package:flutter_application_1/main_screen.dart/all_news.dart';
import 'package:flutter_application_1/main_screen.dart/data_news.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

import '../analasys.dart';
import '../enum.dart';
import 'lesson.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
    }
    return totalSum.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    String formattedTime =
        DateFormat.Hm().format(currentTime); // Format hours:minutes

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: ListView(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Main',
                    style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .08,
                      width: MediaQuery.of(context).size.width * .6,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 36, 86, 65),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(left: 18),
                              child: Text(
                                'Balance',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 165, 165, 165)),
                              )),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              const Icon(
                                CupertinoIcons.money_dollar,
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(
                                width: 1,
                              ),
                              FutureBuilder<String>(
                                future: calculateTotalSum(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text(
                                      '0.00',
                                      style: GoogleFonts.dmSans(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    );
                                  } else {
                                    return Text(
                                      snapshot.data ?? '0.00',
                                      style: GoogleFonts.dmSans(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    );
                                  }
                                },
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          title: const Text('About Bank'),
                                          content: const Column(
                                            children: [
                                              Text(
                                                'This is a simulator that allows you to track your assets, income, and visually demonstrate how you can manage your assets and monitor statistics.',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                          actions: [
                                            CupertinoDialogAction(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Icon(
                                  CupertinoIcons.question_circle,
                                  color: Color.fromARGB(255, 99, 98, 98),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .08,
                      width: MediaQuery.of(context).size.width * .32,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 67, 71, 109),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          formattedTime,
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Daily Article',
                        style: GoogleFonts.dmSans(color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllNews()),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Read All',
                            style: TextStyle(
                                color: Color.fromARGB(255, 69, 150, 89)),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Icon(Icons.arrow_right_outlined,
                              color: Color.fromARGB(255, 69, 150, 89))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            Random random = Random();
                            int randomIndex =
                                random.nextInt(articlesList.length - 1);
                            News article = articlesList[randomIndex];

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsPage(
                                      title: articlesList[randomIndex].title,
                                      descriprtion: articlesList[randomIndex]
                                          .descriprtion,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                margin: const EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 55, 55, 55),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title,
                                        style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        article.descriprtion,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Need help?',
                        style: GoogleFonts.dmSans(color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LessonOnBoarding(),
                      ),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .09,
                    width: MediaQuery.of(context).size.width * .92,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 50, 50, 50),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'View lesson',
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.layers,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                // Center(
                //   child: Container(
                //     height: MediaQuery.of(context).size.height * .08,
                //     width: MediaQuery.of(context).size.width * .7,
                //     decoration: BoxDecoration(
                //         color: Color.fromARGB(255, 43, 51, 67),
                //         borderRadius: BorderRadius.circular(20)),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Text(
                //           'Exchange Rates',
                //           style: GoogleFonts.dmSans(
                //             color: Colors.white,
                //             fontWeight: FontWeight.w700,
                //             fontSize: 20,
                //           ),
                //         ),
                //         const SizedBox(
                //           width: 10,
                //         ),
                //         const Icon(
                //           Icons.percent_outlined,
                //           color: Colors.white,
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Assets for view:',
                        style: GoogleFonts.dmSans(color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      List<ForexPairsEnum> listOfPairs =
                          List.from(ForexPairsEnum.values);
                      listOfPairs.shuffle();
                      return Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AnalysisDetailsPage(
                                  forexPair: listOfPairs[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 42, 42, 43),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 35,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          height: 18,
                                          width: 18,
                                          decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                          ),
                                          child: SvgPicture.network(
                                            "https://s3-symbol-logo.tradingview.com/country/${listOfPairs[index].name[3]}${listOfPairs[index].name[4]}.svg",
                                          ),
                                        ),
                                      ),
                                      Container(
                                        clipBehavior: Clip.hardEdge,
                                        height: 18,
                                        width: 18,
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                        child: SvgPicture.network(
                                          "https://s3-symbol-logo.tradingview.com/country/${listOfPairs[index].name[0]}${listOfPairs[index].name[1]}.svg",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  listOfPairs[index].name,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        const Color(0xFFFFFFFF).withOpacity(1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 16);
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
