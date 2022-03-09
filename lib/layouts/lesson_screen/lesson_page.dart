import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterapplication/layouts/lesson_screen/cubit/lesson_cubit.dart';
import 'package:masterapplication/layouts/lesson_screen/cubit/lesson_state.dart';
import 'package:masterapplication/models/lesson_model.dart';
import 'cubit/lesson_cubit.dart';

Widget lessonPage(LessonModel lessonModel) {
  return BlocBuilder<LessonCubit, LessonState>(
    builder: (context, state) {
      var bloc = LessonCubit.get(context);

      return state is GetAllLessonsLoadingState
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: bloc.lessonsWidget,
              ),
            );
    },
  );
}
