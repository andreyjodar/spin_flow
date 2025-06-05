import 'package:flutter/material.dart';
import 'package:flutter_project2/dto/dto_video_aula.dart';

class FormVideoAula extends StatefulWidget {
  final VideoAulaDTO? videoAulaInicial;

  const FormVideoAula({super.key, this.videoAulaInicial});

  @override
  State<FormVideoAula> createState() => _FormVideoAulaState();
}

class _FormVideoAulaState extends State<FormVideoAula> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _idController;
  late TextEditingController _nomeController;
  late TextEditingController _linkVideoController;
  bool _ativo = true;

  @override
  void initState() {
    super.initState();

    // Inicializa os controladores com valores do DTO se existir
    _idController =
        TextEditingController(text: widget.videoAulaInicial?.id ?? '');
    _nomeController =
        TextEditingController(text: widget.videoAulaInicial?.nome ?? '');
    _linkVideoController =
        TextEditingController(text: widget.videoAulaInicial?.linkVideo ?? '');
    _ativo = widget.videoAulaInicial?.ativo ?? true;
  }

  @override
  void dispose() {
    _idController.dispose();
    _nomeController.dispose();
    _linkVideoController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final videoAulaDTO = VideoAulaDTO(
        id: _idController.text.isEmpty ? null : _idController.text,
        nome: _nomeController.text,
        linkVideo: _linkVideoController.text,
        ativo: _ativo,
      );

      print('Vídeo Aula DTO: ${videoAulaDTO.toMap()}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vídeo Aula salva com sucesso!')),
      );

      // Aqui poderia: enviar para API, retornar via Navigator.pop, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Vídeo Aula'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(),
                ),
                enabled: false, // ID geralmente é gerado automaticamente
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, informe o nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _linkVideoController,
                decoration: const InputDecoration(
                  labelText: 'Link do Vídeo',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, informe o link do vídeo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Ativo'),
                value: _ativo,
                onChanged: (value) {
                  setState(() {
                    _ativo = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _salvar,
                icon: const Icon(Icons.save),
                label: const Text('Salvar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
