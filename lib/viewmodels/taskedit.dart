// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_2223/viewmodels/taskviewmodel.dart';

import '../models/task.dart';

// Define a custom Form widget.
class taskedit extends StatefulWidget {
  const taskedit({super.key,required this.task});

  final Task task;

  @override
  taskeditstate createState() {
    return taskeditstate(task);
  }
}

TextEditingController titreTache = TextEditingController();
TextEditingController listeTags = TextEditingController();
TextEditingController nbHeure = TextEditingController();
TextEditingController difficultyTache = TextEditingController();
TextEditingController descriptionTache = TextEditingController();


// Define a corresponding State class.
// This class holds data related to the form.
class taskeditstate extends State<taskedit> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final Task task;

  taskeditstate(this.task);

  @override
  void initState() {
    titreTache.text = task.title;
    listeTags.text = task.tags.toString();
    nbHeure.text = task.nbhours.toString();
    difficultyTache.text = task.difficulty.toString();
    descriptionTache.text = task.description.toString();
  }

  @override
  Widget build(BuildContext context) {

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(hintText: "titre"),
            controller: titreTache,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: "Entrez les tags"),
            controller: listeTags,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: "Entrez le nombre d'heures"),
            controller: nbHeure,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: "Entrez la difficulté (int)"),
            controller: difficultyTache,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: "Entrez la description"),
            controller: descriptionTache,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                setState(() {
                task.title = titreTache.text;
                task.tags = [listeTags.text];
                task.nbhours = int.parse(nbHeure.text);
                task.difficulty = int.parse(difficultyTache.text);
                task.description = descriptionTache.text;
                Navigator.pop(context);

                  Navigator.pop(context);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tâche modifiée')),
                );

              }
            },
            child: const Text('Modifier tâche'),
          ),
        ],
      ),
    );
  }
}