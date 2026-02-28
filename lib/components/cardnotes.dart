import 'package:flutter/material.dart';
import 'package:noteapp/model/noteModel.dart';

class CardNotes extends StatelessWidget {
  final void Function()? ontap;
  final NoteModel notemodel;
  final void Function()? onDelete;
  const CardNotes({
    super.key,
    required this.ontap,
    this.onDelete,
    required this.notemodel,
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
                child: Image.network(
                  "https://i.pinimg.com/736x/31/5a/63/315a6337729ca3ab4e890a46f7daa677.jpg",
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
