import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data.dart';
import 'package:flutter_application_1/main_screen.dart/data_lessons.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
      children: [
        Center(
          child: Text(
            'Lessons',
            style: GoogleFonts.dmSans(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: Center(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: lessonsList.length,
              itemBuilder: (BuildContext context, int index) {
                Lessons article = lessonsList[index];

                return Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DataLessons(
                            title: lessonsList[index].title,
                            descriprtion: lessonsList[index].descriprtion,
                            image: lessonsList[index].image,
                            index: index + 1,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15,left: 15),
                      child: Container(
                        height: 220,
                        width: MediaQuery.of(context).size.width * 0.9,
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
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(article.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
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
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                            ],
                          ),
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
    );
  }
}
