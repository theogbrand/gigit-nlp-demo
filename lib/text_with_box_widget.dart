import 'dart:math';

import 'package:flutter/material.dart';

class MySelectableText extends StatefulWidget {
  final String text;

  const MySelectableText({Key? key, required this.text}) : super(key: key);

  @override
  _MySelectableTextState createState() => _MySelectableTextState();
}

class _MySelectableTextState extends State<MySelectableText> {
  late List<TextSpan> _textSpans;
  late TextSelection _textSelection;
  TextRange? _selectedTextRange;

  @override
  void initState() {
    super.initState();
    _textSpans = _getTextSpans();
  }

  List<TextSpan> _getTextSpans() {
    final String text = widget.text;
    final List<TextSpan> textSpans = [];

    final TextSpan defaultStyle = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.black,
      ),
    );

    textSpans.add(defaultStyle);

    return textSpans;
  }

  void _handleSelectionChanged(
      TextSelection selection, SelectionChangedCause cause) {
    print("selection changed!");

    setState(() {
      _textSelection = selection;
      _textSpans = _getTextSpans();
      if (_textSelection.baseOffset != -1 &&
          _textSelection.extentOffset != -1) {
        _selectedTextRange = TextRange(
          start: _textSelection.start,
          end: _textSelection.end,
        );
        // _addSelectionStyle();
      } else {
        _selectedTextRange = null;
      }
    });
  }

  void _addSelectionStyle() {
    final int baseOffset = _textSelection.baseOffset;
    final int extentOffset = _textSelection.extentOffset;
    final TextStyle selectedStyle = TextStyle(
      fontSize: 30.0,
      color: Colors.white,
      backgroundColor: Colors.deepOrange,
    );

    _textSpans = List.from(_textSpans.map((textSpan) {
      final String text = textSpan.text ?? '';
      final int start = 0;
      final int end = text.length;

      if (start >= extentOffset || end <= baseOffset) {
        // This text span is outside of the selection range
        return textSpan;
      }

      if (start >= baseOffset && end <= extentOffset) {
        // This text span is fully inside the selection range
        return TextSpan(
          text: text,
          style: selectedStyle,
        );
      }

      // This text span is partially inside the selection range
      final int newStart = start < baseOffset ? baseOffset - start : 0;
      final int newEnd =
          end > extentOffset ? extentOffset - start : end - start;
      final String selectedText = text.substring(newStart, newEnd);
      final String unselectedText1 = text.substring(0, newStart);
      final String unselectedText2 = text.substring(newEnd);

      return TextSpan(
        children: [
          TextSpan(text: unselectedText1),
          TextSpan(
            text: selectedText,
            style: selectedStyle,
          ),
          TextSpan(text: unselectedText2),
        ],
      );
    }));
  }

  void _handleHighlightButtonClick(String color) {
    if (_selectedTextRange != null) {
      setState(() {
        _addSelectionBox(color);
      });
    }
  }

  void _addSelectionBox(String colorName) {
    final int startOffset = _selectedTextRange!.start;
    final int endOffset = _selectedTextRange!.end;

    _textSpans = List.from(_textSpans.map((textSpan) {
      final String text = textSpan.text!;
      final int start = 0;
      final int end = text.length;

      if (start >= endOffset || end <= startOffset) {
        // This text span is outside of the selection range
        return textSpan;
      }

      Color boxColor = Colors.white;

      switch(colorName) {
        case 'purple':
          boxColor = Colors.purple;
          break;
        case 'deepOrange':
          boxColor = Colors.deepOrange;
          break;
        case 'green':
          boxColor = Colors.green;
          break;
      }

      final BoxDecoration selectionDecoration = BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(5.0),
      );

      final List<InlineSpan> children = [];

      if (start < startOffset) {
        final String unselectedText = text.substring(0, startOffset - start);
        children.add(TextSpan(text: unselectedText));
      }

      final String selectedText = text.substring(
        max(startOffset - start, 0),
        min(endOffset - start, text.length),
      );

      children.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            decoration: selectionDecoration,
            child: Text(
              selectedText,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

      if (end > endOffset) {
        final String unselectedText = text.substring(endOffset - start);
        children.add(TextSpan(text: unselectedText));
      }

      return TextSpan(children: children);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SelectableText.rich(TextSpan(children: _textSpans),
              showCursor: true,
              cursorWidth: 5,
              cursorRadius: Radius.circular(5),
              toolbarOptions: ToolbarOptions(copy: false, selectAll: false),
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
              onSelectionChanged: ((selection, cause) => _handleSelectionChanged(
                    selection,
                    cause!,
                  ))),
        ),
        SizedBox(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10.0),
            child: const Text(
              'Group entities together',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => _handleHighlightButtonClick('deepOrange'),
          child: Text('President Joko'),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.deepOrange),
                minimumSize: MaterialStateProperty.all<Size>(Size(0.4, 50)),
          ),
        ),
        ElevatedButton(
          onPressed: () => _handleHighlightButtonClick('purple'),
          child: Text('PM Lee'),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.purple),
                minimumSize: MaterialStateProperty.all<Size>(Size(0.4, 50)),
          ),
        ),
        ElevatedButton(
          onPressed: () => _handleHighlightButtonClick('green'),
          child: Text('Country'),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.green),
                minimumSize: MaterialStateProperty.all<Size>(Size(0.4, 50)),
          ),
        ),
      ],
    );
  }
}
