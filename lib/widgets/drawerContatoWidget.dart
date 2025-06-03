import 'package:empoderainformacoes/controllers/contatoController.dart';
import 'package:empoderainformacoes/models/contatoModel.dart';
import 'package:empoderainformacoes/utils/call.dart';
import 'package:empoderainformacoes/utils/openMaps.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/colors.dart';

class DrawerContatosWidget extends StatelessWidget {
  final ContatoController contatoController = ContatoController.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                ...categorias.map((categoria) => _buildCategoriaTile(context, categoria, contatos)),
                SizedBox(height: 20),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: palePink),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          'Contatos',
          style: GoogleFonts.montserrat(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildCategoriaTile(BuildContext context, String categoria, List<ContatoModel> contatos) {
    final contatosFiltrados = contatos.where((c) => c.categoria == categoria).toList();

    return Padding(
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
            showModalBottomSheet(
              context: context,
              backgroundColor: palePink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Contatos: $categoria',
                          style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      ...contatosFiltrados.map((contato) => Card(
                        color: softCream,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Informações do contato (lado esquerdo)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contato.nome,
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    SizedBox(height: 4),
                                    Text(contato.horario ?? 'Seg-Sex: 08h às 17h', style: TextStyle(color: Colors.black),),
                                    SizedBox(height: 4),
                                    Text(contato.telefone, style: TextStyle(color: Colors.black)),
                                    SizedBox(height: 4),
                                    Text(contato.endereco, style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.phone, color: Colors.green),
                                    tooltip: 'Ligar',
                                    onPressed: () => ligarPara(contato.telefone),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.location_on, color: Colors.redAccent),
                                    tooltip: 'Ver no mapa',
                                    onPressed: () => abrirNoMaps(contato.endereco),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
