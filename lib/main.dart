import 'package:flutter/material.dart';
import 'package:spin_flow/telas/formularios/form_aluno.dart';
import 'package:spin_flow/telas/formularios/form_bike.dart';
import 'package:spin_flow/telas/formularios/form_fabricante.dart';
import 'package:spin_flow/telas/formularios/form_sala.dart';
import 'package:spin_flow/telas/formularios/form_tipo-manutencao.dart';
import 'package:spin_flow/telas/formularios/form_video_aula.dart';
import 'package:spin_flow/telas/listas/lista_fabricante.dart';
import 'package:spin_flow/telas/tela_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spin Flow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const TelaDashboard(),
        '/cadastro_video_aula': (context) => const FormVideoAula(),
        '/cadastro_aluno': (context) => const AlunoForm(),
        '/cadastro_fabricante': (context) => const FabricanteForm(),
        '/cadastro_sala': (context) => const SalaForm(),
        '/cadastro_tipo_manutencao': (context) => const TipoManutencaoForm(),
        '/cadastro_bike': (context) => const BikeForm(),
        '/lista_fabricante': (context) => const ListaFabricante()
      },
    );
  }
}