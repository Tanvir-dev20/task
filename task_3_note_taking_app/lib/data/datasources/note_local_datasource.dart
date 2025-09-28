import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/note.dart';

class NoteLocalDataSource {
  static const String NOTES_KEY = 'notes';

  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(NOTES_KEY) ?? [];
    return jsonList.map((s) => Note.fromJson(json.decode(s))).toList();
  }

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = notes.map((n) => json.encode(n.toJson())).toList();
    await prefs.setStringList(NOTES_KEY, jsonList);
  }

  Future<void> saveNote(Note note) async {
    final notes = await getNotes();
    final index = notes.indexWhere((n) => n.id == note.id);
    if (index >= 0) {
      notes[index] = note;
    } else {
      notes.add(note);
    }
    await saveNotes(notes);
  }

  Future<void> deleteNote(String id) async {
    final notes = await getNotes();
    notes.removeWhere((n) => n.id == id);
    await saveNotes(notes);
  }
}
