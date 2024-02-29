
import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/utils/helper.dart';
import 'package:flutter/material.dart';

class grandesAreasWidgets extends StatelessWidget {
  const grandesAreasWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.PlaceholderBg,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Flexible(child: Icon(Icons.bookmark, size: 40,),),
              Flexible(child: Image(
                image: AssetImage(Helper.getAssetName("carroussel3.jpg","images")),
                height: 75,
              )),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            "Maiores Duvidas",
            style: Theme.of(context).textTheme.headlineMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Educação",
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
