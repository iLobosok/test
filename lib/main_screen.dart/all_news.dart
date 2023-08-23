import 'package:flutter/material.dart';
import 'package:flutter_application_1/data.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data_news.dart';

class AllNews extends StatefulWidget {
  const AllNews({super.key});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'News',
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: articlesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      News article = articlesList[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsPage(
                                title: articlesList[index].title,
                                descriprtion: articlesList[index].descriprtion,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.7,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 55, 55, 55),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title,
                                    style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    article.descriprtion,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
