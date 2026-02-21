import 'package:flutter/material.dart';
import 'package:noteapp/components/customtextform.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _LoginState();
}

class _LoginState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SignUp"), backgroundColor: Colors.blue),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      "https://i.pinimg.com/736x/31/5a/63/315a6337729ca3ab4e890a46f7daa677.jpg",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 30),
                  CustTextFormSign(hint: "UserName", mycontroller: username),
                  CustTextFormSign(hint: "Email", mycontroller: email),
                  CustTextFormSign(hint: "password", mycontroller: password),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                    onPressed: () {},
                    child: Text("SignUp"),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("login");
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
