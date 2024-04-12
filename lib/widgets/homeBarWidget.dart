import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/screens/profileScreen.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.menu_sharp, color: AppColor.primary,),
      title: Text(
        "Home",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20, 
            vertical: 7
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), 
            color: AppColor.secondary
          ),
          child: IconButton(
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
            }, 
            icon: const Image(
              image: AssetImage("assets/icons/mulheraceno.png",),
            )
          ),
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(55);
}