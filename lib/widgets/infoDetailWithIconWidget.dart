import 'package:empoderainformacoes/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoDetailWithIconWidget extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final VoidCallback onTap;

  const InfoDetailWithIconWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.libreBaskerville(
                color: Colors.black, 
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Text(
            content,
            style: GoogleFonts.libreBaskerville(
              color: softOrange, 
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}