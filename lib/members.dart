import 'package:flutter/material.dart';
import 'member.dart';
import 'custom_app_bar.dart';

class MembersPage extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const MembersPage({super.key, required this.onThemeChanged});

  @override
  _MembersPage createState() => _MembersPage();
}

class _MembersPage extends State<MembersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Club Members", widget.onThemeChanged),
      body: ListView(
        //Link to each member, right now they're hardcoded
        //Later we can retrieve these pages from a database
        //If someone wants to make a custom page that doesn't follow the member.dart format, 
        //They can override their redirect here with whatever custom page they made
        //MemberArguments ("name", "link_to_resume", "Link_to_projects", "link_to_cool_image")
        children: [
          ListTile(
            title: const Text('Carson Siegrist'),
            onTap: () {
              Navigator.pushNamed(context, '/profile',
                  arguments: MemberArguments('Carson Siegrist', 'https://drive.google.com/file/d/1x6i8-VhWIrD3V9iWVBYQgzBO49eJsDSP/view?usp=sharing', 'https://github.com/carsonSiegrist?tab=repositories', 'https://i.imgur.com/cUD8kui.jpeg'));
            },
          ),
          ListTile(
            title: const Text('Jane Smith'),
            onTap: () {
              Navigator.pushNamed(context, '/profile',
                  arguments: MemberArguments('Jane Smith', 'https://pastebin.com/TRyxJNFD', 'https://github.com/torvalds', 'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U'));
            },
          ),
          // Add more members similarly
        ],
      ),
    );
  }
}
