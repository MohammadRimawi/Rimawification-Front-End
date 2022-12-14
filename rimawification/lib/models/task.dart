import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rimawification/pages/todo/task.dart';
import 'package:rimawification/requests.dart';
import 'package:rimawification/themes/ColorsList.dart';

class Todo_obj {
  final int id;
  final int task_id;
  final String label;
  final bool isChecked;
  final Color color;

  Todo_obj({
    this.id = -1,
    this.task_id = -1,
    this.label = "Unnamed Task!",
    this.isChecked = false,
    this.color = Colors.red,
  });

  factory Todo_obj.fromJson(Map<String, dynamic> json) {
    return Todo_obj(
      label: json['text'],
      isChecked: false,
      color: Colors.amber,
      task_id: json['task_id'],
      id: json['todo_id'],
    );
  }

  static Future<Map<String, dynamic>> loadTask(int task_id,
      {bool archived = false}) async {
    final response = await http.post(Uri.parse(
        'https://varla.rimawi.me/api/get/task/' +
            task_id.toString() +
            (archived ? "/1" : "")));

    return jsonDecode(response.body)['data'];
  }

  static Future<List<dynamic>> loadPinned() async {
    final response = await http
        .post(Uri.parse('https://varla.rimawi.me/api/get/pinned_todos'));
    // print(jsonDecode(response.body)['data']);
    return jsonDecode(response.body)['data'];
  }
}

class Task_obj {
  final int id;
  final String title;
  final String description;
  final Color color;
  final bool archived;
  Task_obj({
    this.id = -1,
    this.title = "Unnamed Task!",
    this.description = "No description",
    this.color = Colors.red,
    this.archived = false,
  });

  static List<Task_obj> All_Tasks = [];

  // static Future<http.Response> getTasks() async {
  //   return http.post(
  //     Uri.parse('http://192.168.1.18:5001/api/get/all_tracks'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );
  // }

  factory Task_obj.fromJson(Map<String, dynamic> json) {
    // print();
    // Color c = ColorsMap.val['red'];
    // print(c);

    return Task_obj(
      title: json['title'],
      description: json['description'],
      color: ColorsMap.val[json['color']],
      id: json['task_id'],
      archived: json['archived'] == 1,
    );
  }

  static Future<List<Task_obj>> loadTasks({bool archived = false}) async {
    All_Tasks = [];
    final response = await http.post(Uri.parse(
        'https://varla.rimawi.me/api/get/tasks' + (archived ? "/1" : "")));

    if (response.statusCode == 200) {
      var Tasks = jsonDecode(response.body);
      for (var task in Tasks['data']) {
        print(task);
        All_Tasks.add(Task_obj.fromJson(task));
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Tasks');
    }
    return All_Tasks;
  }
}
