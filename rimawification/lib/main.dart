import 'package:flutter/material.dart';
import 'package:rimawification/components/bottom-navbar.dart';
import 'package:rimawification/pages/home/home.dart';
import 'package:rimawification/pages/subscriptions/subscriptions.dart';
import 'package:rimawification/pages/todo/tasks-page.dart';

void main() => runApp(Align(
      alignment: Alignment.topLeft,
      child: Directionality(
        textDirection: TextDirection.ltr, //
        child: MaterialApp(
          theme: ThemeData(
            // brightness: Brightness.dark,
            primaryColorBrightness: Brightness.dark,

            primaryColor: Colors.blueGrey[900], //AppColors.darkBlue,
            accentColor: Colors.blue[500], //AppColors.darkBlue,
            // fontFamily: 'TheSansArabic',
          ),

          // initialRoute: '/home',

          home: BottomNav(),

          routes: {
            // '/': (context) => Loading(),

            '/home': (context) => Home(),
            '/tasks': (context) => TasksPage(),
            '/subscriptions': (context) => subscriptionsPage(),

            // '/browse': (context) => Browse(),

            // '/profile': (context) => Profile(),

            // '/admin': (context) => Admin(),
          },
        ),
      ),
    ));
