import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterapplication/Widgets/fileTale.dart';
import 'package:masterapplication/layouts/lesson_screen/cubit/lesson_cubit.dart';
import 'package:masterapplication/layouts/lesson_screen/cubit/lesson_state.dart';
import 'package:masterapplication/models/lesson_model.dart';
import 'package:masterapplication/models/user_model.dart';

class UploadStream extends StatelessWidget {
  UploadStream(this.userModel, this.lessonModel,
      {Key? key, this.showOnly = false})
      : super(key: key);
  final showOnly;
  final UserModel userModel;
  final LessonModel lessonModel;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<LessonCubit, LessonState>(
      listener: (context, state) {
        if (state is UploadErrorState) {
          final snackBar = SnackBar(content: Text(state.error));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var bloc = LessonCubit.get(context);
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
                    ' ارسال اجابات الاسئلة/الانشطة',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 40, right: 20, left: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        )),
                    height: height * .7,
                    child: state is GetFilesLoadingState
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                fileTale(bloc.files[index]),
                            itemCount: bloc.files.length,
                          ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: showOnly
              ? null
              : FloatingActionButton(
                  onPressed: () => LessonCubit.get(context).uploadFile(
                      lessonId: lessonModel.lessonId!, userId: userModel.id),
                  child: Icon(
                    Icons.upload_rounded,
                  ),
                ),
        );
      },
    );
  }
}
