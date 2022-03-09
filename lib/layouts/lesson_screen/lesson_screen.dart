import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterapplication/layouts/lesson_screen/comment_page.dart';
import 'package:masterapplication/layouts/lesson_screen/lesson_page.dart';
import 'package:masterapplication/layouts/lesson_screen/upload_screen.dart';
import 'package:masterapplication/models/lesson_model.dart';
import 'package:masterapplication/models/user_model.dart';

import '../../main.dart';
import 'all_user_upload_screen.dart';
import 'cubit/lesson_cubit.dart';

class LessonScreen extends StatefulWidget {
  LessonScreen(this.lessonModel, this.user, {Key? key}) : super(key: key) {
    screens.add(lessonPage(lessonModel));
    screens.add(CommentPage(lessonModel.lessonId!, user));
    print(lessonModel.lessonId!);
    MyApp.analytics.logEvent(
        name: lessonModel.lessonId!, parameters: {'name': user.fullName});
    if (!user.isAdmin) screens.add(UploadStream(user, lessonModel));
    screens.add(AllUserUploadScreen(lessonModel));
  }
  final LessonModel lessonModel;
  final List<Widget> screens = [];
  final UserModel user;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        LessonCubit lessonCubit = LessonCubit();
        lessonCubit.getAllLesson(widget.lessonModel.lessonId!);
        lessonCubit.openCommentStream(widget.lessonModel.lessonId!);
        if (!widget.user.isAdmin)
          lessonCubit.getAllUserFiles(
              lessonId: widget.lessonModel.lessonId!, userId: widget.user.id);
        else
          lessonCubit.getAllUploadedUser(
              lessonId: widget.lessonModel.lessonId!);
        return lessonCubit;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(widget.lessonModel.title!),
              titleSpacing: 0,
            ),
            body: widget.screens[index],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              backgroundColor: Colors.deepOrange[200],
              iconSize: 20,
              selectedFontSize: 16,
              unselectedFontSize: 10,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: index,
              onTap: (index) {
                setState(() {
                  this.index = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'الدرس',
                  backgroundColor: Colors.blue,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.comment),
                  label: 'الاستفسارات',
                  backgroundColor: Colors.blue,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.cloud_upload),
                  label: 'ارسال الاجابات/الانشطة',
                  backgroundColor: Colors.blue,
                ),
              ],
            )),
      ),
    );
  }
}
