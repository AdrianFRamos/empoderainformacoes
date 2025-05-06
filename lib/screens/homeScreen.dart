import 'package:empoderainformacoes/controllers/contatoController.dart';
import 'package:empoderainformacoes/models/contatoModel.dart';
import 'package:empoderainformacoes/utils/call.dart';
import 'package:empoderainformacoes/utils/openMaps.dart';
//import 'package:empoderainformacoes/screens/secondScreen.dart';
import 'package:empoderainformacoes/widgets/bottomBarWidget.dart';
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
    final largura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: HomeAppBar(),
      drawer: Drawer(
        backgroundColor: softCream,
        child: FutureBuilder<List<ContatoModel>>(
          future: contatoController.allContatos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar contatos'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerHeader(),
                  ListTile(
                    title: Text('Nenhum contato cadastrado', style: GoogleFonts.montserrat()),
                  ),
                ],
              );
            } else {
              final contatos = snapshot.data!;
              final categorias = contatos.map((c) => c.categoria).toSet().toList();

              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerHeader(),
                  ...categorias.map((categoria) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                    child: Card(
                      color: palePink,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 1,
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text(
                          categoria,
                          style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          final contatosFiltrados = contatos.where((c) => c.categoria == categoria).toList();
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: palePink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (_) => Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Contatos: $categoria',
                                    style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                  SizedBox(height: 10),
                                  ...contatosFiltrados.map((contato) => Card(
                                    color: softCream,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  contato.nome,
                                                  style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  contato.telefone,
                                                  style: TextStyle(color: Colors.black54),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  contato.endereco,
                                                  style: TextStyle(color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.phone, color: Colors.green),
                                                  tooltip: 'Ligar',
                                                  onPressed: () {
                                                    ligarPara(contato.telefone);
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.location_on, color: Colors.redAccent),
                                                  tooltip: 'Ver no mapa',
                                                  onPressed: () {
                                                    abrirNoMaps(contato.endereco);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )).toList(),
                  SizedBox(height: 20),
                ],
              );
            }
          },
        ),
      ),
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

                                      // Responsivo: Se largura < 600, usar 80% da largura, senão, fixar tamanho
                                      double cardWidth = largura < 600 ? largura * 0.8 : 170;

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

Widget _buildDrawerHeader() {
  return DrawerHeader(
    decoration: BoxDecoration(
      color: palePink,
    ),
    child: Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        'Contatos',
        style: GoogleFonts.montserrat(fontSize: 26, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
