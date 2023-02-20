import 'package:flutter/material.dart';
import 'dart:developer';

class LabelableText extends StatefulWidget {
  final String text;

  LabelableText({required this.text});

  @override
  _LabelableTextState createState() => _LabelableTextState();
}

class _LabelableTextState extends State<LabelableText> {
  String? _label;
  TextSelection? _selection;

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      widget.text,
      showCursor: true,
      cursorWidth: 5,
      cursorRadius: Radius.circular(5),
      toolbarOptions: ToolbarOptions(copy: false, selectAll: false),
      style: TextStyle(
        color: Colors.black,
        fontSize: 30,
      ),
      onTap: () {
        _showLabelDialog();
      },
      onSelectionChanged: (selection, cause) => _onSelectionChanged(
        selection,
        cause!,
      ),
    );
  }

  void _onSelectionChanged(
      TextSelection selection, SelectionChangedCause cause) {
    if (cause != SelectionChangedCause.longPress) {
      return;
    }
    setState(() {
      _selection = selection;
    });
    // _showLabelDialog();
  }

  void _showLabelDialog() async {
    if (_selection == null) {
      return;
    }
    final label = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String label = '';
        return AlertDialog(
          title: Text('Label this entity'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Enter label'),
            onChanged: (value) {
              label = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, label);
              },
            ),
          ],
        );
      },
    );
    if (label != null) {
      setState(() {
        _label = label;
        print(label);
        print(_selection!.textInside(widget.text));
        _selection = null;
      });
    }
  }
}
