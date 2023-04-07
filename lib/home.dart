import 'package:flutter/material.dart';
import 'package:td2_2223/task_detail.dart';
import 'AddTaskPage.dart';
import 'models/task.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> _tasks = Task.generateTask(50);

  void _navigateToAddTaskScreen(BuildContext context) async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskPage()),
    );
    if (newTask != null) {
      setState(() {
        _tasks.add(newTask);
      });
    }
  }

  void _navigateToTaskDetailScreen(BuildContext context, Task task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailPage(task: task)),
    );
    if (result == 'delete') {
      setState(() {
        _tasks.remove(task);
      });
    }
    if (result != null && result is Task) { // vérifie si la tâche modifiée est retournée
      setState(() {
        _tasks[_tasks.indexWhere((element) => element.id == result.id)] = result; // remplace la tâche modifiée dans la liste
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Liste des tâches'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Tâches'),
              Tab(text: 'Paramètres'),
            ],
          ),

        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Dismissible(
                    key: Key(_tasks[index].id.toString()),
                    onDismissed: (direction) {
                      setState(() {
                        _tasks.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tâche supprimée'),
                        ),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                    ),
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(8.0),
                      child: ListTile(
                        title: Text(
                          _tasks[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(_tasks[index].description),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _navigateToTaskDetailScreen(context, _tasks[index]);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            EcranSettings(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToAddTaskScreen(context);
          },
          tooltip: 'Ajouter une tâche',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
