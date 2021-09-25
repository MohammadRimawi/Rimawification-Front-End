import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rimawification/requests.dart';
import 'package:rimawification/themes/ColorsList.dart';

class TodoCheckBox extends StatefulWidget {
  final id;
  final String label;
  final bool isChecked;
  final Color color;
  final bool archived;
  const TodoCheckBox({
    Key? key,
    this.id = -1,
    this.label = "Unnamed Todo",
    this.isChecked = false,
    this.color = Colors.black,
    this.archived = false,
  }) : super(key: key);

  @override
  _TodoCheckBoxState createState() => _TodoCheckBoxState();
}

class _TodoCheckBoxState extends State<TodoCheckBox> {
  bool _isChecked = false;
  final _textController = TextEditingController();
  bool _isEnabled = false;
  @override
  void initState() {
    _isChecked = this.widget.isChecked;
    _textController.text = this.widget.label;
    // _textController.
    super.initState();
  }

  void toggle() {
    _isChecked = !_isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          updateTodoChecked(widget.id, !_isChecked);
          toggle();
        });
      },
      onLongPress: () {
        setState(() {
          // this.;
          _isEnabled = true;
        });
      },
      child: Container(
        // color: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        decoration: BoxDecoration(),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 20),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: _isChecked ? null : Border.all(color: Colors.grey),
                color: _isChecked ? widget.color : null,
              ),
              child: _isChecked
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    )
                  : null,
            ),
            Expanded(
                child: TextField(
              controller: _textController,
              enabled: _isEnabled,
              maxLines: null,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(disabledBorder: InputBorder.none),
              onSubmitted: (value) async {
                await updateTodoText(widget.id, _textController.text);
                setState(() {
                  _isEnabled = false;
                });
              },
            ))
          ],
        ),
      ),
    );
  }
}
