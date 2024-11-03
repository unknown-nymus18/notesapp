import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notesapp/database/notes_data.dart';
import 'package:notesapp/pages/notes_content.dart';

class NotesTile extends StatelessWidget {
  final String title;
  final String content;
  final NotesData db;
  final int index;
  const NotesTile({
    super.key,
    required this.title,
    required this.content,
    required this.db,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotesContent(
              title: title,
              content: content,
              db: db,
              index: index,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.3,
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  db.deletenote(index);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.grey[900],
                icon: Icons.delete,
                label: 'Delete',
              )
            ],
          ),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  content,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
