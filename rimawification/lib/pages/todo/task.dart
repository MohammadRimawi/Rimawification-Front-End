import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:rimawification/models/task.dart';
import 'package:rimawification/themes/ColorsList.dart';
import 'dart:math';

import 'package:rimawification/pages/todo/task-page.dart';
import 'package:rimawification/themes/ColorsList.dart';

class Task extends StatefulWidget {
  final String title;
  final String description;
  final Color color;
  final int id;
  final bool compact;

  Task(
      {Key? key,
      this.id = -1,
      this.title = "Unnamed Task",
      this.description = "No description",
      this.color = ColorsList.cyan,
      this.compact = false})
      : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: widget.compact ? 5 : 10),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: OpenContainer(
          // closedColor: Colors.transparent,
          closedBuilder: (context, action) {
            return Container(
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: widget.compact ? 70 : 120,
                    // height: 120,
                    color: widget.color,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: widget.compact ? 20 : 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Container(
                        // height: 50,
                        width: 300,
                        child: widget.description.isEmpty || widget.compact
                            ? null
                            : Text(
                                widget.description.substring(0,
                                        min(widget.description.length, 120)) +
                                    (widget.description.length > 120
                                        ? "..."
                                        : ""),
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          openBuilder: (context, action) {
            return TaskPage(
              task_id: widget.id,
            );
          },
        ),
      ),
    );
  }
}
