import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterapplication/components/lesson_builder.dart';
//import 'package:masterapplication/components/navigate.dart';
//import 'package:masterapplication/layouts/create_new_lesson/create_new_lesson.dart';
import 'package:masterapplication/layouts/main_screen/cubit/main_cubit.dart';
import 'package:masterapplication/layouts/main_screen/cubit/main_state.dart';

class AnalysisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          MainCubit bloc = MainCubit.get(context);
          return Scaffold(
            //drawer: NavigationDrawerWidget(),
            appBar: AppBar(
              title: Text('تحليل قواعد البيانات وتمثيلها بصرياً'),
              centerTitle: true,
              automaticallyImplyLeading: false,
              //backgroundColor: Colors.green,
             // actions: [
              //  if (bloc.currentUserModel!.isAdmin)
              //    IconButton(
              //        onPressed: () => navigateTo(
              //            context,
               //           CreateNewLessonScreen(
               //             mainCubit: bloc,
                //            type: "1",
                //            order: bloc.analyzeDatabaseLessons.isEmpty
                 //               ? 1
                 //               : (bloc.analyzeDatabaseLessons.last.order! + 1),
                  //        )),
                  //    icon: Icon(Icons.add))
              //],
            ),
            body: state is GetAllLessonLoadingState
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: bloc.analyzeDatabaseLessons.length,
                      itemBuilder: (context, index) => lessonBuilder(
                          context,
                          bloc.analyzeDatabaseLessons[index],
                          MainCubit.get(context).currentUserModel!),
                    ),
                  ),
            //body: Center(child: Text('design', style: TextStyle(fontSize: 60)))
          );
        },
      );
}
