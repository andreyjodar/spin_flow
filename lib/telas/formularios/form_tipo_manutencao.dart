// lib/telas/formularios/form_tipo_manutencao.dart

import 'package:flutter/material.dart';
import 'package:spin_flow/banco/dao/dao_tipo_manutencao.dart';
import 'package:spin_flow/dto/dto_tipo_manutencao.dart'; 

class FormTipoManutencao extends StatefulWidget {
  final TipoManutencaoDTO? tipoManutencao;

  const FormTipoManutencao({super.key, this.tipoManutencao});

  @override
  State<FormTipoManutencao> createState() => _FormTipoManutencaoState();
}

class _FormTipoManutencaoState extends State<FormTipoManutencao> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final DAOTipoManutencao _dao = DAOTipoManutencao();
  bool _ativo = true;

  @override
  void initState() {
    super.initState();
    if (widget.tipoManutencao != null) {
      _nomeController.text = widget.tipoManutencao!.nome;
      _descricaoController.text = widget.tipoManutencao!.descricao ?? '';
      _ativo = widget.tipoManutencao!.ativo;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _salvar() async {
    if (_formKey.currentState?.validate() ?? false) {
      final tipoManutencao = TipoManutencaoDTO(
        id: widget.tipoManutencao?.id,
        nome: _nomeController.text,
        descricao: _descricaoController.text.isNotEmpty 
            ? _descricaoController.text 
            : null,
        ativo: _ativo,
      );

      await _dao.salvar(tipoManutencao);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tipo de manutenção salvo com sucesso!')),
        );
        Navigator.of(context).pushNamed('/lista_tipo_manutencao');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tipoManutencao == null
            ? 'Novo Tipo de Manutenção'
            : 'Editar Tipo de Manutenção'),
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