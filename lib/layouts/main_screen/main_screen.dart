import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterapplication/layouts/main_screen/cubit/main_cubit.dart';
import 'package:masterapplication/layouts/main_screen/cubit/main_state.dart';
import 'cubit/main_cubit.dart';

class MainScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';
  final User signedInUser;
  MainScreen(this.signedInUser);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => MainCubit()
          ..getUserModel(widget.signedInUser.uid)
          ..getAllLessons(),
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            var bloc = MainCubit.get(context);
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  backgroundColor: Colors.blue[900],
                  //automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Row(
                    children: [
                      //Image.asset('images/2.png', height: 25),
                      SizedBox(width: 10),
                      Text('تحليل وانتاج قواعد البيانات')
                    ],
                    
                  ),

                  actions: [
                    IconButton(
                      onPressed: () {
                        // add here logout function
                        _auth.signOut();
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    )
                  ],
                ),
                body: bloc.screens[bloc.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.shifting,
                  backgroundColor: Colors.deepOrange[200],
                  iconSize: 20,
                  selectedFontSize: 16,
                  unselectedFontSize: 10,
                  //showSelectedLabels:false,
                  currentIndex: bloc.currentIndex,
                  onTap: (index) => bloc.changeNavIndex(index),
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'الرئيسية',
                      backgroundColor: Colors.blue,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_tree_outlined),
                      label: 'الوحدة الأولى',
                      backgroundColor: Colors.blue,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.domain_sharp),
                      label: 'الوحدة الثانية',
                      backgroundColor: Colors.blue,
                    ),
                    //BottomNavigationBarItem(
                      //icon: Icon(Icons.account_tree),
                      //label: 'الوحدة الثالثة',
                      //backgroundColor: Colors.blue,
                    //),
                    //BottomNavigationBarItem(
                      //icon: Icon(Icons.grading_rounded),
                      //label: 'الوحدة الرابعة',
                      //backgroundColor: Colors.blue,
                    //),
                    //BottomNavigationBarItem(
                      //icon: Icon(Icons.device_hub_outlined),
                      //label: 'الوحدة الخامسة',
                      //backgroundColor: Colors.blue,
                    //),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
