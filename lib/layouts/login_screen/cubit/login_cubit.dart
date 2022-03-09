import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool showSpiner = false;
  void login({required String email, required String password}) {
    emit(LoginLoadingState());
    showSpiner = true;
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      showSpiner = false;

      if (value.user != null) {
        emit(LoginSuccessState(value.user!));
      } else
        emit(LoginErrorState('error'));
    }).catchError((error) {
      showSpiner = false;
      emit(LoginErrorState(error.message));
    });
  }
}
