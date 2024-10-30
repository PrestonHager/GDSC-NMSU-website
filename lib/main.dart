import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_html/flutter_html.dart';
import 'all_pages.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(), // Set HomePage as the landing page
//     );
//   }
// }


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GDSC Events',
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(onThemeChanged: (isDarkMode) {
        setState(() {
          _isDarkMode = isDarkMode;
        });
        }),
        '/events': (context) => EventsPage(onThemeChanged: (isDarkMode) {
        setState(() {
          _isDarkMode = isDarkMode;
        });
        }),
        // '/about': (context) => AboutPage();
        //Add other events as such.
      },
    );
  }
}