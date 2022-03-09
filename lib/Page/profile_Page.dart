import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterapplication/layouts/main_screen/cubit/main_cubit.dart';
import 'package:masterapplication/layouts/main_screen/cubit/main_state.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profilepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('صفحة المستخدم الرئيسية'),
          centerTitle: true,
          elevation: 0,
          //backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            var bloc = MainCubit.get(context);
            Size screenSize = MediaQuery.of(context).size;
            return bloc.currentUserModel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: screenSize.height * .15 + 60,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: screenSize.height * .15 + 30,
                                width: double.infinity,
                                color: Color(0xff2296F3),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: screenSize.height * .15,
                                    child: SvgPicture.asset(
                                      'images/personicon.svg',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height: screenSize.height * .15 + 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Material(
                                  borderRadius: BorderRadius.circular(5),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  elevation: 5,
                                  child: Container(
                                    width: double.infinity,
                                    height: 40,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      child: Center(
                                        child: Text(
                                          bloc.currentUserModel!.fullName,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: screenSize.height * .05),
                      iconWithData(
                        icon: Icons.email,
                        data: bloc.currentUserModel!.email,
                      ),
                      iconWithData(
                        icon: Icons.phone,
                        data: bloc.currentUserModel!.mobile,
                      ),
                      Text(
                        'تطبيق تحليل وانتاج قواعد البيانات ',
                        //todo:write text
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  );
          },
        ),
        //body: Center(child: Text('صفحة المستخدم الرئيسية', style: TextStyle(fontSize: 60)))
      );
  Widget iconWithData({required IconData icon, required String data}) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Icon(
              icon,
              color: Color(0xff2296F3),
              size: 35,
            ),
            SizedBox(width: 7),
            Expanded(
              child: Text(
                data,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
