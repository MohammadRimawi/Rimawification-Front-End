import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rimawification/models/task.dart';
import 'package:rimawification/pages/todo/task-page.dart';
import 'package:rimawification/pages/todo/task.dart';
import 'package:rimawification/pages/todo/todo-checkbox.dart';
import 'package:rimawification/requests.dart';
import 'package:rimawification/themes/ColorsList.dart';

class NewTaskPage extends StatefulWidget {
  NewTaskPage({Key? key}) : super(key: key);

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<String> _colorset = [];
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  // late Future<Map<String, dynamic>> futureTask;
  String _taskColor = "red";
  @override
  void initState() {
    // print("loading tasks");

    ColorsMap.val.keys.forEach((key) {
      _colorset.add(key);
    });

    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: ,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          int new_task_id = -1;

          await createTask(_titleController.text, _descriptionController.text,
                  color: _taskColor)
              .then((value) {
            new_task_id = value;
            print(value);
          });
          print(new_task_id);
          if (new_task_id == -1) {
            final snackBar = SnackBar(
              content: Text(
                'Task was not created!',
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            final snackBar = SnackBar(
              content: Text(
                'Task Created! ✨ ',
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return TaskPage(
                    task_id: new_task_id,
                  );
                },
              ),
            );
          }
        },
        child: Icon(Icons.check),
      ),
      body: SafeArea(
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: ColorsMap.val[_taskColor],
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    onSubmitted: (value) {
                      print("To be sent to DB");
                      // print(_descriptionController.text);
                    },
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: ColorsMap.val[_taskColor]),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: Colors.black26, fontWeight: FontWeight.normal),
                      hintText: "Enter Task Name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 20),
                  width: 25,
                  height: 25,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorsMap.val[_taskColor]),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                              title: Text("Colors"),
                              content: Container(
                                height: 300.0, // Change as per your requirement
                                width: 300.0, // Change as per your requirement
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _colorset.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return TextButton(
                                        onPressed: () async {
                                          _taskColor = _colorset[index];
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              decoration: BoxDecoration(
                                                  color: ColorsMap
                                                      .val[_colorset[index]],
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              height: 25,
                                              width: 25,
                                            ),
                                            Text(_colorset[index]),
                                          ],
                                        ));
                                  },
                                ),
                              )));
                      // setState(() {});
                    },
                    child: null,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: TextField(
                        controller: _descriptionController,
                        onSubmitted: (value) {
                          print("To be sent to DB");
                          print(_descriptionController.text);
                        },
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.normal),
                          hintText: "Enter Task Description ",
                          border: InputBorder.none,
                        ),
                      )),
                ],
              ),
            )
          ]))),
    );
  }
}
