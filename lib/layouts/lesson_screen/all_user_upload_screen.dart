import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterapplication/Widgets/student_tale.dart';
import 'package:masterapplication/layouts/lesson_screen/upload_screen.dart';
import 'package:masterapplication/models/lesson_model.dart';

import 'cubit/lesson_cubit.dart';
import 'cubit/lesson_state.dart';

class AllUserUploadScreen extends StatelessWidget {
  AllUserUploadScreen(this.lessonModel, {Key? key}) : super(key: key);
  final LessonModel lessonModel;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<LessonCubit, LessonState>(
      builder: (context, state) {
        var bloc = LessonCubit.get(context);
        print(bloc.uploadedUser.length);
        return Scaffold(
          body: Container(
            color: Color(0xff2296F3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 55),
                  child: Text(
                    'كل الواجبات',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      )),
                  height: height * .7,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        studentTale(bloc.uploadedUser[index], onClick: () {
                      showBottomSheet(
                          context: context,
                          builder: (context) {
                            bloc.getAllUserFiles(
                                lessonId: lessonModel.lessonId!,
                                userId: bloc.uploadedUser[index].id);
                            return UploadStream(
                              bloc.uploadedUser[index],
                              lessonModel,
                              showOnly: true,
                            );
                          });
                    }),
                    itemCount: bloc.uploadedUser.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
