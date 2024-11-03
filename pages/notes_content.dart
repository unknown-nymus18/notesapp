import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/database/notes_data.dart';

class NotesContent extends StatefulWidget {
  final String title;
  final String content;
  final NotesData db;
  final int? index;
  const NotesContent({
    super.key,
    required this.title,
    required this.content,
    required this.db,
    this.index,
  });

  @override
  State<NotesContent> createState() => _NotesContentState();
}

class _NotesContentState extends State<NotesContent> {
  final TextEditingController _contextController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final myBox = Hive.box('myBox');
  bool? isNew;

  double _titleTextSize = 20;
  String _titleTextAlign = 'cen';
  final Color _titleTextColor = Colors.white;

  double _contentTextSize = 16;
  String _contentTextAlign = 'ltr';
  final Color _contentTextColor = Colors.white;

  @override
  void initState() {
    super.initState();
    if (widget.title.isNotEmpty && widget.content.isNotEmpty) {
      _contextController.text = widget.content;
      _titleController.text = widget.title;
      isNew = false;
      _titleTextSize = widget.db.notesList[widget.index!][2];
      _titleTextAlign = widget.db.notesList[widget.index!][3];
      // _titleTextColor = widget.db.notesList[widget.index!][4];
      _contentTextSize = widget.db.notesList[widget.index!][4];
      _contentTextAlign = widget.db.notesList[widget.index!][5];
      // _contentTextColor = widget.db.notesList[widget.index!][7];
      return;
    }
    _contextController.text = '';
    _titleController.text = '';
    isNew = true;
  }

  void saveNote() {
    if (_titleController.text.isNotEmpty &&
        _contextController.text.isNotEmpty) {
      if (isNew!) {
        widget.db.notesList.add(
          [
            _titleController.text,
            _contextController.text,
            _titleTextSize,
            _titleTextAlign,
            // _titleTextColor,
            _contentTextSize,
            _contentTextAlign,
            // _contentTextColor,
          ],
        );
        widget.db.updateDatabase();
      } else {
        widget.db.notesList[widget.index!] = [
          _titleController.text,
          _contextController.text,
          _titleTextSize,
          _titleTextAlign,
          // _titleTextColor,
          _contentTextSize,
          _contentTextAlign,
          // _contentTextColor,
        ];
        widget.db.updateDatabase();
      }
    }
  }

  void menuClicked() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Text(
                "Title",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Text Size",
                    style: TextStyle(fontSize: 20),
                  ),
                  DropdownButton(
                    value: _titleTextSize,
                    menuWidth: 100,
                    menuMaxHeight: 300,
                    items: [
                      for (int i = 14; i <= 32; i++)
                        DropdownMenuItem(
                          value: i.toDouble(),
                          child: Text(
                            i.toString(),
                          ),
                        )
                    ],
                    onChanged: (value) {
                      setState(
                        () {
                          _titleTextSize = value!.toDouble();
                        },
                      );
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Text Align",
                    style: TextStyle(fontSize: 20),
                  ),
                  DropdownButton(
                    value: _titleTextAlign == 'rtl'
                        ? "Right Align"
                        : _titleTextAlign == 'ltr'
                            ? "Left Align"
                            : 'Center Align',
                    menuMaxHeight: 300,
                    items: ['Right Align', 'Left Align', 'Center Align']
                        .map((String alignment) {
                      return DropdownMenuItem(
                          value: alignment, child: Text(alignment));
                    }).toList(),
                    onChanged: (value) {
                      if (value == 'Right Align') {
                        value = 'rtl';
                      } else if (value == 'Left Align') {
                        value = 'ltr';
                      } else {
                        value = 'cen';
                      }
                      setState(
                        () {
                          _titleTextAlign = value!;
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Content',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Text Size",
                    style: TextStyle(fontSize: 20),
                  ),
                  DropdownButton(
                    value: _contentTextSize,
                    menuWidth: 100,
                    menuMaxHeight: 300,
                    items: [
                      for (int i = 14; i <= 32; i++)
                        DropdownMenuItem(
                          value: i.toDouble(),
                          child: Text(
                            i.toString(),
                          ),
                        )
                    ],
                    onChanged: (value) {
                      setState(
                        () {
                          _contentTextSize = value!.toDouble();
                        },
                      );
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Text Align",
                    style: TextStyle(fontSize: 20),
                  ),
                  DropdownButton(
                    value: _contentTextAlign == 'rtl'
                        ? "Right Align"
                        : _contentTextAlign == 'ltr'
                            ? "Left Align"
                            : 'Center Align',
                    menuMaxHeight: 300,
                    items: ['Right Align', 'Left Align', 'Center Align']
                        .map((String alignment) {
                      return DropdownMenuItem(
                          value: alignment, child: Text(alignment));
                    }).toList(),
                    onChanged: (value) {
                      if (value == 'Right Align') {
                        value = 'rtl';
                      } else if (value == 'Left Align') {
                        value = 'ltr';
                      } else {
                        value = 'cen';
                      }
                      setState(
                        () {
                          _contentTextAlign = value!;
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: menuClicked,
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            saveNote();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLines: null,
              textAlign: _titleTextAlign == 'ltr'
                  ? TextAlign.left
                  : _titleTextAlign == 'rtl'
                      ? TextAlign.end
                      : TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: _titleTextSize,
                fontWeight: FontWeight.bold,
                color: _titleTextColor,
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            TextField(
              style: TextStyle(
                fontSize: _contentTextSize,
                color: _contentTextColor,
              ),
              textAlign: _contentTextAlign == 'ltr'
                  ? TextAlign.left
                  : _contentTextAlign == 'rtl'
                      ? TextAlign.end
                      : TextAlign.center,
              controller: _contextController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
