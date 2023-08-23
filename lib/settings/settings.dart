import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

import 'about_app.dart';

final RxSharedPreferences prefs = RxSharedPreferences.getInstance();

void _clearAllPreferences() {
  prefs.clear();
}

void _showConfirmationDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: true, // Allow tapping outside to dismiss the dialog
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.pop(context, false); // Dismiss dialog when tapping outside
        },
        child: CupertinoAlertDialog(
          title: const Text('Reset data?'),
          content: const Text('Do you want to reset data?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'Reset',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    },
  ).then((value) {
    if (value == true) {
      _clearAllPreferences();
    }
  });
}

final InAppReview inAppReview = InAppReview.instance;

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Settings',
          style: GoogleFonts.dmSans(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutxApp()));
          },
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 54, 54, 54),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Text(
              "About app",
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFFFFFF).withOpacity(1),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            inAppReview.openStoreListing(appStoreId: '6462711286');
          },
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 54, 54, 54),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Text(
              "Rate app",
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFFFFFF).withOpacity(1),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReadAboutPrivacyPolicy(),
              ),
            );
          },
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 54, 54, 54),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Text(
              "Privacy Policy",
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFFFFFF).withOpacity(1),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReadAboutPrivacyPolicy2(),
              ),
            );
          },
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 54, 54, 54),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Text(
              "Terms & Conditions",
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFFFFFF).withOpacity(1),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            _showConfirmationDialog(context);
          },
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 200, 11, 11),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Reset Data",
                    style: GoogleFonts.dmSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFFFFF).withOpacity(1),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.restore_from_trash,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReadAboutPrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 39, 39),
        title: const Text('Privacy Policy'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
              'https://docs.google.com/document/d/1ZGX4chod1Co4l3ALWpl07EtT-sc6EvBeeWG4D1qBxY4/edit?usp=sharing'),
        ),
      ),
    );
  }
}

class ReadAboutPrivacyPolicy2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 39, 39),
        title: const Text('Terms & Conditions'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
              'https://docs.google.com/document/d/1IKefAJ4WYvKjQMaeuKEzUKtwxFMsml6BK-3y9Cr5aG4/edit?usp=sharing'),
        ),
      ),
    );
  }
}
