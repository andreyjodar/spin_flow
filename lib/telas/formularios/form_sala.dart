import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spin_flow/dto/dto_sala.dart';

class FormSala extends StatefulWidget {
  const FormSala({super.key});

  @override
  State<FormSala> createState() => _FormSalaState();
}

class _FormSalaState extends State<FormSala> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _capacidadeController = TextEditingController();
  final _filasController = TextEditingController();
  final _bikesPorFilaController = TextEditingController();
  bool _ativo = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _capacidadeController.dispose();
    _filasController.dispose();
    _bikesPorFilaController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState?.validate() ?? false) {
      final sala = SalaDTO(
        nome: _nomeController.text,
        capacidadeTotalBikes: int.parse(_capacidadeController.text),
        numeroFilas: int.parse(_filasController.text),
        bikesPorFila: int.parse(_bikesPorFilaController.text),
        ativo: _ativo,
      );

      _mostrarDialogoDeSucesso(sala);
    }
  }

  void _mostrarDialogoDeSucesso(SalaDTO sala) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sala Salva com Sucesso'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Nome: ${sala.nome}'),
                Text('Capacidade Total: ${sala.capacidadeTotalBikes} bikes'),
                Text('Número de Filas: ${sala.numeroFilas}'),
                Text('Bikes por Fila: ${sala.bikesPorFila}'),
                Text('Ativo: ${sala.ativo ? 'Sim' : 'Não'}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String? _validarNumero(String? value, String nomeCampo) {
    if (value == null || value.trim().isEmpty) {
      return '$nomeCampo é obrigatório.';
    }
    if (int.tryParse(value) == null) {
      return 'Por favor, insira um número válido.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Sala'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'O nome é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _capacidadeController,
                  decoration: const InputDecoration(
                    labelText: 'Capacidade Total de Bikes *',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => _validarNumero(value, 'Capacidade Total'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _filasController,
                  decoration: const InputDecoration(
                    labelText: 'Número de Filas *',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => _validarNumero(value, 'Número de Filas'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _bikesPorFilaController,
                  decoration: const InputDecoration(
                    labelText: 'Bikes por Fila *',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => _validarNumero(value, 'Bikes por Fila'),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Ativo'),
                  value: _ativo,
                  onChanged: (bool value) {
                    setState(() {
                      _ativo = value;
                    });
                  },
                  secondary: const Icon(Icons.check_circle_outline),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _salvar,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}