import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:empoderainformacoes/widgets/grandesAreasWidgets.dart';
import 'package:empoderainformacoes/widgets/pequenasAreasWidget.dart';
import 'package:empoderainformacoes/widgets/recentesWidget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 245, 200, 229),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Ola, como posso ajudar?",
                style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                ),
              ),
              const Text(
                "Explore sua duvida",
                style: TextStyle(
                  color: AppColor.orange,
                  fontSize: 35,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(width: 4,)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Explorar",
                      style: TextStyle(
                        color: AppColor.primary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Icon(Icons.mic, size: 25,)
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const recentesWidget(),
                    const recentesWidget(),
                    const recentesWidget(),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: [
                        const grandesAreasWidgets(),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: (){}, 
                            child: Text(
                              "Veja Tudo",
                              style: Theme.of(context).textTheme.headlineMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ),
                        ),
                        Text(
                          "Pesquisas Recentes",
                          style: Theme.of(context).textTheme.headlineMedium?.apply(fontSizeFactor: 1.2),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const pesquisasRecentesWidget(),
                        const SizedBox(
                          height: 10,
                        ),
                        const pesquisasRecentesWidget(),
                        const SizedBox(
                          height: 10,
                        ),
                        const pesquisasRecentesWidget(),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
