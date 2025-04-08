import 'package:flutter/material.dart';
import 'package:flutter_course/data/notifiers.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero1',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: ValueListenableBuilder(
          valueListenable: isDarkThemeNotifier,
          builder: (BuildContext context, bool isDarkTheme, Widget? child) {
            return Image.asset(
              'assets/images/welcome.jpg',
              color: Colors.teal,
              colorBlendMode:
                  isDarkTheme ? BlendMode.darken : BlendMode.lighten,
            );
          },
        ),
      ),
    );
  }
}
