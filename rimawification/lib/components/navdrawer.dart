import 'package:flutter/material.dart';
import 'package:rimawification/pages/subscriptions/subscriptions.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Colors.cyan[900],
      ),
      accountName: Text("محمد الريماوي"),
      accountEmail: Text("Mohrimawiz@gmail.com"),
      //     onDetailsPressed: () {
      //       showDialog<String>(
      //         context: context,
      //         builder: (BuildContext context) => SimpleDialog(
      //           title: const Text('Dialog Title'),
      //           children: <Widget>[
      //             ListTile(
      //               leading: const Icon(Icons.account_circle),
      //               title: const Text('user@example.com'),
      //               onTap: () => Navigator.pop(context, 'user@example.com'),
      //             ),
      //             ListTile(
      //               leading: const Icon(Icons.account_circle),
      //               title: const Text('user2@gmail.com'),
      //               onTap: () => Navigator.pop(context, 'user2@gmail.com'),
      //             ),
      //             ListTile(
      //               leading: const Icon(Icons.add_circle),
      //               title: const Text('Add account'),
      //               onTap: () => Navigator.pop(context, 'Add account'),
      //             ),
      //           ],
      //         ),
      //       ).then((returnVal) {

      //       });
      //     },
      //     otherAccountsPictures: [
      //       InkWell(
      //         child: CircleAvatar(
      //           backgroundColor: Colors.white,
      //           child: Text('LS'),
      //         ),
      //         onTap: () {},
      //       ),
      //       InkWell(
      //         child: CircleAvatar(
      //           backgroundColor: Colors.white,
      //           child: Text('MA'),
      //         ),
      //         onTap: () {},
      //       )
      //     ],
      //     currentAccountPicture: InkWell(
      //       onTap: () {
      //         Navigator.pop(context);
      //         // Navigator.pushNamed(context, '/profile');
      //       },
      //       child: CircleAvatar(
      //         backgroundColor: Colors.white,
      //         child: Text('MR'),
      //       ),
      // )
    );
    final drawerItems = ListView(
      children: [
        drawerHeader,
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
        // ExpansionTile(
        //     // expandedCrossAxisAlignment: CrossAxisAlignment.start,
        //     title: Text("مؤسساتي"),
        //     leading: const Icon(Icons.business),
        //     children: [
        //       ListTile(
        //         title: Text("جامعة الاميرة سمية للتكنولوجيا"),
        //         leading: CircleAvatar(
        //           backgroundColor: Colors.white,
        //           child: Text('MA'),
        //         ),
        //         onTap: () {
        //           Navigator.pop(context);
        //           // Navigator.push(
        //           //   context,
        //           //   MaterialPageRoute(builder: (context) => Institution()),
        //           // );
        //         },
        //       ),
        //       ListTile(
        //         title: Text("العمل"),
        //         leading: CircleAvatar(
        //           backgroundColor: Colors.white,
        //           child: Text('MA'),
        //         ),
        //         onTap: () {
        //           Navigator.pop(context);
        //           // Navigator.push(
        //           //   context,
        //           //   MaterialPageRoute(builder: (context) => Institution()),
        //           // );
        //         },
        //       ),
        //     ]),
        // Divider(),
        // ListTile(
        //   title: Text("إنشاء دورة جديدة"),
        //   leading: const Icon(Icons.school),
        //   onTap: () {
        //     // Navigator.push(
        //     //     context,
        //     //     MaterialPageRoute(
        //     //       builder: (context) => Step1(),
        //     //     ));
        //   },
        // ),
        // ListTile(
        //   title: Text("دوراتي"),
        //   leading: const Icon(Icons.public),
        //   onTap: () {
        //     // Navigator.push(
        //     //     context,
        //     //     MaterialPageRoute(
        //     //       builder: (context) => MyCourses(),
        //     //     ));
        //   },
        // ),
      ],
    );
    return Drawer(
      child: drawerItems,
    );
  }
}
