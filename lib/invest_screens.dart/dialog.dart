import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/invest_screens.dart/investments_screen.dart';
import 'package:flutter_application_1/mainx.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class CustomDialogWidget extends StatefulWidget {
  const CustomDialogWidget({super.key});

  @override
  State<CustomDialogWidget> createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  late TextEditingController nameText;
  late TextEditingController priceText;
  late TextEditingController percentText;
  final AssetStorage _assetStorage = AssetStorage();
  String userage = '';
  @override
  void initState() {
    super.initState();
    nameText = TextEditingController();
    priceText = TextEditingController();
    percentText = TextEditingController();
  }

  @override
  void dispose() {
    nameText.dispose();
    priceText.dispose();
    percentText.dispose();
    super.dispose();
  }
 void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(message, style: TextStyle(color: Colors.white),));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Investment(),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 30.0,
            right: 30.0,
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              child: Card(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 60, 60, 60),
                        Color.fromARGB(255, 42, 42, 43),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Add assets',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width * .6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: const Color(0xFF2A2731),
                          border: Border.all(
                            color: Color.fromARGB(255, 34, 95, 70),
                            width: 1.5,
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, top: 10),
                            child: TextField(
                              cursorColor: Colors.white,
                              controller: nameText,
                              style: const TextStyle(color: Colors.white),
                              onSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Asset name",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(147, 178, 177, 177)),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width * .6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: const Color(0xFF2A2731),
                          border: Border.all(
                            color: Color.fromARGB(255, 34, 95, 70),
                            width: 1.5,
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, top: 10),
                            child: TextField(
                              cursorColor: Colors.white,
                              controller: priceText,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: const TextStyle(color: Colors.white),
                              onSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Price",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(147, 178, 177, 177)),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width * .6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: const Color(0xFF2A2731),
                          border: Border.all(
                            color: Color.fromARGB(255, 34, 95, 70),
                            width: 1.5,
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, top: 10),
                            child: TextField(
                              cursorColor: Colors.white,
                              controller: percentText,
                              style: const TextStyle(color: Colors.white),
                              onSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Percent",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(147, 178, 177, 177)),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () async {
                          if (nameText.text != '' && priceText.text != '' && percentText.text != '') {
                          AssetData newAsset = AssetData(
                              name: nameText.text,
                              price: priceText.text,
                              text: percentText.text);
                          List<AssetData> currentAssets =
                              await _assetStorage.loadAssets();
                          currentAssets.add(newAsset);
                          await _assetStorage.saveAssets(currentAssets);
                          Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => const MainxScreen(),
                        ),
                        (route) => false,
                      );
                          }
                          else {
                             showSnackBar(context, 'Empty fields');
                          }
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * .65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 34, 95, 70),
                                Color.fromARGB(255, 5, 144, 127),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AssetData {
  final String name;
  final String price;
  final String text;

  AssetData({required this.name, required this.price, required this.text});
}

class AssetStorage {
  Future<void> saveAssets(List<AssetData> assets) async {
    final rxPrefs = await RxSharedPreferences.getInstance();
    final assetListJson = assets.map((asset) {
      final assetDataMap = {
        'name': asset.name,
        'price': asset.price.toString(), // Convert price to string
        'text': asset.text,
      };
      return json.encode(assetDataMap); // Encode the map as JSON string
    }).toList();
    await rxPrefs.setStringList('assets', assetListJson);
  }

  Future<List<AssetData>> loadAssets() async {
    final rxPrefs = await RxSharedPreferences.getInstance();
    final assetListJson = await rxPrefs.getStringList('assets') ?? [];
    return assetListJson.map((assetJson) {
      final Map<String, dynamic> assetDataMap =
          Map<String, dynamic>.from(json.decode(assetJson));
      return AssetData(
        name: assetDataMap['name'] as String,
        price: assetDataMap['price'] as String,
        text: assetDataMap['text'] as String,
      );
    }).toList();
  }
}
