import 'package:flutter/material.dart';
import 'package:rimawification/components/navdrawer.dart';
import 'package:rimawification/themes/ColorsList.dart';

class IdeasPage extends StatefulWidget {
  const IdeasPage({Key? key}) : super(key: key);

  @override
  _IdeasPageState createState() => _IdeasPageState();
}

class _IdeasPageState extends State<IdeasPage> {
  var data = [
    {
      "title": "TTS integration",
      "description": "lorem ipsum dolar set amet.",
      "color": "red",
    },
    {
      "title": "TTS integration",
      "description": "lorem ipsum dolar set amet.",
      "color": "blue",
    },
    {
      "title": "TTS integration",
      "description": "lorem ipsum dolar set amet.",
      "color": "cyan",
    },
    {
      "title": "TTS integration",
      "description": "lorem ipsum dolar set amet.",
      "color": "red",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ideas"),
        centerTitle: true,
      ),
      body: Center(
          child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow()],
            ),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: ListTile(
              title: Text(
                data[index]['title']!,
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(data[index]['description']!),
            ),
          );
        },
      )),
      drawer: NavDrawer(),
    );
  }
}
