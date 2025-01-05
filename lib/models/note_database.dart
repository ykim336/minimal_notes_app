// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:minimal_notes_app/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;
  final List<Note> currentNotes = [];

  // initialize
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  // create
  Future<void> addNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser; // create new object
    await isar.writeTxn(() => isar.notes.put(newNote)); // save to db
    fetchNotes();
  }

  // read
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  // update
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id); // find existing note
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // delete
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
