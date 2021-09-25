import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rimawification/components/navdrawer.dart';
import 'package:rimawification/models/task.dart';
import 'package:rimawification/pages/todo/create-task-page.dart';
import 'package:rimawification/pages/todo/task-page.dart';
import 'package:rimawification/pages/todo/task.dart';
import 'package:rimawification/requests.dart';
import 'package:rimawification/themes/ColorsList.dart';

main(List<String> args) {
  print(Task_obj.All_Tasks);
}

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late Future<List<Task_obj>> futureTask;

  @override
  void initState() {
    //todo:6=====================
    //1-fetch list of courses to display
    //courses= fetchedCourses
    //2-sort them into categories so bseer we have a list that has lists which contain courses
    //listCourses= lists of courses based on category
    //======================
    print("loading tasks");

    futureTask = Task_obj.loadTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NewTaskPage();
              },
            ),
          );
        },
      ),
      drawer: NavDrawer(),
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          "Tasks",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Expanded(
            child: FutureBuilder(
          builder: (context, taskSnap) {
            if (taskSnap.connectionState == ConnectionState.none &&
                taskSnap.hasData == null) {
              //print('project snapshot data is: ${projectSnap.data}');
              return Container();
            }
            print(taskSnap.data);
            return RefreshIndicator(
              onRefresh: () {
                setState(() {
                  futureTask = Task_obj.loadTasks();
                });

                return futureTask;
              },
              child: ListView.builder(
                itemCount: Task_obj.All_Tasks.length,
                itemBuilder: (context, index) {
                  Task_obj task = Task_obj.All_Tasks[index];

                  return Slidable(
                    dismissal: SlidableDismissal(
                      key: Key(task.title),
                      child: SlidableDrawerDismissal(),
                      onDismissed: (actionType) async {
                        if (actionType == SlideActionType.primary) {
                          await updateArchiveTask(task.id, !task.archived);

                          final snackBar = SnackBar(
                            content: Text(
                              'Task Archived!',
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Jarvis Alert!"),
                                  content: Text(
                                      "Sir,\nAre you sure you want to permanently delete this task?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          final snackBar = SnackBar(
                                            content: Text(
                                              'Task was not deleted!',
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text("No")),
                                    TextButton(
                                        onPressed: () async {
                                          await deleteTask(task.id);

                                          final snackBar = SnackBar(
                                            content: Text(
                                              'Task Deleted!',
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);

                                          Navigator.of(context).pop(true);
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
                        icon: Icons.archive,
                        color: task.color,
                        onTap: () async {
                          await updateArchiveTask(task.id, !task.archived);

                          final snackBar = SnackBar(
                            content: Text(
                              'Task Archived!',
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                                      "Sir,\nAre you sure you want to permanently delete this task?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          final snackBar = SnackBar(
                                            content: Text(
                                              'Task was not deleted!',
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text("No")),
                                    TextButton(
                                        onPressed: () async {
                                          await deleteTask(task.id);

                                          final snackBar = SnackBar(
                                            content: Text(
                                              'Task Deleted!',
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);

                                          Navigator.of(context).pop(true);
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
                    child: Task(
                        title: task.title,
                        description: task.description,
                        color: task.color,
                        id: task.id),
                  );

                  // return Container(
                  //   // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  //   child: Dismissible(
                  //     background: Container(
                  //       padding: EdgeInsets.only(left: 50),
                  //       child: Icon(Icons.archive),
                  //       color: ColorsList.blueGrey,
                  //       alignment: Alignment.centerLeft,
                  //     ),
                  //     secondaryBackground: Container(
                  //       padding: EdgeInsets.only(right: 50),
                  //       child: Icon(Icons.delete),
                  //       color: ColorsList.blueGrey,
                  //       alignment: Alignment.centerRight,
                  //     ),
                  //     onDismissed: (direction) async {
                  //       if (direction == DismissDirection.startToEnd) {
                  // await archiveTask(task.id, !task.archived);
                  //         final snackBar = SnackBar(
                  //           content: Text("Archived!"),
                  //           action: SnackBarAction(
                  //             label: 'Undo',
                  //             onPressed: () {
                  //               // Some code to undo the change.
                  //             },
                  //           ),
                  //         );
                  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //       } else {
                  //         showDialog(
                  //           context: context,
                  //           builder: (context) {
                  //             return AlertDialog(
                  //               title: Text('Jarvis Alert!'),
                  //               content: Text(
                  //                   'Are you sure you want to permanently delete this task?'),
                  //               actions: [
                  //                 TextButton(
                  //                   child: Text('No'),
                  //                   onPressed: () {
                  //                     final snackBar = SnackBar(
                  //                       content: Text("Was not Deleted!"),
                  //                       action: SnackBarAction(
                  //                         label: 'Undo',
                  //                         onPressed: () {
                  //                           // Some code to undo the change.
                  //                         },
                  //                       ),
                  //                     );
                  //                     ScaffoldMessenger.of(context)
                  //                         .showSnackBar(snackBar);
                  //                     Navigator.pop(context);
                  //                     setState(() {});
                  //                   },
                  //                 ),
                  //                 TextButton(
                  //                   child: Text('Yes'),
                  //                   onPressed: () async {
                  //                     await deleteTask(task.id);
                  //                     final snackBar = SnackBar(
                  //                       content: Text("Deleted!"),
                  //                       action: SnackBarAction(
                  //                         label: 'Undo',
                  //                         onPressed: () {
                  //                           // Some code to undo the change.
                  //                         },
                  //                       ),
                  //                     );
                  //                     ScaffoldMessenger.of(context)
                  //                         .showSnackBar(snackBar);
                  //                     Navigator.pop(context);

                  //                     setState(() {
                  //                       Task_obj.All_Tasks.removeAt(index);
                  //                     });
                  //                   },
                  //                 )
                  //               ],
                  //             );
                  //           },
                  //         );
                  //       }
                  //     },
                  //     key: UniqueKey(),
                  //     child: Task(
                  //         title: task.title,
                  //         description: task.description,
                  //         color: task.color,
                  //         id: task.id),
                  //   ),
                  // );
                },
              ),
            );
          },
          future: futureTask,
        )),
      ),
    );
  }
}
