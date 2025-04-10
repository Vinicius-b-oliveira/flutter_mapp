import 'package:flutter/material.dart';
import 'package:flutter_course/data/notifiers.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({required this.title, this.nextPage, super.key});

  final String title;
  final Widget? nextPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          nextPage != null
              ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => nextPage!),
                );
              }
              : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: 'hero1',
            child: AspectRatio(
              aspectRatio: 1920 / 1080,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: ValueListenableBuilder(
                  valueListenable: isDarkThemeNotifier,
                  builder: (
                    BuildContext context,
                    bool isDarkTheme,
                    Widget? child,
                  ) {
                    return Image.asset(
                      'assets/images/welcome.jpg',
                      color: Colors.teal,
                      colorBlendMode:
                          isDarkTheme ? BlendMode.darken : BlendMode.hardLight,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),
          FittedBox(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 50.0,
                letterSpacing: 50.0,
                color: Colors.white60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
