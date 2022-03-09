import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterapplication/Widgets/inputField.dart';
import 'package:masterapplication/components/navigate.dart';
import 'package:masterapplication/layouts/create_new_lesson/preview_screen.dart';
import 'package:masterapplication/layouts/main_screen/cubit/main_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'cubit/create_lesson_cubit.dart';
import 'cubit/create_lesson_state.dart';

class CreateNewLessonScreen extends StatelessWidget {
  CreateNewLessonScreen({
    Key? key,
    required this.type,
    required this.order,
    required this.mainCubit,
  }) : super(key: key) {
    orderController.text = order.toString();
    typeController.text = type.toString();
  }

  final String type;
  final int order;
  final MainCubit mainCubit;
  final TextEditingController idController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  final TextEditingController orderController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => CreateLessonCubit(),
        child: BlocConsumer<CreateLessonCubit, CreateLessonState>(
          listener: (context, state) {
            if (state is InsertLessonSuccessState) {
              mainCubit.getAllLessons();
              Navigator.pop(context);
            } else if (state is InsertLessonErrorState) {
              final snackBar = SnackBar(
                content: Text(state.error),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            var bloc = CreateLessonCubit.get(context);
            return ModalProgressHUD(
              inAsyncCall: bloc.isLoading,
              child: Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Text('درس جديد'),
                  actions: [
                    TextButton(
                      child: Text(
                        'عرض',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        navigateTo(
                          context,
                          PreviewScreen(
                            title: titleController.text,
                            lessons: bloc.convertToLessonModel(),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: IconButton(
                        icon: Icon(
                          Icons.upload_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          bloc.insertData(
                            mainCubit,
                            text: textController.text,
                            image: imageController.text,
                            id: idController.text,
                            order: orderController.text,
                            title: titleController.text,
                            type: typeController.text,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 8),
                          child: Column(
                            children: [
                              InputFieldWithText(
                                text: 'الاي دي',
                                controller: idController,
                              ),
                              InputFieldWithText(
                                text: 'عنوان الدرس',
                                controller: titleController,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InputFieldWithText(
                                      text: 'صوره الدرس',
                                      controller: imageController,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        bloc.uploadImage(imageController),
                                    child: bloc.isUploading
                                        ? CircularProgressIndicator()
                                        : Icon(
                                            Icons.image,
                                            size: 30,
                                          ),
                                  )
                                ],
                              ),
                              InputFieldWithText(
                                text: 'نص الدرس',
                                multiLines: true,
                                controller: textController,
                              ),
                              InputFieldWithText(
                                text: 'النوع',
                                controller: typeController,
                                readOnly: true,
                              ),
                              InputFieldWithText(
                                text: 'الترتيب',
                                controller: orderController,
                                keyboard: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          bloc.list[index].onClick =
                              () => bloc.removeParagraph(index);
                          return bloc.list[index];
                        },
                        itemCount: bloc.list.length,
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => bloc.insertParagraph(),
                  child: Icon(
                    Icons.add,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
