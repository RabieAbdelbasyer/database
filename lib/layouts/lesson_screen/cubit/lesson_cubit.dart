import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterapplication/Widgets/current_date.dart';
import 'package:masterapplication/components/lesson_weidget.dart';
import 'package:masterapplication/models/comment_model.dart';
import 'package:masterapplication/models/file_model.dart';
import 'package:masterapplication/models/lesson_model.dart';
import 'package:masterapplication/models/user_model.dart';
import 'lesson_state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class LessonCubit extends Cubit<LessonState> {
  LessonCubit() : super(LessonInitial());

  static LessonCubit get(context) => BlocProvider.of(context);

  List<Widget> lessonsWidget = [];

  void getAllLesson(String lessonId) {
    emit(GetAllLessonsLoadingState());
    FirebaseFirestore.instance
        .collection('lessons')
        .doc(lessonId)
        .collection('details')
        .orderBy('order')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        LessonModel lessonModel =
            LessonModel.fromJson(lessonId, element.data());
        lessonsWidget.add(lessonWidget(lessonModel));
      });
      emit(GetAllLessonsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllLessonsErrorState());
    });
  }

  List<CommentModel> comments = [];

  void openCommentStream(String lessonId) {
    emit(LoadingCommentsState());
    FirebaseFirestore.instance
        .collection('lessons')
        .doc(lessonId)
        .collection('comments')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      comments = [];
      event.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
      });
      emit(UpdateCommentsState());
    });
  }

  void insertComment({
    required String lessonId,
    required String name,
    required String comment,
  }) {
    CommentModel commentModel =
        CommentModel(date: '', name: name, comment: comment);
    comments.add(commentModel);
    emit(UpdateCommentsState());

    getCurrentDate().then((value) {
      String? date = value;
      FirebaseFirestore.instance
          .collection('lessons')
          .doc(lessonId)
          .collection('comments')
          .add(CommentModel(
                  comment: comment,
                  date: date ?? DateTime.now().toString(),
                  name: name)
              .toMap());
    }).catchError((error) {
      FirebaseFirestore.instance
          .collection('lessons')
          .doc(lessonId)
          .collection('comments')
          .add(CommentModel(
            comment: comment,
            date: DateTime.now().toString(),
            name: name,
          ).toMap());
    });
  }

  List<FileModel> files = [];
  void getAllUserFiles({required String lessonId, required String userId}) {
    files = [];
    emit(GetFilesLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref('/$lessonId/$userId/')
        .listAll()
        .then((result) {
      result.items.forEach((firebase_storage.Reference ref) {
        ref.getDownloadURL().then((value) {
          FileModel fileModel = FileModel(ref.name);
          fileModel.downloadLink = value;
          fileModel.isUploading = false;
          files.add(fileModel);
        }).then((value) {
          emit(GetFilesSuccessState());
        });
      });
    }).then((value) {
      emit(GetFilesSuccessState());
    }).catchError((error) {
      emit(GetFilesErrorState());
    });
  }

  void uploadFile({required String lessonId, required String userId}) {
    FilePicker.platform.pickFiles().then((result) {
      if (result != null) {
        File file = File(result.files.single.path!);
        if (file.lengthSync() <= 5242880) {
          String fileName = Uri.file(file.path).pathSegments.last.toString();
          for (FileModel file in files) {
            if (file.fileName == fileName) {
              emit(UploadErrorState('الملف مرفوع بالفعل'));
              return;
            }
          }
          FileModel fileModel = FileModel(fileName);
          files.add(fileModel);
          emit(GetFilesSuccessState());
          firebase_storage.FirebaseStorage firebaseStorage =
              firebase_storage.FirebaseStorage.instance;
          firebaseStorage
              .ref('/$lessonId/$userId/${result.names[0]}')
              .putFile(file)
              .then((value) {
            value.ref.getDownloadURL().then((value) {
              fileModel.isUploading = false;
              fileModel.downloadLink = value;
              emit(GetFilesSuccessState());
            });
          });
        } else
          emit(UploadErrorState('الملف كبير جدا. اقصي حد مسموح به 5 ميجا'));
      }
    });
  }

  List<UserModel> uploadedUser = [];
  getAllUploadedUser({required String lessonId}) {
    uploadedUser = [];
    uploadedUser = [];
    firebase_storage.FirebaseStorage.instance
        .ref('$lessonId')
        .listAll()
        .then((result) {
          result.prefixes.forEach((firebase_storage.Reference ref) =>
              getUser(ref.name)
                  .then((value) => uploadedUser.add(value))
                  .then((value) => emit(GetAllUploadedUserSuccessState())));
        })
        .then((value) => emit(GetAllUploadedUserSuccessState()))
        .catchError((error) => emit(GetAllUploadedUserErrorState()));
  }

  Future<UserModel> getUser(userId) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
  }
}
