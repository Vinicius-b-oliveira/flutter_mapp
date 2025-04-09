import 'package:flutter/material.dart';
import 'package:flutter_course/data/constants.dart';
import 'package:flutter_course/data/notifiers.dart';
import 'package:flutter_course/views/pages/home_page.dart';
import 'package:flutter_course/views/pages/profile_page.dart';
import 'package:flutter_course/views/pages/settings_page.dart';
import 'package:flutter_course/views/widgets/navbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Widget> pages = [HomePage(), ProfilePage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Mapp"),
        actions: [
          IconButton(
            onPressed: () async {
              isDarkThemeNotifier.value = !isDarkThemeNotifier.value;
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              await prefs.setBool(
                KConstants.themeModeKey,
                isDarkThemeNotifier.value,
              );
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkThemeNotifier,
              builder: (BuildContext context, bool isDarkTheme, Widget? child) {
                return Icon(isDarkTheme ? Icons.light_mode : Icons.dark_mode);
              },
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(title: "Settings"),
                ),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (BuildContext context, int selectedPage, Widget? child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
