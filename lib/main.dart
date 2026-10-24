import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/verificar.dart';
import 'pages/registro.dart';
import 'pages/nueva_contrasena.dart';
import 'pages/recuperar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Inter'),
      initialRoute: "/",
      routes: {
        "/": (_) => LoginScreen(),
        "/home": (_) => HomeScreen(),
        "/verification": (_) => VerificationCodeScreen(),
        "/register": (_) => RegisterScreen(),
        "/forgot-password": (_) => ForgotPasswordScreen(),
        "/new-password": (_) => NewPasswordScreen(),
      },
    );
  }
}
