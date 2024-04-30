import 'package:empoderainformacoes/controllers/infoController.dart';
import 'package:empoderainformacoes/widgets/homeBarWidget.dart';
import 'package:empoderainformacoes/widgets/checkMultiRecordWidget.dart';
import 'package:empoderainformacoes/widgets/infoWidget.dart';
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
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.toString()),
              future: controller.allInfo(), 
              builder: (context, snapshot){
                final response = CheckMultiRecordWidget(snapshot: snapshot);
                // ignore: unnecessary_null_comparison
                if (response != null) return response;
            
                final informacoes = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: informacoes.length,
                  itemBuilder: (_, index) => InfoWidget(
                    informacoes: informacoes[index],
                  ),
                ); 
              }
            ),
          ),
        ),
      ),
    );
  }
}