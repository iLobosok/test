import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

import 'dialog.dart';

class Investment extends StatefulWidget {
  const Investment({super.key});

  @override
  State<Investment> createState() => _InvestmentState();
}

final rxPrefs = RxSharedPreferences.getInstance();

class _InvestmentState extends State<Investment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Investments',
              style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, top: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Add',
                      style: GoogleFonts.dmSans(color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CustomDialogWidget()));
                      },
                      child: const Icon(
                        CupertinoIcons.add_circled,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CupertinoActivityIndicator(
                    color: Colors.white,
                  ));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'Empty data',
                      style:
                          GoogleFonts.dmSans(color: Colors.grey, fontSize: 20),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkWell(
                            onTap: () {},
                            
                            child: Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width * .9,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 48, 48, 48),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    snapshot.data![index]['name'],
                                    style: GoogleFonts.dmSans(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$${snapshot.data![index]['price']}',
                                        style: GoogleFonts.dmSans(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${snapshot.data![index]['text']}%',
                                        style: GoogleFonts.dmSans(
                                          color: const Color.fromARGB(
                                              255, 1, 127, 7),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              // title: Text(snapshot.data![index]['name']),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final rxPrefs = await RxSharedPreferences.getInstance();
    final assetListJson = (await rxPrefs.getStringList('assets')) ?? [];
    final assetDataList = assetListJson.map((assetJson) {
      final assetDataMap = json.decode(assetJson) as Map<String, dynamic>;
      return assetDataMap;
    }).toList();
    return assetDataList;
  }
}
