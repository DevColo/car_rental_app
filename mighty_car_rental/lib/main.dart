import 'package:flutter/material.dart';
import 'package:mighty_car_rental/main_layout.dart';
import 'package:mighty_car_rental/screens/login_screen.dart';
import 'package:mighty_car_rental/screens/register_screen.dart';
import 'package:mighty_car_rental/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'models/auth_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //this is for push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthModel>(
      create: (context) => AuthModel(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //pre-define input decoration
            ),
        initialRoute: '/',
        routes: {
          '/': (context) => const WelcomeScreen(),
          //'/': (context) => HistoryScreen(),
          'register': (context) => const RegisterScreen(),
          'login': (context) => const LoginScreen(),
          'main': (context) => const MainLayout(),
        },
      ),
    );
  }
}
