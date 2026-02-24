import 'dart:math';

import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextform.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  Crud crud = Crud();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLoding = false;
  AddNotes() async {
    if (formstate.currentState!.validate()) {
      isLoding = true;
      setState(() {});
      var response = await crud.postRequest(linkAddNotes, {
        "title": title.text,
        "content": content.text,
        "id": sharedPref.getString("id"),
      });
      isLoding = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        print(Text("$e"));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Notes")),
      body: isLoding == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    CustTextFormSign(
                      hint: "title",
                      mycontroller: title,
                      valid: (val) {
                        return validInput(val!, 1, 40);
                      },
                    ),
                    CustTextFormSign(
                      hint: "content",
                      mycontroller: content,
                      valid: (val) {
                        return validInput(val!, 10, 255);
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 30,
                      width: 5,
                      color: Colors.blue,
                      child: InkWell(
                        onTap: () async {
                          await AddNotes();
                        },
                        child: Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
