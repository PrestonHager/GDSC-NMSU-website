import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_app_bar.dart';

class ContactPage extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const ContactPage({super.key, required this.onThemeChanged});

  @override
  _ContactPage createState() => _ContactPage();
}

class _ContactPage extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Contact", widget.onThemeChanged),
      // appBar: AppBar(
      //   title: ClipRRect(
      //     borderRadius: BorderRadius.circular(20.0),
      //     child: Container(
      //       padding: const EdgeInsets.all(16.0),
      //       decoration: BoxDecoration(
      //         color: Colors.white, // background color
      //         border: Border.all(color: const Color.fromARGB(255, 29, 140, 19), width: 8.5),
      //       ),
      //       child: const Text(
      //         'Contact GDSC',
      //         style: TextStyle(
      //           fontSize: 45,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.black,
      //           //decoration: TextDecoration.underline,
      //         ),
      //       ),
      //     ),
      //   ),
      //   toolbarHeight: 200.0,
      //   shadowColor: const Color.fromARGB(255, 255, 255, 255),
      //   backgroundColor: Colors.white,
      // ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //const Expanded(child: BackgroundPicture()),
          const Expanded(
              child: MeetingTimesWidget()), // left column for Meeting Times
          Expanded(
            child: Container(
              color: const Color.fromARGB(
                  255, 255, 255, 255), // background color for middle column
              height: double.infinity,
              child: const CenterColumnWidget(),
            ),
          ),
          const Expanded(child: OfficersWidget()), // right with officers
        ],
      ),
    );
  }
}

// meeting times
class MeetingTimesWidget extends StatelessWidget {
  const MeetingTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionHeader(title: 'Meetings Information'),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 4.0),
                //color: Colors.red,
                borderRadius: BorderRadius.circular(20.0), //
              ),
              child: Column(
                children: [
                  const Text(
                    "Science Hall 118B \n"
                    "Dates on Crimson Connection Page",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse(
                          'https://map.nmsu.edu/?id=1888#!ce/52149?ct/65794?m/525545?s/');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch: $url';
                      }
                    },
                    child: const Text(
                      "Where is the Science Hall?",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}

// column with picture and crimson connection text
class CenterColumnWidget extends StatelessWidget {
  const CenterColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PictureWidget(), // Top section with logo/image
        SizedBox(height: 30.0), // Space between image and text input
        CrimsonConnectionWidget(), // Bottom section with text input
        Spacer(
          flex: 4,
        ),
      ],
    );
  }
}

// logo
class PictureWidget extends StatelessWidget {
  const PictureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // changed from contaienr to material
      elevation: 10.0,
      borderRadius: BorderRadius.circular(20.0),
      shadowColor: Colors.black.withOpacity(0.5),

      //color: const Color.fromARGB(255, 255, 255, 255),
      //padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            20.0), // Adjust the radius for rounded corners
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.blue, width: 10.0), // Set border color and width
            borderRadius: BorderRadius.circular(
                20.0), // Ensure the border radius matches the ClipRRect
          ),
          child: Image.asset(
            '../assets/GSDC.png',
            width: 300, // Adjust the size
            height: 300,
            fit: BoxFit.cover, // Adjust how the image should be displayed
          ),
        ),
      ),
    );
  }
}

// Crimson connection text
class CrimsonConnectionWidget extends StatelessWidget {
  const CrimsonConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0, // added elevation
      borderRadius: BorderRadius.circular(20.0),
      shadowColor: Colors.black.withOpacity(0.5),

      //padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
                18.0), // Adjust the radius for rounded corners
            child: Container(
              padding: const EdgeInsets.all(
                  16.0), // Padding inside the rounded container
              decoration: BoxDecoration(
                color: Colors.white, // Background color for the title
                border: Border.all(
                    color: Colors.blue, width: 7.5), // Border color and width
              ),
              child: GestureDetector(
                onTap: () async {
                  final Uri url = Uri.parse(
                      'https://crimsonconnection.nmsu.edu/organization/gdsc_nmsu');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    throw 'Could not launch: $url';
                  }
                },
                child: const Text(
                  "Check out our Crimson Connection Page",
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center, // Center-align the text
                ),
              ),
            ),
          ),
        ], // children
      ),
    );
  }
}

// officer info
class OfficersWidget extends StatelessWidget {
  const OfficersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionHeader(title: 'Officers'),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 249, 220, 56), width: 4.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      Text(
                        "President: Carson Siegrist ",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.mail,
                        color: Colors.black,
                      ),
                      Text(
                        "csiegr@nmsu.edu ",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // space between different people
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      Text(
                        " Vice President: Rupak Dey",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.mail,
                        color: Colors.black,
                      ),
                      Text(
                        "rupakdey@nmsu.edu ",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // space between different people
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      Text(
                        "Secretary: Allison Barricklow",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.mail,
                        color: Colors.black,
                      ),
                      Text(
                        "aab05@nmsu.edu",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // space between different people
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      Text(
                        "Treasurer: Benjamin Widner III",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.mail,
                        color: Colors.black,
                      ),
                      Text(
                        "bbwidner3@nmsu.edu",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// format headers
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}

class BackgroundPicture extends StatelessWidget {
  const BackgroundPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        child: Image.asset(
          'assets/redCircle.png',
          width: 600,
          height: 900,
        ),
      ),
    );
  }
}
