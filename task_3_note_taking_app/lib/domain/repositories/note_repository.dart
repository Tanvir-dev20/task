import '../entities/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getAllNotes();
  Future<void> createNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String id);
  Future<void> syncNote(Note note);
}
