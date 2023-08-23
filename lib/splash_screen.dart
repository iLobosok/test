import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'mainx.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _controller = PageController();

  final List<Widget> _pages = [
    Column(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            width: double.infinity,
            child: Image.asset(
              "assets/images/1x.png",
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Main page",
                  style: GoogleFonts.dmSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "On Main Page you can read news, check currencies, check your balance",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    Column(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            width: double.infinity,
            child: Image.asset(
              "assets/images/2x.png",
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Calculator Page",
                  style: GoogleFonts.dmSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "On Calculator Page you can calculate and check your profit/income per month",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    Column(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            width: double.infinity,
            child: Image.asset(
              "assets/images/3x.png",
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Investments Page",
                  style: GoogleFonts.dmSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "On Investments Page you can write all your assets, to check daily profit and top up balance on Main Page",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    Column(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            width: double.infinity,
            child: Image.asset(
              "assets/images/4x.png",
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Lessons",
                  style: GoogleFonts.dmSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "On Lessons Page you can read daily lessons, explore and learn! Welcome",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              controller: _controller,
              children: _pages,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                onDotClicked: (index) {
                  _controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                controller: _controller,
                count: 4,
                effect: const WormEffect(
                  activeDotColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _currentPage == 3
          ? FloatingActionButton.extended(
              backgroundColor: Color.fromARGB(255, 27, 141, 95),
              onPressed: () {
                RxSharedPreferences.getInstance().setBool("isAuthed", true);
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => const MainxScreen(),
                  ),
                  (route) => false,
                );
              },
              label: Row(
                children: [
                  Text(
                    "Explore",
                    style: GoogleFonts.dmSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            )
          : null,
    );
  }
}
