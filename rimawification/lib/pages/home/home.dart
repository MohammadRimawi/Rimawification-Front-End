// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:rimawification/components/navdrawer.dart';
import 'package:rimawification/models/task.dart';
import 'package:http/http.dart' as http;
import 'package:rimawification/requests.dart';

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
  @override
  void initState() {
    // Task_obj.loadTasks();

    //todo:6=====================
    //1-fetch list of courses to display
    //courses= fetchedCourses
    //2-sort them into categories so bseer we have a list that has lists which contain courses
    //listCourses= lists of courses based on category
    //======================

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Jarvis",
        ),
        centerTitle: true,
      ),
      body: Center(child: Text("hello")),
      drawer: NavDrawer(),
    );
  }
}
