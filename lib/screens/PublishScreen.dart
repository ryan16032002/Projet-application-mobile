import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import '../style/font.dart';
import '../style/spacings.dart';

class PublishScreen extends StatefulWidget {
  const PublishScreen({Key? key}) : super(key: key);

  @override
  _PublishScreenState createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  String? _selectedDomain;
  String? _selectedLevel;
  PlatformFile? _selectedFile;

  Future<void> _publishSummary() async {
    if (_formKey.currentState!.validate() && _selectedFile != null) {
      try {
        await FirebaseFirestore.instance.collection('syntheses').add({
          'title': _titleController.text,
          'domain': _selectedDomain,
          'level': _selectedLevel,
          'comment': _commentController.text,
          'fileName': _selectedFile!.name,
          'timestamp': FieldValue.serverTimestamp(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Synthèse publiée avec succès')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la publication : $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs et sélectionner un fichier PDF.')),
      );
    }
  }

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publier une Synthèse'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kHorizontalPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Veuillez entrer un titre' : null,
              ),
              const SizedBox(height: kVerticalPadding),
              DropdownButtonFormField<String>(
                value: _selectedDomain,
                hint: const Text('Domaine'),
                items: ['Informatique', 'Physique', 'Chimie', 'Mathématiques']
                    .map((domain) => DropdownMenuItem(value: domain, child: Text(domain)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedDomain = value),
                validator: (value) => value == null ? 'Veuillez sélectionner un domaine' : null,
              ),
              const SizedBox(height: kVerticalPadding),
              DropdownButtonFormField<String>(
                value: _selectedLevel,
                hint: const Text('Niveau'),
                items: ['1ère année', '2ème année', '3ème année']
                    .map((level) => DropdownMenuItem(value: level, child: Text(level)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedLevel = value),
                validator: (value) => value == null ? 'Veuillez sélectionner un niveau' : null,
              ),
              const SizedBox(height: kVerticalPadding),
              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Commentaire',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Veuillez entrer un commentaire' : null,
              ),
              const SizedBox(height: kVerticalPadding),
              ElevatedButton(
                onPressed: _selectFile,
                child: Text(_selectedFile != null ? 'Fichier sélectionné : ${_selectedFile!.name}' : 'Sélectionner un fichier PDF'),
              ),
              const SizedBox(height: kVerticalPadding),
              ElevatedButton(
                onPressed: _publishSummary,
                child: const Text('Publier'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _commentController.dispose();
    super.dispose();
  }
}
