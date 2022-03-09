import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masterapplication/Widgets/comment_bubble.dart';
import 'package:masterapplication/layouts/lesson_screen/cubit/lesson_cubit.dart';
import 'package:masterapplication/layouts/lesson_screen/cubit/lesson_state.dart';
import 'package:masterapplication/models/user_model.dart';

class CommentPage extends StatelessWidget {
  CommentPage(this.lessonUid, this.userModel, {Key? key}) : super(key: key);
  final String lessonUid;
  final controller = TextEditingController();
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonCubit, LessonState>(
      builder: (context, state) {
        List comments = LessonCubit.get(context).comments;
        var bloc = LessonCubit.get(context);
        return state is LoadingCommentsState
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => commentBubble(
                          comments[index],
                        ),
                        itemCount: comments.length,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.lightBlue,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 9,
                          ),
                          Expanded(
                            child: TextField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              controller: controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'أكتب استفسار ....',
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (controller.text.isNotEmpty)
                                bloc.insertComment(
                                    lessonId: lessonUid,
                                    name: userModel.fullName,
                                    comment: controller.text);
                              controller.clear();
                              FocusScope.of(context).unfocus();
                            },
                            child: Container(
                              height: 50.7,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 14),
                              //color: Colors.lightBlue,
                              child: Icon(
                                FontAwesomeIcons.paperPlane,
                                color: Colors.lightBlue,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
