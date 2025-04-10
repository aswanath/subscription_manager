import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralScreen extends StatelessWidget {
  const GeneralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "General",
        style: GoogleFonts.redHatDisplay(color: Colors.white),
      ),
    );
  }
}
