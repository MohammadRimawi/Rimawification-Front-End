import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rimawification/models/task.dart';

//TODO make like others
Future<http.Response> fetchTasks(String method, String uri,
    {var data = null}) async {
  var response =
      await http.post(Uri.parse('http://rimawi.me:5050/api/get/tasks'));
  print(response);
  return response;
}

class REQUESTS {
  static Future<dynamic> GET(String endPoint, dynamic? data) async {
    // TODO uri payload parser
    if (data != null) data = jsonEncode(data);

    try {
      final response = await http.get(Uri.parse(endPoint));

      jsonDecode(response.body);
    } catch (err) {
      print(err);
      return err;
    }
  }

  static Future<dynamic> POST(String endPoint, dynamic? data) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'charset': 'UTF-8'
    };

    if (data != null) data = jsonEncode(data);

    try {
      final response =
          await http.post(Uri.parse(endPoint), body: data, headers: headers);

      if (response.statusCode < 400) {
        return jsonDecode(response.body);
      } else {
        return -1;
      }
    } catch (err) {
      print(err);
      return -1;
    }
  }

  static Future<dynamic> DELETE(String endPoint) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'charset': 'UTF-8'
    };

    try {
      final response = await http.delete(Uri.parse(endPoint), headers: headers);

      if (response.statusCode < 400) {
        return jsonDecode(response.body);
      } else {
        return -1;
      }
    } catch (err) {
      print(err);
      return -1;
    }
  }
}

/**************************[ Tasks ]**************************/
/*[ create ]***************/

Future<int> createTask(String title, String description,
    {String color = 'blue'}) async {
  final response = await REQUESTS.POST(
    'http://rimawi.me:5050/api/create/task',
    {
      'title': title.toString(),
      'description': description,
      'color': color,
    },
  );
  if (response != -1) {
    await Task_obj.loadTasks();
    print(response['data']['task_id']);
    return response['data']['task_id'];
  } else {
    return -1;
  }
}

/*[ get ]******************/

/*[ update ]***************/

Future<void> updateTaskColor(int task_id, String color) async {
  await REQUESTS.POST(
    'http://rimawi.me:5050/api/update/task/color',
    {'task_id': task_id.toString(), 'color': color},
  );
}

Future<void> updateTaskTitle(int task_id, String title) async {
  await REQUESTS.POST(
    'http://rimawi.me:5050/api/update/task/title',
    {'task_id': task_id.toString(), 'title': title},
  );
}

Future<void> updateTaskDescription(int task_id, String description) async {
  await REQUESTS.POST(
    'http://rimawi.me:5050/api/update/task/description',
    {'task_id': task_id.toString(), 'description': description},
  );
}

Future<void> updateArchiveTask(int task_id, bool state) async {
  await REQUESTS.POST(
    'http://rimawi.me:5050/api/update/task/archived',
    {'task_id': task_id.toString(), 'archived': state ? '1' : '0'},
  );
}

/*[ delete ]***************/

Future<void> deleteTask(int task_id) async {
  await REQUESTS.DELETE('http://rimawi.me:5050/api/delete/task/$task_id');
}

/**************************[ Todos ]**************************/
/*[ create ]***************/

Future<int> createTodo(int task_id, String text) async {
  final response = await REQUESTS.POST(
    'http://rimawi.me:5050/api/create/todo',
    {
      'task_id': task_id.toString(),
      'text': text,
    },
  );
  if (response != -1) {
    print(response['data']['todo_id']);
    return response['data']['todo_id'];
  } else {
    return -1;
  }
} //end of class

/*[ get ]******************/

/*[ update ]***************/

Future<void> updateTodoArchive(int todo_id, bool state) async {
  await REQUESTS.POST(
    'http://rimawi.me:5050/api/update/todo/archived',
    {'todo_id': todo_id.toString(), 'archived': state ? '1' : '0'},
  );
}

Future<void> updateTodoChecked(int todo_id, bool status) async {
  await REQUESTS.POST(
    'http://rimawi.me:5050/api/update/todo/checked',
    {'todo_id': todo_id.toString(), 'checked': status},
  );
}

Future<void> updateTodoText(int todo_id, String text) async {
  await REQUESTS.POST(
    'http://rimawi.me:5050/api/update/todo/text',
    {'todo_id': todo_id.toString(), 'text': text},
  );
}

/*[ delete ]***************/

Future<void> deleteTodo(int todo_id) async {
  await REQUESTS.DELETE('http://rimawi.me:5050/api/delete/todo/$todo_id');
}
