import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/database/notes_data.dart';
import 'package:notesapp/models/notes_tile.dart';
import 'package:notesapp/pages/notes_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myBox = Hive.box('myBox');

  NotesData db = NotesData();

  @override
  void initState() {
    if (myBox.get("NOTESLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesContent(
                    title: '',
                    content: '',
                    db: db,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.note_add_outlined,
              color: Colors.amber,
            ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: db.listenable(),
        child: null,
        builder: (context, widget) {
          return ListView.builder(
            itemCount: db.notesList.length,
            itemBuilder: (context, index) {
              return NotesTile(
                title: db.notesList[index][0],
                content: db.notesList[index][1],
                db: db,
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
