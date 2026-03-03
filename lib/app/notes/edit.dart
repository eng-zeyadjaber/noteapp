import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextform.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';

class EditNotes extends StatefulWidget {
  final notes;
  const EditNotes({super.key, this.notes});

  @override
  State<EditNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<EditNotes> {
  Crud crud = Crud();
  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLoding = false;
  EditNotes() async {
    if (formstate.currentState!.validate()) {
      isLoding = true;
      setState(() {});
      var response;
      if (myfile == null) {
        response = await crud.postRequest(linkEditNotes, {
          "title": title.text,
          "content": content.text,
          "id": widget.notes['notes_id'].toString(),
          "imagename": widget.notes['notes_image'].toString(),
        });
      } else {
        response = await crud.postRequestWithFile(linkEditNotes, {
          "title": title.text,
          "content": content.text,
          "id": widget.notes['notes_id'].toString(),
          "imagename": widget.notes['notes_image'].toString(),
        }, myfile!);
      }
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
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Notes")),
      body: isLoding == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    if (myfile != null ||
                        (widget.notes['notes_image'] != null &&
                            widget.notes['notes_image'] != "null"))
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          width: 140,
                          height: 140,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: myfile != null
                                ? Image.file(myfile!, fit: BoxFit.cover)
                                : Image.network(
                                    "$linkImageRoot/${widget.notes['notes_image']}",
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Text("No Image"),
                                      );
                                    },
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
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () async {
                              await EditNotes();
                            },
                            child: Text("Save", style: TextStyle(fontSize: 16)),
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
                              );
                            }

                            if (xfile != null) {
                              myfile = File(xfile.path);
                              setState(() {});
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: "gallery",
                              child: Row(
                                children: [
                                  Icon(Icons.photo_library),
                                  SizedBox(width: 10),
                                  Text("Gallery"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: "camera",
                              child: Row(
                                children: [
                                  Icon(Icons.photo_camera_rounded),
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
