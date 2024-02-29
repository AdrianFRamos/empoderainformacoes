
import 'package:empoderainformacoes/const/colors.dart';
import 'package:flutter/material.dart';

class recentesWidget extends StatelessWidget {
  const recentesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 50,
      child: Row(
        children: <Widget>[
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), 
              color: AppColor.primary
            ),
            child: const Center(
              child: Text(
                "AP",
                style: TextStyle(
                  color: AppColor.secondary,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Aposentadoria",
                  style: TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                Text(
                  "Nosce Ipsum dolor",
                  style: TextStyle(
                    color: AppColor.primary,
                    overflow: TextOverflow.ellipsis
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
