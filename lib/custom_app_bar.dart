import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(BuildContext context, String title, ValueChanged<bool> onThemeChanged) {
  return AppBar(
    toolbarHeight: 130.0,
    automaticallyImplyLeading: false,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 10.0), // Add bottom padding to create margin
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
            ),
          ),
        ),

        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name != '/') {
                  Navigator.pushNamed(context, '/'); // Navigate to Home page
                }
              },
              child: Text(
                'Home',
                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name != '/events') {
                  Navigator.pushNamed(context, '/events'); // Navigate to Events page
                }
              },
              child: Text(
                'Events',
                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name != '/members') {
                  Navigator.pushNamed(context, '/members'); // Navigate to Members page
                }
              },
              child: Text(
                'Members',
                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name != '/contact') {
                  Navigator.pushNamed(context, '/contact'); // Navigate to Contact page
                }
              },
              child: Text(
                'Contact',
                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
              ),
            ),
          ],
        ),
      ],
    ),
    actions: [
      Switch(
        value: Theme.of(context).brightness == Brightness.dark,
        onChanged: (value) {
          onThemeChanged(value);
        },
      ),
    ],
  );
}
