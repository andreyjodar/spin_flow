import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_application_1/telas/form_aluno.dart';
import 'package:flutter_application_1/telas/form_bike.dart';
import 'package:flutter_application_1/telas/form_fabricante.dart';
import 'package:flutter_application_1/telas/form_sala.dart';
import 'package:flutter_application_1/telas/form_tipo_manutencao.dart';
import 'package:flutter_application_1/telas/form_video_aula.dart';
import 'package:flutter_application_1/telas/lista_fabricante.dart';
import 'package:flutter_application_1/telas/lista_tipo_manutencao.dart';
import 'package:flutter_application_1/telas/tela_dashboard.dart';
=======
import 'package:spin_flow/telas/formularios/form_aluno.dart';
import 'package:spin_flow/telas/formularios/form_fabricante.dart';
import 'package:spin_flow/telas/formularios/form_sala.dart';
import 'package:spin_flow/telas/formularios/form_video_aula.dart';
import 'package:spin_flow/telas/listas/lista_fabricante.dart';
import 'package:spin_flow/telas/tela_dashboard.dart';
>>>>>>> main

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
<<<<<<< HEAD
        '/cadastro_aluno': (context) => const AlunoForm(),
        '/cadastro_fabricante': (context) => const FabricanteForm(),
        '/cadastro_sala': (context) => const SalaForm(),
        '/cadastro_tipo_manutencao': (context) => const TipoManutencaoForm(),
        '/cadastro_bike': (context) => const BikeForm(),
        '/lista_fabricante': (context) => const ListaFabricante(),
        '/lista_tipo_manutencao': (context) => const ListaTipoManutencao(),
=======
        '/cadastro_aluno': (context) => const FormAluno(),
        '/cadastro_fabricante': (context) => const FormFabricante(),
        '/cadastro_sala': (context) => const FormSala(),
        '/lista_fabricante': (context) => const ListaFabricante(),
>>>>>>> main
      },
    );
  }
}