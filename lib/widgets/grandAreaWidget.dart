import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/colors.dart';
import '../middleware/iconsHomeScreen.dart';
import '../screens/secondScreen.dart';

Widget buildGridItem(String grandArea) {
  final IconData icon = getIconForGrandArea(grandArea);

  return SizedBox(
    width: 160,
    height: 160,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Get.to(() => SecondScreen(grandArea: grandArea), transition: Transition.fadeIn);
        },
        child: Container(
          decoration: BoxDecoration(
            color: palePink,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 48,
                width: 48,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(icon, color: softCream),
                ),
              ),
              SizedBox(height: 8),
              Text(
                grandArea,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
