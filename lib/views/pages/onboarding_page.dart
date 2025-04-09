import 'package:flutter/material.dart';
import 'package:flutter_course/data/constants.dart';
import 'package:flutter_course/views/pages/register_page.dart';
import 'package:flutter_course/views/widgets/hero_widget.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              spacing: 20.0,
              children: [
                HeroWidget(title: "Onboarding"),

                Text(
                  "Flutter Mapp is the way to learn Flutter, period",
                  style: KTextStyle.descriptionText,
                  textAlign: TextAlign.center,
                ),

                FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: Size(double.infinity, 40.0),
                  ),
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
