import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main_screen.dart/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'calc/calculator.dart';
import 'invest_screens.dart/investments_screen.dart';
import 'lessons_page.dart';
import 'settings/settings.dart';

class MainxScreen extends StatefulWidget {
  const MainxScreen({Key? key}) : super(key: key);

  @override
  State<MainxScreen> createState() => _MainxScreenState();
}

class _MainxScreenState extends State<MainxScreen> {
  @override
  void initState() {
    super.initState();
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId("f2e9780f-5267-476c-927c-b42d052a0779");
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
  }

  int _selectedTab = 0;

  static const List<Widget> tabs = [
    MainScreen(),
    InvestmentCalculatorScreen(),
    LessonsPage(),
    Investment(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: SafeArea(
        child: tabs[_selectedTab],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (value) {
          setState(() {
            _selectedTab = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 29, 29, 29),
        elevation: 0,
        selectedItemColor: const Color.fromARGB(255, 202, 247, 23),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.dmSans(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.dmSans(
          fontWeight: FontWeight.w500,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
            ),
            label: "Main",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.circle_grid_3x3,
            ),
            label: "Calculator",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.book,
            ),
            label: "Lessons",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.briefcase,
            ),
            label: "My assets",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.settings,
            ),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
