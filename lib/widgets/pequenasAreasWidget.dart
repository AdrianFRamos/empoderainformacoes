
import 'package:empoderainformacoes/const/colors.dart';
import 'package:flutter/material.dart';

class pesquisasRecentesWidget extends StatelessWidget {
  const pesquisasRecentesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 70,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.PlaceholderBg
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    "Acessado Recente",
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                  onPressed: (){}, 
                  child: const Icon(Icons.play_arrow, color: AppColor.secondary,)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

