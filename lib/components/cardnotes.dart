import 'package:flutter/material.dart';

class CardNotes extends StatelessWidget {
  final void Function()? ontap;
  final String title;
  final String content;
  const CardNotes({
    super.key,
    required this.ontap,
    required this.title,
    required this.content,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
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
                title: Text("$title"),
                subtitle: Text("$content"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
