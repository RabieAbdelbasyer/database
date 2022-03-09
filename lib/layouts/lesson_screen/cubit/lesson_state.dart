abstract class LessonState {}

class LessonInitial extends LessonState {}

class GetAllLessonsLoadingState extends LessonState {}

class GetAllLessonsSuccessState extends LessonState {}

class GetAllLessonsErrorState extends LessonState {}

class LoadingCommentsState extends LessonState {}

class UpdateCommentsState extends LessonState {}

class GetFilesLoadingState extends LessonState {}

class GetFilesSuccessState extends LessonState {}

class GetFilesErrorState extends LessonState {}

class UploadErrorState extends LessonState {
  String error;
  UploadErrorState(this.error);
}

class GetAllUploadedUserSuccessState extends LessonState {}

class GetAllUploadedUserErrorState extends LessonState {}
