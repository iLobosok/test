import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutxApp extends StatefulWidget {
  const AboutxApp({super.key});

  @override
  State<AboutxApp> createState() => AboutApp();
}

class AboutApp extends State<AboutxApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            width: MediaQuery.of(context).size.width * .9,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: Text(
                          'About App',
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Introducing our app - your all-in-one solution for financial management. \n\nWith this app, you can create your own custom assets, track prices in real-time, calculate costs accurately, and stay informed with the latest news.\n\n Whether you\'re a savvy investor or simply looking to stay on top of your finances, our app provides you with the tools you need to make informed decisions. Take control of your financial future today.',
                    style:
                        GoogleFonts.dmSans(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
