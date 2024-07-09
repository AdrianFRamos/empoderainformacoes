import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.notifications, color: AppColor.primary, size: 40,),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/icons/mulheraceno.png'),
          ),
          SizedBox(width: 8),
          Text(
            'E-MPODERA',
            style: GoogleFonts.bebasNeue(
              fontSize: 40
            ),
          ),
        ],
      ),
      backgroundColor: palePink,
      centerTitle: true,
      actions: <Widget>[
        Container(
          child: IconButton(
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
            }, 
            icon: Icon(
              Icons.menu,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(55);
}