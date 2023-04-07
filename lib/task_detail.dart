import 'package:flutter/material.dart';
import 'models/task.dart';

class TaskDetailPage extends StatefulWidget {
  final Task task;

  TaskDetailPage({required this.task});

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  int _difficulty = 0;
  int _nbhours = 0;
  List<String> _tags = [];
  String _description = "";

  @override
  void initState() {
    super.initState();
    _title = widget.task.title;
    _difficulty = widget.task.difficulty;
    _nbhours = widget.task.nbhours;
    _tags = widget.task.tags;
    _description = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Difficulté : ${widget.task.difficulty}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "Nombre d'heures : ${widget.task.nbhours}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Tags : ${widget.task.tags.join(", ")}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              Text(
                'Description :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                widget.task.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Modifier la tâche',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    initialValue: _title,
                                    decoration: InputDecoration(
                                      labelText: 'Titre',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Veuillez entrer un titre';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _title = value!;
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    initialValue: _difficulty.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Difficulté',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Veuillez entrer une difficulté';
                                      }
                                      if (int.tryParse(value) == null) {
                                        return 'Veuillez entrer un nombre';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _difficulty = int.parse(value!);
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    initialValue: _nbhours.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "Nombre d'heures",
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Veuillez entrer un nombre d'heures";
                                      }
                                      if (int.tryParse(value) == null) {
                                        return 'Veuillez entrer un nombre';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _nbhours = int.parse(value!);
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    initialValue: _tags.join(", "),
                                    decoration: InputDecoration(
                                      labelText:
                                          'Tags (séparés par une virgule)',
                                      border: OutlineInputBorder(),
                                    ),
                                    onSaved: (value) {
                                      _tags = value!
                                          .split(",")
                                          .map((e) => e.trim())
                                          .toList();
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    initialValue: _description,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      labelText: 'Description',
                                      border: OutlineInputBorder(),
                                    ),
                                    onSaved: (value) {
                                      _description = value!;
                                    },
                                  ),
                                  SizedBox(height: 24),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        Task updatedTask = Task(
                                          id: widget.task.id,
                                          title: _title,
                                          difficulty: _difficulty,
                                          nbhours: _nbhours,
                                          tags: _tags,
                                          description: _description,
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Tâche Modifiée'),
                                          ),
                                        );
                                        Navigator.pop(context, updatedTask);
                                        Navigator.pop(context, updatedTask);

                                      }
                                    },
                                    child: Text('Enregistrer'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).then((value) {
                    if (value != null) {
                      setState(() {
                        widget.task.title = value.title;
                        widget.task.difficulty = value.difficulty;
                        widget.task.nbhours = value.nbhours;
                        widget.task.tags = value.tags;
                        widget.task.description = value.description;
                      });
                    }
                  });
                },
                child: Text('Modifier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
