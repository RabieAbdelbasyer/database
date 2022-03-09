import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:masterapplication/Page/Main_database.dart';
import 'package:masterapplication/Page/analysis_page.dart';
//import 'package:masterapplication/Page/design_page.dart';
import 'package:masterapplication/Page/profile_Page.dart';
import 'package:masterapplication/Page/Production_Page4.dart';
//import 'package:masterapplication/Page/Practical5.dart';
import 'package:masterapplication/models/lesson_model.dart';
import 'package:masterapplication/models/user_model.dart';
import '../../../main.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  static MainCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  final screens = [
    Profilepage(),
    //Maindatabase(),
    AnalysisPage(),
    //DesignPage(),
    Productionpage(),
    //Practicalpage(),


  ];
  void changeNavIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBarIndexState());
  }

  UserModel? currentUserModel;
  void getUserModel(String uId) {
    emit(GetCurrentUserModelLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      currentUserModel = UserModel.fromJson(value.data()!);
      MyApp.analytics.logEvent(name: 'login', parameters: {
        'id': currentUserModel!.id,
        'name': currentUserModel!.fullName
      });
      emit(GetCurrentUserModelSuccessState());
    }).catchError((error) {
      emit(GetCurrentUserModelErrorState());
    });
  }

  //List<LessonModel> databaseLessons = [];
  List<LessonModel> analyzeDatabaseLessons = [];
 // List<LessonModel> designDatabaseLessons = [];
  List<LessonModel> productionDatabaseLessons = [];
  List<LessonModel> practicalDatabaseLessons = [];
  

  void getAllLessons() {
    //databaseLessons = [];
    analyzeDatabaseLessons = [];
    //designDatabaseLessons = [];
    productionDatabaseLessons = [];
    practicalDatabaseLessons = [];

    emit(GetAllLessonLoadingState());
    FirebaseFirestore.instance
        .collection('lessons')
        .orderBy('order')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        LessonModel lessonModel =
            LessonModel.fromJson(element.id, element.data());
        if (lessonModel.type == '1')
          analyzeDatabaseLessons.add(lessonModel);
        else if (lessonModel.type == '2')
          productionDatabaseLessons.add(lessonModel);
       // else if (lessonModel.type == '3')
         // designDatabaseLessons.add(lessonModel);
        //else if(lessonModel.type == '4')
         // productionDatabaseLessons.add(lessonModel);
        //else if(lessonModel.type == '5')
         // practicalDatabaseLessons.add(lessonModel);
          
      });
      emit(GetAllLessonSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllLessonErrorState());
    });
  }
}
