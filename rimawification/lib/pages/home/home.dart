// import 'dart:html';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rimawification/components/navdrawer.dart';
import 'package:rimawification/models/task.dart';
import 'package:http/http.dart' as http;
import 'package:rimawification/pages/todo/todo-checkbox.dart';
import 'package:rimawification/requests.dart';
import 'package:rimawification/themes/ColorsList.dart';

main(List<String> args) {
  // Task_obj.loadTasks();
  // await Task_obj.loadTasks();
  // print("hello?");
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<dynamic>> futureTask;
  bool archived = false;
  bool _reoderable = false;
  Color _taskColor = Colors.black;
  @override
  void initState() {
    // Task_obj.loadTasks();

    //todo:6=====================
    //1-fetch list of courses to display
    //courses= fetchedCourses
    //2-sort them into categories so bseer we have a list that has lists which contain courses
    //listCourses= lists of courses based on category
    //======================
    futureTask = Todo_obj.loadPinned();
    // print(futureTas);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
            child: Text(
              "Pinned Todos",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return futureTask = Todo_obj.loadPinned();
              },
              child: FutureBuilder(
                future: futureTask,
                builder: (context, taskSnap) {
                  if (taskSnap.connectionState == ConnectionState.none &&
                      taskSnap.hasData == null) {
                    return Container();
                  }
                  var data = jsonDecode(jsonEncode(taskSnap.data));

                  if (data == null) {
                    return Container();
                  }

                  if (_reoderable) {
                    return ReorderableListView.builder(
                        anchor: 0,
                        onReorder: (oldIndex, newIndex) {},
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return TodoCheckBox(
                            key: UniqueKey(),
                            id: data[index]['todo_id'],
                            color: _taskColor,
                            isChecked:
                                data[index]['checked'] == 1 ? true : false,
                            label: data[index]['text'],
                            archived:
                                data[index]['archived'] == 1 ? true : false,
                            reorderMode: this._reoderable,
                          );
                          // return
                        });
                  } else {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            dismissal: SlidableDismissal(
                              key: Key(data[index]['text']),
                              child: SlidableDrawerDismissal(),
                              onDismissed: (actionType) async {
                                if (actionType == SlideActionType.primary) {
                                  updateTodoArchive(data[index]['todo_id'],
                                      !(data[index]['archived'] == 1));
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Todo Archived!',
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Jarvis Alert!"),
                                          content: Text(
                                              "Sir,\nAre you sure you want to permanently delete this todo?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: Text("No")),
                                            TextButton(
                                                onPressed: () async {
                                                  await deleteTodo(
                                                      data[index]['todo_id']);
                                                  final snackBar = SnackBar(
                                                    content: Text(
                                                      'Todo Deleted!',
                                                    ),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                  data.removeAt(index);

                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                                child: Text("Yes")),
                                          ],
                                        );
                                      });
                                  setState(() {});
                                }
                              },
                            ),
                            actionPane: SlidableDrawerActionPane(),
                            actions: [
                              IconSlideAction(
                                icon: this.archived
                                    ? Icons.unarchive
                                    : Icons.archive,
                                color: _taskColor,
                                onTap: () async {
                                  await updateTodoArchive(
                                      data[index]['todo_id'],
                                      !(data[index]['archived'] == 1));
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Todo Archived!',
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  setState(() {});
                                },
                              ),
                            ],
                            secondaryActions: [
                              IconSlideAction(
                                icon: Icons.delete,
                                color: ColorsMap.val['red'],
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Jarvis Alert!"),
                                          content: Text(
                                              "Sir,\nAre you sure you want to permanently delete this todo?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: Text("No")),
                                            TextButton(
                                                onPressed: () async {
                                                  await deleteTodo(
                                                      data[index]['todo_id']);
                                                  final snackBar = SnackBar(
                                                    content: Text(
                                                      'Todo Deleted!',
                                                    ),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                  data.removeAt(index);

                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                                child: Text("Yes")),
                                          ],
                                        );
                                      });

                                  setState(() {});
                                },
                              ),
                            ],
                            key: UniqueKey(),
                            child: TodoCheckBox(
                              id: data[index]['todo_id'],
                              color: _taskColor,
                              isChecked:
                                  data[index]['checked'] == 1 ? true : false,
                              label: data[index]['text'],
                              archived:
                                  data[index]['archived'] == 1 ? true : false,
                              isPinned:
                                  data[index]['pinned'] == 1 ? true : false,
                            ),
                          );
                          // return
                        });
                  }
                },
              ),
            ),
          ),
        ],
      ),
      drawer: NavDrawer(),
    );
  }
}
