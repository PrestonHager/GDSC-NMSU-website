import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(BuildContext context, String title, ValueChanged<bool> onThemeChanged) {
  return AppBar(
    title:  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5.0), // Add padding above the title
          child: Text(
            title,
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
                Navigator.pushNamed(context, '/'); // Navigate to Events page
              },
              child: Text(
                'Home',
                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,), // Ensure text is visible
              ),
            ), 
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/events'); // Navigate to Events page
              },
              child: Text(
                'Events',
                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/members'); // Navigate to About page
              },
              child: Text(
                'Members',
                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,),
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