import 'package:empoderainformacoes/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      color: palePink,
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logos/logo-unespar.png',
            height: 200.0,
            width: 200.0,
            fit: BoxFit.contain,
          ),
          Flexible(
            child: Text(
              'Designed by: TheSentinel',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.bebasNeue(fontSize: 16, color: Colors.black),
            ),
          ),
          Image.asset(
            'assets/logos/logo-fa.png',
            height: 200.0,
            width: 200.0,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
