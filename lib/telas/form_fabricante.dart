import 'package:flutter/material.dart';
import 'package:flutter_project2/dto/dto_fabricante..dart';

class FabricanteForm extends StatefulWidget {
  const FabricanteForm({Key? key}) : super(key: key);

  @override
  _FabricanteFormState createState() => _FabricanteFormState();
}

class _FabricanteFormState extends State<FabricanteForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _nomeContatoController = TextEditingController();
  final TextEditingController _emailContatoController = TextEditingController();
  final TextEditingController _telefoneContatoController =
      TextEditingController();

  bool _ativo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Fabricante')),
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
              TextFormField(
                controller: _nomeContatoController,
                decoration: const InputDecoration(
                    labelText: 'Nome do Contato Principal'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o nome do contato' : null,
              ),
              TextFormField(
                controller: _emailContatoController,
                decoration:
                    const InputDecoration(labelText: 'Email do Contato'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o email do contato' : null,
              ),
              TextFormField(
                controller: _telefoneContatoController,
                decoration:
                    const InputDecoration(labelText: 'Telefone do Contato'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o telefone do contato' : null,
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
                    FabricanteDTO fabricante = FabricanteDTO(
                      nome: _nomeController.text,
                      descricao: _descricaoController.text,
                      nomeContatoPrincipal: _nomeContatoController.text,
                      emailContato: _emailContatoController.text,
                      telefoneContato: _telefoneContatoController.text,
                      ativo: _ativo,
                    );

                    // Aqui você pode usar o objeto fabricante para salvar ou enviar.
                    print('Fabricante cadastrado: ${fabricante.nome}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Fabricante cadastrado com sucesso!')),
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
