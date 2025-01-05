import 'package:flutter/material.dart';
import 'package:minimal_notes_app/components/drawer_tile.dart';
import 'package:minimal_notes_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(Icons.note),
            ),
            DrawerTile(
              title: "Notes",
              leadingIcon: Icon(
                Icons.home,
                color: Colors.blueGrey,
              ),
              onTap: () => Navigator.pop(context),
            ),
            DrawerTile(
              title: "Settings",
              leadingIcon: Icon(
                Icons.settings,
                color: Colors.blueGrey,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
