import 'package:flutter/material.dart';
import 'package:noteapp/app/auth/login.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Note App",
      initialRoute: "/",
      routes: {"/": (context) => Login()},
    );
  }
}
