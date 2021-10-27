import 'package:flutter/material.dart';
import 'package:rimawification/pages/ideas/ideas-page.dart';
import 'package:rimawification/pages/subscriptions/subscriptions.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final drawerItems = ListView(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(),
        ),
        ListTile(
          title: Text("Tasks"),
          leading: const Icon(Icons.auto_awesome_sharp),
          onTap: () {
            Navigator.pop(context);
            // Navigator.pop(context)
            Navigator.pushNamed(context, '/tasks');
          },
        ),
        ListTile(
          title: Text("Subscription"),
          leading: const Icon(Icons.credit_card),
          onTap: () {
            Navigator.pop(context);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => subscriptionsPage()),
            );
          },
        ),
        ListTile(
          title: Text("Ideas"),
          leading: const Icon(Icons.lightbulb_outline),
          onTap: () {
            Navigator.pop(context);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IdeasPage()),
            );
          },
        ),
        ListTile(
          title: Text("Reminder"),
          leading: const Icon(Icons.alarm_on_sharp),
          onTap: () {
            Navigator.pop(context);

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => subscriptionsPage()),
            // );
          },
        ),
        ListTile(
          title: Text("Contacts"),
          leading: const Icon(Icons.people_alt_outlined),
          onTap: () {
            Navigator.pop(context);

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => subscriptionsPage()),
            // );
          },
        ),
      ],
    );
    return Drawer(
      child: drawerItems,
    );
  }
}
