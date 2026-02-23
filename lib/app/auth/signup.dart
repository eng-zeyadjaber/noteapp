import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextform.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _LoginState();
}

class _LoginState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();
  Crud _crud = Crud();
  bool isLoding = false;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    if (formstate.currentState!.validate()) {
      isLoding = true;
      setState(() {});

      var response = await _crud.postRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });

      isLoding = false;
      setState(() {});

      if (response != null && response['status'] == "success") {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("Your account has been created successfully."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil("login", (route) => false);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("SignUp Failed"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Try Again"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SignUp"), backgroundColor: Colors.blue),
      body: isLoding == true
          ? Center(child: CircularProgressIndicator())
          : Container(
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
                        CustTextFormSign(
                          valid: (val) {
                            return validInput(val!, 3, 20);
                          },
                          hint: "UserName",
                          mycontroller: username,
                        ),
                        CustTextFormSign(
                          valid: (val) {
                            return validInput(val!, 10, 40);
                          },
                          hint: "Email",
                          mycontroller: email,
                        ),
                        CustTextFormSign(
                          valid: (val) {
                            return validInput(val!, 3, 10);
                          },
                          hint: "password",
                          mycontroller: password,
                        ),
                        MaterialButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 70,
                            vertical: 10,
                          ),
                          onPressed: () async {
                            print("Button Pressed");
                            await signUp();
                          },
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
