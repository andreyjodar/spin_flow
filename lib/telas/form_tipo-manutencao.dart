import 'package:flutter/material.dart';
import 'package:flutter_project2/dto/dto_tipo_manutencao.dart';

class TipoManutencaoForm extends StatefulWidget {
  const TipoManutencaoForm({Key? key}) : super(key: key);

  @override
  _TipoManutencaoFormState createState() => _TipoManutencaoFormState();
}

class _TipoManutencaoFormState extends State<TipoManutencaoForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  bool _ativo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Tipo de Manutenção')),
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
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe a descrição' : null,
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
                    TipoManutencaoDTO tipoManutencao = TipoManutencaoDTO(
                      nome: _nomeController.text,
                      descricao: _descricaoController.text,
                      ativo: _ativo,
                    );

                    // Aqui você pode usar o objeto tipoManutencao para salvar ou enviar.
                    print(
                        'Tipo de Manutenção cadastrado: ${tipoManutencao.nome}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Tipo de Manutenção cadastrado com sucesso!')),
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
