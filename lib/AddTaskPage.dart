import 'package:flutter/material.dart';
import 'models/task.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  List<String> _tags = [];
  int _nbhours = 0;
  int _difficulty = 1;
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Titre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Tags (séparés par des virgules)',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _tags = value!.split(',').map((e) => e.trim()).toList();
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nombre d\'heures',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nombre';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nbhours = int.parse(value!);
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Difficulté',
                  border: OutlineInputBorder(),
                ),
                value: _difficulty,
                items: List.generate(
                  5,
                      (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text('Difficulté ${index + 1}'),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _difficulty = value as int;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final task = Task(
                      id: 0,
                      title: _title,
                      tags: _tags,
                      nbhours: _nbhours,
                      difficulty: _difficulty,
                      description: _description,
                    );
                    Navigator.of(context).pop(task);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tâche ajoutée'),
                      ),
                    );
                  }
                },
                child: Text('Ajouter la tâche'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}