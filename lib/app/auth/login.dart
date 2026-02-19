import 'package:flutter/material.dart';
import 'package:noteapp/components/customtextform.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              child: Column(
                children: [
                  Image.network(
                    "https://i.pinimg.com/736x/31/5a/63/315a6337729ca3ab4e890a46f7daa677.jpg",
                    width: 100,
                    height: 100,
                  ),
                  CustTextFormSign(hint: "Email"),
                  CustTextFormSign(hint: "password"),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                    onPressed: () {},
                    child: Text("Login"),
                  ),
                  Container(height: 10),
                  TextButton(onPressed: () {}, child: Text("SignUp")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
