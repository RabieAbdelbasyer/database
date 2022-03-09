import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masterapplication/Widgets/paragraph.dart';
import 'package:masterapplication/layouts/create_new_lesson/cubit/create_lesson_state.dart';
import 'package:masterapplication/layouts/main_screen/cubit/main_cubit.dart';
import 'package:masterapplication/models/lesson_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CreateLessonCubit extends Cubit<CreateLessonState> {
  CreateLessonCubit() : super(CreateLessonInitial());

  static CreateLessonCubit get(context) => BlocProvider.of(context);

  List<Paragraph> list = [];
  void insertParagraph() {
    list.add(Paragraph());
    emit(NewParagraphState());
  }

  void removeParagraph(int index) {
    list.removeAt(index);
    emit(RemoveParagraphState());
  }

  bool isLoading = false;

  bool chickValidate(
    MainCubit mainCubit, {
    required String id,
    required String title,
    required String image,
    required String text,
    required type,
    required String order,
  }) {
    if (id.trim().isEmpty ||
        title.trim().isEmpty ||
        image.trim().isEmpty ||
        text.trim().isEmpty ||
        type.trim().isEmpty ||
        order.trim().isEmpty) {
      isLoading = false;
      emit(InsertLessonErrorState('يجب ملئ جميع الحقول'));
      return false;
    }
    //for (LessonModel lesson in mainCubit.databaseLessons)
     // if (lesson.lessonId == id) {
     //   isLoading = false;
     //   emit(InsertLessonErrorState('الاي دي مستخدم من قبل'));
     //   return false;
     // }
    for (LessonModel lesson in mainCubit.productionDatabaseLessons)
      if (lesson.lessonId == id) {
        isLoading = false;
        emit(InsertLessonErrorState('الاي دي مستخدم من قبل'));
        return false;
      }
    for (LessonModel lesson in mainCubit.analyzeDatabaseLessons)
      if (lesson.lessonId == id) {
        isLoading = false;
        emit(InsertLessonErrorState('الاي دي مستخدم من قبل'));
        return false;
      }
    return true;
  }

  List<LessonModel> convertToLessonModel() {
    List<LessonModel> lessonModel = [];
    for (int i = 0; i < list.length; i++) {
      LessonModel model = LessonModel(order: i + 1);
      if (list[i].getSelected() == 'text') model.text = list[i].getValue();
      if (list[i].getSelected() == 'bold') model.bold = list[i].getValue();
      if (list[i].getSelected() == 'center') model.center = list[i].getValue();
      if (list[i].getSelected() == 'image') model.image = list[i].getValue();
      if (list[i].getSelected() == 'video') model.video = list[i].getValue();
      if (list[i].getSelected() == 'divider')
        model.divider = list[i].getValue();
      lessonModel.add(model);
    }
    return lessonModel;
  }

  void insertData(
    MainCubit mainCubit, {
    required String id,
    required String title,
    required String image,
    required String text,
    required type,
    required String order,
  }) {
    isLoading = true;
    emit(InsertLessonLoadingState());
    if (chickValidate(mainCubit,
        id: id,
        title: title,
        image: image,
        text: text,
        type: type,
        order: order)) {
      List<LessonModel> model = convertToLessonModel();
      FirebaseFirestore.instance
          .collection('lessons')
          .doc(id)
          .set(LessonModel(
            image: image,
            order: int.parse(order),
            text: text,
            title: title,
            type: type,
          ).toMap())
          .then((value) async {
        for (int i = 0; i < model.length; i++)
          await FirebaseFirestore.instance
              .collection('lessons')
              .doc(id)
              .collection('details')
              .add(model[i].toMap());
        isLoading = false;

        emit(InsertLessonSuccessState());
      });
    } else {}
  }

  bool isUploading = false;

  void uploadImage(controller) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    isUploading = true;
    emit(UploadImageLoadingState());
    if (image != null) {
      firebase_storage.FirebaseStorage firebaseStorage =
          firebase_storage.FirebaseStorage.instance;
      await firebaseStorage
          .ref()
          .child('/images/${Uri.file(image.path).pathSegments.last}')
          .putFile(File(image.path))
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          controller.text = value;
          isUploading = false;
          emit(UploadImageSuccessState());
        }).catchError((error) {});
      });
    } else {
      isUploading = false;
    }
  }
}
