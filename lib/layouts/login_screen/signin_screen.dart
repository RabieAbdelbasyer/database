import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterapplication/components/navigate.dart';
import 'package:masterapplication/layouts/main_screen/main_screen.dart';
import 'package:masterapplication/widgets/my_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class SignInScreen extends StatefulWidget {
  static const String screenRoute = 'signin_screen';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late String email;
  late String password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => LoginCubit(),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState)
                navigateToReplacement(context, MainScreen(state.user));
              if (state is LoginErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.error,
                    style: TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.lightBlue,
                ));
              }
            },
            builder: (context, state) {
              var bloc = LoginCubit.get(context);
              return ModalProgressHUD(
                inAsyncCall: bloc.showSpiner,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 180,
                          child: Image.asset('images/0.png'),
                        ),
                        SizedBox(height: 50),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.send,
                          autocorrect: true,
                          onChanged: (value) {
                            email = value;
                          },
                          autofocus: true,
                          textDirection: TextDirection.rtl,
                          validator: (String? value) {
                            if ((value ?? '').isEmpty)
                              return 'ادخل اسم المستخدم';
                          },
                          decoration: InputDecoration(
                            hintText: 'ادخل البريد الالكترونى',
                            labelText: "البريد الالكترونى",
                            //helperText: "example@Gmail.com",

                            prefixIcon: Icon(Icons.email),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.orange,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          textAlign: TextAlign.center,
                          obscureText: true,
                          onChanged: (value) {
                            password = value;
                          },
                          textDirection: TextDirection.rtl,
                          maxLength: 8,
                          validator: (String? value) {
                            if ((value ?? '').isEmpty)
                              return 'ادخل كلمه المرور';
                          },
                          decoration: InputDecoration(
                            hintText: 'ادخل كلمة السر',
                            labelText: "كلمة السر",
                            //errorText: "Error",

                            prefixIcon: Icon(Icons.security),

                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.orange,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        MyButton(
                          color: Colors.blue[900]!,
                          title: 'تسجيل الدخول',
                          onPressed: () {
                            if (formKey.currentState!.validate())
                              bloc.login(email: email, password: password);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
