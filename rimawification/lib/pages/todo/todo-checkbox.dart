import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rimawification/requests.dart';
import 'package:rimawification/themes/ColorsList.dart';

class TodoCheckBox extends StatefulWidget {
  final id;
  final String label;
  final bool isChecked;
  late bool isPinned;
  final Color color;
  final bool archived;
  final bool reorderMode;
  TodoCheckBox({
    Key? key,
    this.id = -1,
    this.label = "Unnamed Todo",
    this.isChecked = false,
    this.isPinned = false,
    this.color = Colors.black,
    this.archived = false,
    this.reorderMode = false,
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
    return Row(
      children: [
        Expanded(
          child: InkWell(
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
                    decoration: !widget.reorderMode
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: _isChecked
                                ? null
                                : Border.all(color: Colors.grey),
                            color: _isChecked ? widget.color : null,
                          )
                        : null,
                    child: !widget.reorderMode
                        ? (_isChecked
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              )
                            : null)
                        : Icon(
                            Icons.drag_handle,
                            color: widget.color,
                          ),
                  ),
                  Expanded(
                      child: TextField(
                    controller: _textController,
                    enabled: _isEnabled && !widget.reorderMode,
                    maxLines: null,
                    keyboardType: TextInputType.text,
                    decoration:
                        InputDecoration(disabledBorder: InputBorder.none),
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
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: TextButton(
            style: widget.isPinned
                ? TextButton.styleFrom(primary: Colors.amber)
                : TextButton.styleFrom(primary: widget.color),
            child: widget.isPinned ? Icon(Icons.star) : Icon(Icons.star_border),
            onPressed: () async {
              await updateTodoPinned(widget.id, !widget.isPinned);
              setState(() {
                widget.isPinned = !widget.isPinned;
              });
            },
          ),
        )
      ],
    );
  }
}
