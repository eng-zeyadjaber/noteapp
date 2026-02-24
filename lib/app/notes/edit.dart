import 'package:flutter/material.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({super.key});

  @override
  State<EditNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<EditNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Notes"),),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            
          ],
        ),
      ),
    );
  }
}