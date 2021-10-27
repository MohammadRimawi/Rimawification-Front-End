import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rimawification/models/task.dart';
import 'package:rimawification/pages/todo/task.dart';
import 'package:rimawification/pages/todo/todo-checkbox.dart';
import 'package:rimawification/requests.dart';
import 'package:rimawification/themes/ColorsList.dart';

class TaskPage extends StatefulWidget {
  final int task_id;
  TaskPage({Key? key, this.task_id = -1}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

bool _descExpanded = false;

class _TaskPageState extends State<TaskPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool archived = false;
  bool _reoderable = false;

  FocusNode _newTodoFoucsNode = new FocusNode();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _newTodoController = TextEditingController();

  late Future<Map<String, dynamic>> futureTask;
  List<String> _colorset = [];

  @override
  void initState() {
    print("loading tasks");
    super.initState();
    _controller = AnimationController(vsync: this);

    ColorsMap.val.keys.forEach((key) {
      _colorset.add(key);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Task_obj task = Task_obj();
    futureTask = Todo_obj.loadTask(widget.task_id, archived: archived);

    for (int i = 0; i < Task_obj.All_Tasks.length; i++) {
      if (Task_obj.All_Tasks[i].id == widget.task_id) {
        task = Task_obj.All_Tasks[i];
        break;
      }
    }

    Color _taskColor = task.color;

    if (widget.task_id != -1) {
      _titleController.text = task.title;
      _descriptionController.text = task.description;
    }
    // print(_tasktitle);

    return Scaffold(
      // bottomNavigationBar: ,

      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () async {
                    // futureTask = Todo_obj.loadTask(widget.task_id);

                    // setState(() {});
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: _taskColor,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    onSubmitted: (value) async {
                      print("To be sent to DB");
                      await updateTaskTitle(
                          widget.task_id, _titleController.text);
                      await Task_obj.loadTasks();
                      setState(() {});
                      // print(_descriptionController.text);
                    },
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: _taskColor),
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
                    style: ElevatedButton.styleFrom(primary: _taskColor),
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
                                          await updateTaskColor(
                                              widget.task_id, _colorset[index]);
                                          await Task_obj.loadTasks();

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
            Divider(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpansionTile(
                    title: _descExpanded
                        ? TextField(
                            controller: _descriptionController,
                            onSubmitted: (value) async {
                              await updateTaskDescription(
                                  widget.task_id, _descriptionController.text);
                              await Task_obj.loadTasks();

                              setState(() {});
                            },
                            keyboardType: TextInputType.text,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.normal),
                              hintText: "Enter Task Description ",
                              border: InputBorder.none,
                            ),
                          )
                        : Text(_descriptionController.text.substring(
                              0,
                              min(40, _descriptionController.text.length),
                            ) +
                            (_descriptionController.text.length > 40
                                ? "..."
                                : "")),
                    onExpansionChanged: (value) {
                      print(value);
                      setState(() {
                        _descExpanded = value;
                      });
                    },
                    children: [
                      // Padding(
                      //     padding: EdgeInsets.symmetric(
                      //         vertical: 10, horizontal: 20),
                      //     child: TextField(
                      //       controller: _descriptionController,
                      //       onSubmitted: (value) async {
                      //         await updateTaskDescription(
                      //             widget.task_id, _descriptionController.text);
                      //         await Task_obj.loadTasks();

                      //         setState(() {});
                      //       },
                      //       keyboardType: TextInputType.text,
                      //       maxLines: null,
                      //       decoration: InputDecoration(
                      //         hintStyle: TextStyle(
                      //             color: Colors.black26,
                      //             fontWeight: FontWeight.normal),
                      //         hintText: "Enter Task Description ",
                      //         border: InputBorder.none,
                      //       ),
                      //     )),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        color: _taskColor,
                        icon: Icon(Icons.add),
                        tooltip: 'add new text',
                        onPressed: () {
                          setState(() {
                            _newTodoFoucsNode.requestFocus();
                          });
                        },
                      ),
                      IconButton(
                        color: _taskColor,
                        icon: archived
                            ? Icon(Icons.outbox_sharp)
                            : Icon(Icons.outbox_outlined),
                        tooltip: archived ? 'Hide Archived' : 'Show Archived',
                        onPressed: () {
                          setState(() {
                            archived = !archived;
                            // futureTask = Todo_obj.loadTask(widget.task_id,
                            //     archived: archived);
                          });
                        },
                      ),
                      IconButton(
                        color: _taskColor,
                        icon: _reoderable
                            ? Icon(Icons.reorder)
                            : Icon(Icons.drag_handle),
                        tooltip:
                            _reoderable ? 'Hide Archived' : 'Show Archived',
                        onPressed: () {
                          setState(() {
                            _reoderable = !_reoderable;
                            // futureTask = Todo_obj.loadTask(widget.task_id,
                            //     archived: archived);
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return futureTask = Todo_obj.loadTask(widget.task_id,
                            archived: archived);
                      },
                      child: FutureBuilder(
                        future: futureTask,
                        builder: (context, taskSnap) {
                          if (taskSnap.connectionState ==
                                  ConnectionState.none &&
                              taskSnap.hasData == null) {
                            return Container();
                          }
                          var data = jsonDecode((jsonEncode(taskSnap.data)));

                          if (data == null) {
                            return Container();
                          }

                          if (_reoderable) {
                            return ReorderableListView.builder(
                                anchor: 0,
                                onReorder: (oldIndex, newIndex) {
                                  // var old = data!['todos'][oldIndex];
                                  // data!['todos'].removeAt(oldIndex);
                                  // data!['todos'].insert(
                                  //     min(newIndex,
                                  //         int.parse(data['todos'].length)),
                                  //     old);
                                },
                                itemCount: data['todos'].length,
                                itemBuilder: (context, index) {
                                  return TodoCheckBox(
                                    key: UniqueKey(),
                                    id: data['todos'][index]['todo_id'],
                                    color: _taskColor,
                                    isChecked:
                                        data['todos'][index]['checked'] == 1
                                            ? true
                                            : false,
                                    label: data['todos'][index]['text'],
                                    archived:
                                        data['todos'][index]['archived'] == 1
                                            ? true
                                            : false,
                                    isPinned:
                                        data['todos'][index]['pinned'] == 1
                                            ? true
                                            : false,
                                    reorderMode: this._reoderable,
                                  );
                                  // return
                                });
                          } else {
                            return ListView.builder(
                                itemCount: data['todos'].length,
                                itemBuilder: (context, index) {
                                  return Slidable(
                                    dismissal: SlidableDismissal(
                                      key: Key(data['todos'][index]['text']),
                                      child: SlidableDrawerDismissal(),
                                      onDismissed: (actionType) async {
                                        if (actionType ==
                                            SlideActionType.primary) {
                                          updateTodoArchive(
                                              data['todos'][index]['todo_id'],
                                              !(data['todos'][index]
                                                      ['archived'] ==
                                                  1));
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
                                                              data['todos']
                                                                      [index]
                                                                  ['todo_id']);
                                                          final snackBar =
                                                              SnackBar(
                                                            content: Text(
                                                              'Todo Deleted!',
                                                            ),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                          data['todos']
                                                              .removeAt(index);

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
                                        color: task.color,
                                        onTap: () async {
                                          await updateTodoArchive(
                                              data['todos'][index]['todo_id'],
                                              !(data['todos'][index]
                                                      ['archived'] ==
                                                  1));
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
                                                              data['todos']
                                                                      [index]
                                                                  ['todo_id']);
                                                          final snackBar =
                                                              SnackBar(
                                                            content: Text(
                                                              'Todo Deleted!',
                                                            ),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                          data['todos']
                                                              .removeAt(index);

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
                                      id: data['todos'][index]['todo_id'],
                                      color: _taskColor,
                                      isChecked:
                                          data['todos'][index]['checked'] == 1
                                              ? true
                                              : false,
                                      label: data['todos'][index]['text'],
                                      archived:
                                          data['todos'][index]['archived'] == 1
                                              ? true
                                              : false,
                                      isPinned:
                                          data['todos'][index]['pinned'] == 1
                                              ? true
                                              : false,
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
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      )),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            child: TextField(
              focusNode: _newTodoFoucsNode,
              controller: _newTodoController,
              onSubmitted: (value) async {
                int new_todo_id = -1;

                await createTodo(widget.task_id, _newTodoController.text)
                    .then((value) {
                  new_todo_id = value;
                  print(value);
                  // print(_descriptionController.text);
                });

                if (new_todo_id != -1) {
                  _newTodoController.text = "";
                  setState(() {});
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintStyle: TextStyle(
                    color: Colors.black26, fontWeight: FontWeight.normal),
                hintText: "Enter Todo",
                border: InputBorder.none,
              ),
            ),
            height: 50,
            width: double.infinity,
            // decoration: BoxDecoration(color: Colors.amber),
          );
        },
      ),
    );
  }
}
