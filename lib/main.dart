import 'package:flulearn/object_tile_widget.dart';
import 'package:flulearn/object_label_widget.dart';
import 'package:flulearn/label_text_widget.dart';
import 'package:flulearn/text_with_box_widget.dart';
import 'package:flutter/material.dart';
// import 'dart:developer';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = ['President Joko', 'PM Lee', 'Label 3'];
    String labelText =
        'President Joko Widodo dan Perdana Menteri Singapura Lee Hsien Loong akan bertemu di Bintan. Mereka mau meresmikan pembukaan pariswisata perbatasan. Jokowi sudah siap sambut PM Lee.';

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('NLP Demo'),
          ),
          body: Column(
            children: [
              // Container(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Text(
              //       labelText,
              //       style: TextStyle(fontSize: 30)),
              // ),
              // LabelableText(text: labelText),
              MySelectableText(text: labelText),
              // SizedBox(
              //     height: 200,
              //     child: ListView.builder(
              //       itemCount: items.length,
              //       itemBuilder: (context, index) {
              //         return ListTile(
              //           title: Text(items[index]),
              //         );
              //       },
              //     )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ObjectTileWidget(
                    labelName: 'President Joko', onClick: () {}, onDelete: () {}),
              )
            ],
          )),
    );
  }
}
