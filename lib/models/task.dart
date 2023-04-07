class Task {
  int id;
  String title;
  List<String> tags;
  int nbhours;
  int difficulty;
  String description;

  static int nb = 1;

  Task({required this.id,required this.title,required this.tags,required this.nbhours,required this.difficulty,required this.description});

  factory Task.newTask(){
    nb++;
    return Task(id: nb, title: 'Tâche n°$nb', tags: ['tags $nb'], nbhours: nb, difficulty: nb%5, description: 'description $nb');
  }

  factory Task.newTaskEdit(title, tags, nbhours, difficulty, description){
    nb++;
    return Task(id: nb, title: title, tags: [tags], nbhours: nbhours, difficulty: difficulty, description: description);
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    final tags = <String>[];

    if (json['tags'] != null){
      json['tags'].forEach((t){
        tags.add(t);
      });
    }

    return Task(
        id: json['id'],
        title: json['title'],
        tags: tags,
        nbhours: json['nbhours'],
        difficulty: json['difficulty'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    final tags = <String>[];
    this.tags.forEach((element) {tags.add(element);});

    data['id'] = id;
    data['title'] = title;
    data['tags'] = tags;
    data['nbhours'] = nbhours;
    data['difficulty'] = difficulty;
    data['description'] = description;
    return data;
  }

  static List<Task> generateTask(int i){
    /*List<Task> tasks=[];
    for(int n=0;n<i;n++){
      tasks.add(Task(id: n, title: "title $n", tags: ['tag $n','tag ${n+1}'], nbhours: n, difficulty: n, description: '$n'));
    }
    return tasks;*/
    nb =49;
    return List.generate(
        50,
        (index) => Task(id: index, title: 'Tâche n°$index', tags: ['tag $index','tag ${index +1}'], nbhours: index, difficulty: index, description: 'Description tâche $index'),
    );
  }
}
