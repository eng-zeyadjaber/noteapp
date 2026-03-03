import 'dart:io';
import 'package:flutter/material.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/model/noteModel.dart';

class CardNotes extends StatelessWidget {
  final void Function()? ontap;
  final NoteModel notemodel;
  final void Function()? onDelete;
  final File? localImage;
  const CardNotes({
    super.key,
    required this.ontap,
    this.onDelete,
    required this.notemodel,
    this.localImage,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 0,
              child: ClipOval(
                child: localImage != null
                    ? Image.file(
                        localImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        "$linkImageRoot/${notemodel.notesImage}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("${notemodel.notesTitle}"),
                subtitle: Text("${notemodel.notesContent}"),
                trailing: IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.folder_delete_rounded),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
