import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoDetailWidget extends StatelessWidget {
  final String title;
  final String content;

  const InfoDetailWidget({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.libreBaskerville(
            fontWeight: FontWeight.bold,
            color: Colors.black, 
            fontSize: 18,
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: GoogleFonts.libreBaskerville(
            color: Colors.black, 
            fontSize: 18,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}