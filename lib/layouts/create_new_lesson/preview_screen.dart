import 'package:flutter/material.dart';
import 'package:masterapplication/components/lesson_weidget.dart';
import 'package:masterapplication/models/lesson_model.dart';

class PreviewScreen extends StatelessWidget {
  PreviewScreen({Key? key, required this.title, required this.lessons})
      : super(key: key);
  final String title;
  final List<LessonModel> lessons;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => lessonWidget(lessons[index]),
          itemCount: lessons.length,
        ),
      ),
    );
  }
}
