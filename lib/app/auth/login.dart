import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextform.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Crud crud = Crud();
  bool isLoding = false;
  login() async {
    if (formstate.currentState!.validate()) {
      isLoding = true;
      setState(() {});
      var response = await crud.postRequest(linkLogin, {
        "email": email.text,
        "password": password.text,
      });
      isLoding = false;
      setState(() {});
      if (response['status'] == "success") {
        sharedPref.setString("id", response['data']['id'].toString());
        sharedPref.setString("username", response['data']['username']);
        sharedPref.setString("email", response['data']['email']);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: "Warning",
          body: Text("The email or password is incorrect or does not exist."),
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), backgroundColor: Colors.blue),
      body: Container(
        padding: EdgeInsets.all(10),
        child: isLoding == true
            ? Center(child: CircularProgressIndicator())
            : ListView(
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
                            await login();
                          },
                          child: Text("Login"),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed("signup");
                          },
                          child: Text("SignUp"),
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
