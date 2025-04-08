import 'package:flutter/material.dart';
import 'package:flutter_course/data/notifiers.dart';
import 'package:flutter_course/views/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkThemeNotifier,
      builder: (BuildContext context, bool isDarkTheme, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: isDarkTheme ? Brightness.dark : Brightness.light,
            ),
          ),
          home: WelcomePage(),
        );
      },
    );
  }
}
