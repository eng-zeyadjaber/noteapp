import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLoding = false;
  AddNotes() async {
    if (myfile == null)
      return AwesomeDialog(
        context: context,
        title: "Important",
        body: Text("Add Image Note", style: TextStyle(fontSize: 20)),
      )..show();
    if (formstate.currentState!.validate()) {
      isLoding = true;
      setState(() {});
      var response = await crud.postRequestWithFile(linkAddNotes, {
        "title": title.text,
        "content": content.text,
        "id": sharedPref.getString("id"),
      }, myfile!);
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
                    /// 🔹 صورة الملاحظة (دائرية في المنتصف)
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: myfile != null
                              ? Image.file(myfile!, fit: BoxFit.cover)
                              : Container(
                                  color: Colors.grey[200],
                                  child: Icon(
                                    Icons.image,
                                    size: 60,
                                    color: Colors.grey[400],
                                  ),
                                ),
                        ),
                      ),
                    ),
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
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await AddNotes();
                            },
                            child: Text("Add"),
                          ),
                        ),
                        SizedBox(width: 10),
                        PopupMenuButton<String>(
                          icon: Icon(
                            myfile == null
                                ? Icons.image_rounded
                                : Icons.check_circle,
                            color: myfile == null
                                ? Colors.blueGrey[700]
                                : Colors.green,
                          ),
                          onSelected: (value) async {
                            XFile? xfile;

                            if (value == "gallery") {
                              xfile = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );
                            }

                            if (value == "camera") {
                              xfile = await ImagePicker().pickImage(
                                source: ImageSource.camera,
                                imageQuality: 80,
                                preferredCameraDevice: CameraDevice.rear,
                              );
                            }

                            if (xfile != null) {
                              if (!mounted) return;
                              setState(() {
                                myfile = File(xfile!.path);
                              });
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: "gallery",
                              child: Row(
                                children: [
                                  Icon(Icons.photo_library, size: 30),
                                  SizedBox(width: 10),
                                  Text("Gallery"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: "camera",
                              child: Row(
                                children: [
                                  Icon(Icons.photo_camera_rounded, size: 30),
                                  SizedBox(width: 10),
                                  Text("Camera"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
