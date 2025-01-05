import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final Icon leadingIcon;
  final void Function()? onTap;

  const DrawerTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon,
      title: Text(
        title,
        style: GoogleFonts.dmSans(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
      onTap: onTap,
    );
  }
}
