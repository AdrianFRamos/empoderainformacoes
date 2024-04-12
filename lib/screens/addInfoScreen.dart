import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddInfoScreen extends StatelessWidget {
  const AddInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(showBackArrow: true, title: Text('Adicione uma nova informação')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            child: Column(
              children: <Widget>[
                
              ],
            )
          ),
        ),
      ),
    );
  }
}