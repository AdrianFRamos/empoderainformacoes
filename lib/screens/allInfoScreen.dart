import 'package:empoderainformacoes/screens/addInfoScreen.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllInfoScreen extends StatelessWidget {
  const AllInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () => Get.to(() => const AddInfoScreen()),
        child: Icon(Icons.add),
      ),
      appBar: AppBarWidget(title: Text('Informacoes')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[

            ],
          ),
        ),
      ),
    );
  }
}