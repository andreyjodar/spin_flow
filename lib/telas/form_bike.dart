import 'package:flutter/material.dart';
import 'package:flutter_application_1/dto/dto_bike.dart';
import 'package:flutter_application_1/dto/dto_fabricante..dart';
import 'package:flutter_application_1/repository/fabricante_repository.dart';

class BikeForm extends StatefulWidget {
  const BikeForm({Key? key}) : super(key: key);

  @override
  _BikeFormState createState() => _BikeFormState();
}

class _BikeFormState extends State<BikeForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroSerieController = TextEditingController();
  int? _fabricanteSelecionado; // ID do Fabricante

  DateTime? _dataAquisicao;
  DateTime? _dataCadastroSistema;

  bool _ativo = true;

  final FabricanteRepository _fabricanteRepository = FabricanteRepository();
  List<FabricanteDTO> _fabricantes = [];

  @override
  void initState() {
    super.initState();
    _carregarFabricantes();
  }

  void _carregarFabricantes() {
    setState(() {
      _fabricantes = _fabricanteRepository.listarTodos();
    });
  }

  Future<void> _selecionarData(BuildContext context, bool isAquisicao) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isAquisicao) {
          _dataAquisicao = picked;
        } else {
          _dataCadastroSistema = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Bike')),
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
                controller: _numeroSerieController,
                decoration: const InputDecoration(labelText: 'Número de Série'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o número de série' : null,
              ),
              DropdownButtonFormField<int>(
                value: _fabricanteSelecionado,
                decoration: const InputDecoration(labelText: 'Fabricante'),
                items: _fabricantes.map((fab) {
                  return DropdownMenuItem(
                    value: fab.id,
                    child: Text(fab.nome),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _fabricanteSelecionado = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Selecione um fabricante' : null,
              ),
              ListTile(
                title: Text(_dataAquisicao == null
                    ? 'Selecione a Data de Aquisição'
                    : 'Data de Aquisição: ${_dataAquisicao!.toLocal()}'
                        .split(' ')[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selecionarData(context, true),
              ),
              ListTile(
                title: Text(_dataCadastroSistema == null
                    ? 'Selecione a Data de Cadastro'
                    : 'Data de Cadastro: ${_dataCadastroSistema!.toLocal()}'
                        .split(' ')[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selecionarData(context, false),
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
                  if (_formKey.currentState!.validate() &&
                      _dataAquisicao != null &&
                      _dataCadastroSistema != null) {
                    BikeDTO bike = BikeDTO(
                      nome: _nomeController.text,
                      numeroSerie: _numeroSerieController.text,
                      fabricanteId: _fabricanteSelecionado!,
                      dataAquisicao: _dataAquisicao!,
                      dataCadastroSistema: _dataCadastroSistema!,
                      ativo: _ativo,
                    );

                    // Aqui você pode salvar ou enviar a bike
                    print('Bike cadastrada: ${bike.nome}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Bike cadastrada com sucesso!')),
                    );
                  } else if (_dataAquisicao == null ||
                      _dataCadastroSistema == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Selecione as datas obrigatórias!')),
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
