import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/task.dart';

class MyAPI{

  Future<List<Task>> getTasks() async{
    await Future.delayed(Duration(seconds: 1));
    debugPrint("avant load");
    final dataString = await _loadAsset('assets/mydata/tasks.json');
    debugPrint("apres load");
    final Map<String,dynamic> json = jsonDecode(dataString);
    if (json['tasks']!=null){
      final tasks = <Task>[];
      json['tasks'].forEach((element){
        tasks.add(Task.fromJson(element));
      });
      return tasks;
    }else{
      return [];
    }
  }

  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }

}