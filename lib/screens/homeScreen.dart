import 'package:empoderainformacoes/controllers/contatoController.dart';
//import 'package:empoderainformacoes/screens/secondScreen.dart';
import 'package:empoderainformacoes/widgets/bottomBarWidget.dart';
import 'package:empoderainformacoes/widgets/drawerContatoWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../const/colors.dart';
import '../controllers/infoController.dart';
import '../models/informacoesModel.dart';
import '../widgets/grandAreaWidget.dart';
import '../widgets/homeBarWidget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final InfoController infoController = Get.put(InfoController());
  final ContatoController contatoController = Get.put(ContatoController());
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool showSearchField = false;
  String searchQuery = '';
  
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
    final InfoController infoController = InfoController.instance;

    return Scaffold(
      appBar: HomeAppBar(),
      drawer: DrawerContatosWidget(),
      body: GestureDetector(
        onTap: () {
          if (showSearchField) {
            setState(() {
              showSearchField = false;
            });
          }
        },
        child: Container(
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
                        fontWeight: FontWeight.bold,
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
                        suffixIcon: Icon(Icons.search),
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
                        future: infoController.allInfo().then((list) {
                          return searchQuery.isEmpty
                              ? list
                              : list.where((info) =>
                                  info.grandArea.toLowerCase().contains(searchQuery) ||
                                  info.pequeArea.toLowerCase().contains(searchQuery) ||
                                  info.titulo.toLowerCase().contains(searchQuery)
                                ).toList();
                        }),
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
                                .toSet()
                                .toList();
                            return SingleChildScrollView(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 10,
                                runSpacing: 16,
                                children: uniqueGrandAreas.map((grandArea) {
                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      double largura = MediaQuery.of(context).size.width;

                                      // Responsivo: Se largura < 800, usar 80% da largura, senão, fixar tamanho
                                      double cardWidth = largura < 800 ? largura * 0.8 : 170;

                                      return SizedBox(
                                        width: cardWidth,
                                        child: buildGridItem(grandArea),
                                      );
                                    },
                                  );
                                }).toList(),
                              )                       
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
      bottomNavigationBar: BottomBarWidget(
      ),
    );
  }
}
