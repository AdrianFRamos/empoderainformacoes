import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../const/colors.dart';
import '../controllers/infoController.dart';
import '../models/informacoesModel.dart';
import '../widgets/homeBarWidget.dart';
import 'secondScreen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final InfoController infoController = Get.put(InfoController());
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool showSearchField = false;
  String searchQuery = '';

  IconData getIconForGrandArea(String grandArea) {
    switch (grandArea.toLowerCase()) {
      case 'aposentadoria':
        return Icons.account_balance;
      case 'direitos inclusivos':
        return Icons.all_inclusive;
      case 'seguro social':
        return Icons.lock;
      case 'violência contra a mulher':
        return Icons.shield;
      case 'direitos trabalhistas':
        return Icons.balance;
      case 'saude':
        return Icons.local_hospital;
      case 'educacao':
        return Icons.school;
      case 'profissional':
        return Icons.work;
      case 'comunidade':
        return Icons.monetization_on;
      default:
        return Icons.question_mark;
    }
  }

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      if (!searchFocusNode.hasFocus) {
        setState(() {
          showSearchField = false;
        });
      }
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (showSearchField) {
          setState(() {
            showSearchField = false;
          });
        }
      },
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: Container(
          color: softCream,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        showSearchField = true;
                        searchFocusNode.requestFocus();
                      });
                    },
                    child: Text(
                      'Em que podemos ajudar?',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                if (showSearchField)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: searchController,
                      focusNode: searchFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Pesquisar',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.search)
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                    ),
                  ),
                SizedBox(height: 16),
                Expanded(
                  child: Obx(() {
                    if (infoController.refreshData.value) {
                      return FutureBuilder<List<InfoModel>>(
                        future: searchQuery.isEmpty
                            ? infoController.allInfo()
                            : infoController.searchInfo(searchQuery),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Erro ao carregar dados'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text('Nenhuma informação disponível'));
                          } else {
                            final informacoes = snapshot.data!;
                            final uniqueGrandAreas = informacoes
                                .map((info) => info.grandArea)
                                .where((grandArea) => grandArea.toLowerCase().contains(searchQuery))
                                .toSet()
                                .toList();
                            return Wrap(
                              children: uniqueGrandAreas.map((grandArea) => buildGridItem(grandArea)).toList(),
                            );
                          }
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGridItem(String grandArea) {
    final IconData icon = getIconForGrandArea(grandArea);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Get.to(() => SecondScreen(grandArea: grandArea), transition: Transition.fadeIn);
        },
        child: Container(
          width: 170,
          height: 160,
          decoration: BoxDecoration(
            color: palePink,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: softCream,
              ),
              SizedBox(height: 8),
              Text(
                grandArea,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
