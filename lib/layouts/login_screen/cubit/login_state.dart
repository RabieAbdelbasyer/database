import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccessState extends LoginState {
  User user;
  LoginSuccessState(this.user);
}

class LoginErrorState extends LoginState {
  String error;
  LoginErrorState(this.error);
}

class LoginLoadingState extends LoginState {}
