import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_notes_app/components/drawer.dart';
import 'package:minimal_notes_app/models/note.dart';
import 'package:minimal_notes_app/models/note_database.dart';
import 'package:minimal_notes_app/themes/colors.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    readNotes();
  }

  final textController = TextEditingController();
  // crud: create note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          style: GoogleFonts.dmSans(),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              if (textController.text != '') {
                context.read<NoteDatabase>().addNote(textController.text);
              }
              textController.clear();
              Navigator.pop(context); // removes alert dialog when create
            },
            child: Text(
              'Done',
              style: GoogleFonts.dmSans(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // crud: read note
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // crud: update note
  void updateNotes(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Note"),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<NoteDatabase>().updateNote(
                    note.id,
                    textController.text,
                  );
              textController.clear;
              Navigator.pop(context); // removes alert dialog when create
            },
            child: Text(
              'Update',
              style: GoogleFonts.dmSans(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // crud: delete note
  void deleteNotes(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                'My Notes',
                style: GoogleFonts.dmSerifDisplay(
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  final note = currentNotes[index];
                  return ListTile(
                    title: Text(
                      note.text,
                      style: GoogleFonts.dmSans(),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => updateNotes(note),
                          icon: Icon(
                            Icons.edit,
                            color: buttonColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () => deleteNotes(note.id),
                          icon: Icon(
                            Icons.delete,
                            color: buttonColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.transparent,
        shape: CircleBorder(),
        backgroundColor: buttonColor,
        onPressed: () => createNote(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
