import 'package:empoderainformacoes/controllers/infoController.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadInfoScreen extends StatelessWidget {
  const CadInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InfoController());

    return Scaffold(
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder(
            future: controller.allInfo(), 
            builder: (context, snapshot){
              
              return context; 
            }
          ),
        ),
      ),
    );
  }
}