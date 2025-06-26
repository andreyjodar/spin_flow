import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; 
import 'package:spin_flow/dto/dto_aluno.dart'; 

class FormAluno extends StatefulWidget {
  const FormAluno({super.key});

  @override
  State<FormAluno> createState() => _FormAlunoState();
}

class _FormAlunoState extends State<FormAluno> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _instagramController = TextEditingController();
  final _facebookController = TextEditingController();
  final _tiktokController = TextEditingController();
  final _phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####', 
    filter: {"#": RegExp(r'[0-9]')}
  );
  
  DateTime? _dataNascimento;
  Genero? _generoSelecionado;
  bool _ativo = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _dataNascimentoController.dispose();
    _telefoneController.dispose();
    _instagramController.dispose();
    _facebookController.dispose();
    _tiktokController.dispose();
    super.dispose();
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataNascimento ?? DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dataNascimento) {
      setState(() {
        _dataNascimento = picked;
        _dataNascimentoController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _salvar() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid || _dataNascimento == null || _generoSelecionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Por favor, preencha todos os campos obrigatórios (*).')),
        );
        return;
    }

    final aluno = AlunoDTO(
      nome: _nomeController.text,
      email: _emailController.text,
      dataNascimento: _dataNascimento!,
      genero: _generoSelecionado!,
      telefone: _telefoneController.text,
      instagram: _instagramController.text.isNotEmpty ? _instagramController.text : null,
      facebook: _facebookController.text.isNotEmpty ? _facebookController.text : null,
      tiktok: _tiktokController.text.isNotEmpty ? _tiktokController.text : null,
      ativo: _ativo,
    );
    
    _mostrarDialogoDeSucesso(aluno);
  }

  void _mostrarDialogoDeSucesso(AlunoDTO aluno) {
     showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aluno Salvo com Sucesso'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Nome: ${aluno.nome}'),
                Text('Email: ${aluno.email}'),
                Text('Data de Nascimento: ${DateFormat('dd/MM/yyyy').format(aluno.dataNascimento)}'),
                Text('Gênero: ${aluno.genero.displayName}'),
                Text('Telefone: ${aluno.telefone}'),
                Text('Instagram: ${aluno.instagram ?? 'Não informado'}'),
                Text('Ativo: ${aluno.ativo ? 'Sim' : 'Não'}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
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
        title: const Text('Formulário de Aluno'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Campos Obrigatórios
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome *'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Nome é obrigatório' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email *'),
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
                TextFormField(
                  controller: _dataNascimentoController,
                  decoration: const InputDecoration(
                    labelText: 'Data de Nascimento *',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () => _selecionarData(context),
                ),
                DropdownButtonFormField<Genero>(
                  value: _generoSelecionado,
                  decoration: const InputDecoration(labelText: 'Gênero *'),
                  items: Genero.values.map((Genero genero) {
                    return DropdownMenuItem<Genero>(
                      value: genero,
                      child: Text(genero.displayName),
                    );
                  }).toList(),
                  onChanged: (Genero? newValue) {
                    setState(() => _generoSelecionado = newValue);
                  },
                ),
                TextFormField(
                  controller: _telefoneController,
                  inputFormatters: [_phoneFormatter],
                  decoration: const InputDecoration(labelText: 'Telefone *'),
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
                const SizedBox(height: 24),
                // Campos Opcionais
                const Text('Redes Sociais (Opcional)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _instagramController,
                  decoration: const InputDecoration(labelText: 'Instagram'),
                ),
                TextFormField(
                  controller: _facebookController,
                  decoration: const InputDecoration(labelText: 'Facebook'),
                ),
                TextFormField(
                  controller: _tiktokController,
                  decoration: const InputDecoration(labelText: 'TikTok'),
                ),
                const SizedBox(height: 24),
                SwitchListTile(
                  title: const Text('Ativo'),
                  value: _ativo,
                  onChanged: (bool value) => setState(() => _ativo = value),
                  secondary: const Icon(Icons.check_circle_outline),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _salvar,
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