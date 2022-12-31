import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './splash_screen.dart';
import 'package:provider/provider.dart';
import 'login_registerUi.dart';
import './admin_HomeUi.dart';
import './all_data.dart';
import './tutor_homeUi.dart';
import './widgets/auth.dart';
import './widgets/scheduler.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Shedule(),
        ),
        ChangeNotifierProvider.value(value: Update()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Automated Routine Scheduler',
          theme: ThemeData(
            primarySwatch: Colors.red,
            fontFamily: 'Product',
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          home: auth.isAuth
              ? user == "teacher"
                  ? TutorHomeUi()
                  : Admin_HomeUi()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : LoginRegisterUi(),
                ),
        ),
      ),
    );
  }
}
