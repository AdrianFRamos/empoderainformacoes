import 'package:empoderainformacoes/screens/addInfoScreen.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/infoController.dart';
import '../widgets/checkMultiRecordWidget.dart';
import '../widgets/infoWidget.dart';

class AllInfoScreen extends StatelessWidget {
  const AllInfoScreen({super.key});
  static const routeName = "/allInfoScreen";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InfoController());
    
    return Scaffold(
      appBar: AppBarWidget(showBackArrow: true, title: Text('Todas as Informacoes')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.allInfo(), 
              builder: (context, snapshot){
                final response = CheckMultiRecordWidget(snapshot: snapshot);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () => Get.to(() => const AddInfoScreen()),
        child: Icon(Icons.add),
      ),
    );
  }
}