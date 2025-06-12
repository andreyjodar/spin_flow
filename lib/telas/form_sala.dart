import 'package:flutter/material.dart';
import 'package:flutter_application_1/dto/dto_sala.dart';

class SalaForm extends StatefulWidget {
  const SalaForm({Key? key}) : super(key: key);

  @override
  _SalaFormState createState() => _SalaFormState();
}

class _SalaFormState extends State<SalaForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _capacidadeController = TextEditingController();
  final TextEditingController _numeroFilasController = TextEditingController();
  final TextEditingController _numeroBikesPorFilaController =
      TextEditingController();

  bool _ativo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Sala')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _capacidadeController,
                decoration: const InputDecoration(
                    labelText: 'Capacidade Total de Bikes'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Informe a capacidade' : null,
              ),
              TextFormField(
                controller: _numeroFilasController,
                decoration: const InputDecoration(labelText: 'Número de Filas'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Informe o número de filas' : null,
              ),
              TextFormField(
                controller: _numeroBikesPorFilaController,
                decoration: const InputDecoration(
                    labelText: 'Número de Bikes por Fila'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty
                    ? 'Informe o número de bikes por fila'
                    : null,
              ),
              SwitchListTile(
                title: const Text('Ativo'),
                value: _ativo,
                onChanged: (val) {
                  setState(() {
                    _ativo = val;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    SalaDTO sala = SalaDTO(
                      nome: _nomeController.text,
                      capacidadeTotalBikes:
                          int.parse(_capacidadeController.text),
                      numeroFilas: int.parse(_numeroFilasController.text),
                      numeroBikesPorFila:
                          int.parse(_numeroBikesPorFilaController.text),
                      ativo: _ativo,
                    );

                    // Aqui você pode usar o objeto sala para salvar ou enviar.
                    print('Sala cadastrada: ${sala.nome}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Sala cadastrada com sucesso!')),
                    );
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
