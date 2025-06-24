import 'package:flutter/material.dart';
import 'package:spin_flow/dto/dto_aluno.dart';

class AlunoForm extends StatefulWidget {
  const AlunoForm({Key? key}) : super(key: key);

  @override
  _AlunoFormState createState() => _AlunoFormState();
}

class _AlunoFormState extends State<AlunoForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dataNascimentoController =
      TextEditingController();
  final TextEditingController _generoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _tiktokController = TextEditingController();
  bool _ativo = true;

  DateTime? _dataNascimento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Aluno')),
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
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Informe o email' : null,
              ),
              TextFormField(
                controller: _dataNascimentoController,
                decoration:
                    const InputDecoration(labelText: 'Data de Nascimento'),
                readOnly: true,
                onTap: () async {
                  DateTime? dataSelecionada = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (dataSelecionada != null) {
                    setState(() {
                      _dataNascimento = dataSelecionada;
                      _dataNascimentoController.text =
                          "${dataSelecionada.toLocal()}".split(' ')[0];
                    });
                  }
                },
                validator: (value) =>
                    value!.isEmpty ? 'Informe a data de nascimento' : null,
              ),
              TextFormField(
                controller: _generoController,
                decoration: const InputDecoration(labelText: 'Gênero'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o gênero' : null,
              ),
              TextFormField(
                controller: _telefoneController,
                decoration:
                    const InputDecoration(labelText: 'Telefone de Contato'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o telefone' : null,
              ),
              TextFormField(
                controller: _instagramController,
                decoration:
                    const InputDecoration(labelText: 'Perfil Instagram'),
              ),
              TextFormField(
                controller: _facebookController,
                decoration: const InputDecoration(labelText: 'Perfil Facebook'),
              ),
              TextFormField(
                controller: _tiktokController,
                decoration: const InputDecoration(labelText: 'Perfil TikTok'),
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
                    AlunoDTO aluno = AlunoDTO(
                      nome: _nomeController.text,
                      email: _emailController.text,
                      dataNascimento: _dataNascimento!,
                      genero: _generoController.text,
                      telefoneContato: _telefoneController.text,
                      perfilInstagram: _instagramController.text,
                      perfilFacebook: _facebookController.text,
                      perfilTiktok: _tiktokController.text,
                      ativo: _ativo,
                    );

                    // Aqui você pode usar o objeto aluno para salvar ou enviar.
                    print('Aluno cadastrado: ${aluno.nome}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Aluno cadastrado com sucesso!')),
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
