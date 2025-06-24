import 'package:flutter/material.dart';
import 'package:spin_flow/dto/dto_fabricante.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormFabricante extends StatefulWidget {
  const FormFabricante({super.key});

  @override
  State<FormFabricante> createState() => _FormFabricanteState();
}

class _FormFabricanteState extends State<FormFabricante> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _nomeContatoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####', 
    filter: {"#": RegExp(r'[0-9]')}
  );
  bool _ativo = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _nomeContatoController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState?.validate() ?? false) {
      final fabricante = FabricanteDTO(
        nome: _nomeController.text,
        descricao: _descricaoController.text.isNotEmpty 
            ? _descricaoController.text 
            : null,
        nomeContatoPrincipal: _nomeContatoController.text.isNotEmpty
            ? _nomeContatoController.text
            : null,
        emailContato: _emailController.text.isNotEmpty 
            ? _emailController.text 
            : null,
        telefoneContato: _telefoneController.text.isNotEmpty
            ? _telefoneController.text
            : null,
        ativo: _ativo,
      );

      _mostrarDialogoDeSucesso(fabricante);
    }
  }

  void _mostrarDialogoDeSucesso(FabricanteDTO fabricante) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fabricante Salvo com Sucesso'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Nome: ${fabricante.nome}'),
                Text('Descrição: ${fabricante.descricao ?? 'Não informado'}'),
                Text('Contato Principal: ${fabricante.nomeContatoPrincipal ?? 'Não informado'}'),
                Text('Email: ${fabricante.emailContato ?? 'Não informado'}'),
                Text('Telefone: ${fabricante.telefoneContato ?? 'Não informado'}'),
                Text('Ativo: ${fabricante.ativo ? 'Sim' : 'Não'}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pushNamed('/lista_fabricante');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Fabricante'),
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
                  controller: _descricaoController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nomeContatoController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Contato Principal',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email *',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Por favor, insira um email válido.';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _telefoneController,
                  inputFormatters: [_phoneFormatter],
                  decoration: const InputDecoration(
                    labelText: 'Telefone *',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      if (value.replaceAll(RegExp(r'[^0-9]'), '').length < 10) {
                        return 'O telefone deve ter pelo menos 10 dígitos.';
                      }
                    }
                    return null;
                  },
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