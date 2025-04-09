import 'package:flutter/material.dart';
import 'package:flutter_course/data/constants.dart';
import 'package:flutter_course/views/pages/course_page.dart';
import 'package:flutter_course/views/widgets/container_widget.dart';
import 'package:flutter_course/views/widgets/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      KValue.keyConcepts,
      KValue.basicLayout,
      KValue.cleanUi,
      KValue.fixBugs,
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            HeroWidget(title: "Flutter Mapp", nextPage: CoursePage()),
            ...List.generate(list.length, (index) {
              return ContainerWidget(
                title: list.elementAt(index),
                description: "The description of this",
              );
            }),
          ],
        ),
      ),
    );
  }
}
