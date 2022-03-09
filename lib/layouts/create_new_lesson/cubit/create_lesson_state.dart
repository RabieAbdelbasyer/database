abstract class CreateLessonState {}

class CreateLessonInitial extends CreateLessonState {}

class NewParagraphState extends CreateLessonState {}

class RemoveParagraphState extends CreateLessonState {}

class InsertLessonLoadingState extends CreateLessonState {}

class InsertLessonErrorState extends CreateLessonState {
  String error;
  InsertLessonErrorState(this.error);
}

class InsertLessonSuccessState extends CreateLessonState {}

class UploadImageLoadingState extends CreateLessonState {}

class UploadImageSuccessState extends CreateLessonState {}
