import 'package:flutter/gestures.dart';
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
  bool archived = false;
  bool compact = false;

  @override
  void initState() {
    //todo:6=====================
    //1-fetch list of courses to display
    //courses= fetchedCourses
    //2-sort them into categories so bseer we have a list that has lists which contain courses
    //listCourses= lists of courses based on category
    //======================
    print("loading tasks");

    futureTask = Task_obj.loadTasks(archived: archived);
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
        actions: [
          IconButton(
            icon: compact
                ? Icon(Icons.calendar_view_day_rounded)
                : Icon(Icons.calendar_view_day_sharp),
            tooltip: compact ? 'Expand' : 'Compact',
            onPressed: () {
              setState(() {
                compact = !compact;
              });
            },
          ),
          IconButton(
            icon: archived
                ? Icon(Icons.outbox_sharp)
                : Icon(Icons.outbox_outlined),
            tooltip: archived ? 'Hide Archived' : 'Show Archived',
            onPressed: () {
              setState(() {
                archived = !archived;
                futureTask = Task_obj.loadTasks(archived: archived);
              });
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Expanded(
            child: FutureBuilder(
          builder: (context, taskSnap) {
            if (taskSnap.connectionState == ConnectionState.none &&
                taskSnap.hasData == null) {
              return Container();
            }
            print(taskSnap.data);
            return RefreshIndicator(
              onRefresh: () {
                setState(() {
                  futureTask = Task_obj.loadTasks(archived: archived);
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
                        icon: task.archived ? Icons.unarchive : Icons.archive,
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
                      id: task.id,
                      compact: compact,
                    ),
                  );
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
