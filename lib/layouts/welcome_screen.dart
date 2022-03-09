import 'package:flutter/material.dart';
import 'package:masterapplication/layouts/login_screen/signin_screen.dart';

import 'package:masterapplication/widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset('images/0.png'),
                ),
                SizedBox(height: 30),
                Text(
                  'بيئية تعلم نقال شخصية لتنمية مهارة تحليل وانتاج قواعد البيانات وتمثيلها بصرياً',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xffc62828),
                  ),
                ),
                 SizedBox(height: 15),
                Text(
                  'إعداد الباحث: ربيع محمد عبدالبصير',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff2e386b),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            MyButton(
              color: Colors.blue[800]!,
              title: ' تسجيل الدخول',
              onPressed: () {
                Navigator.pushNamed(context, SignInScreen.screenRoute);
                //Navigator.pushNamed(context, ChatScreen.screenRoute);
              },
            )
            
            
          ],
        ),
      ),
    );
  }
}
