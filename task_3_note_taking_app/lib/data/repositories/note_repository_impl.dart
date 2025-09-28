import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_local_datasource.dart';
import '../datasources/note_remote_datasource.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource local;
  final NoteRemoteDataSource remote;

  NoteRepositoryImpl({required this.local, required this.remote});

  @override
  Future<List<Note>> getAllNotes() => local.getNotes();

  @override
  Future<void> createNote(Note note) async {
    await local.saveNote(note);
    try {
      await remote.syncNote(note);
      note.isSynced = true;
      await local.saveNote(note);
    } catch (_) {}
  }

  @override
  Future<void> updateNote(Note note) async {
    await local.saveNote(note);
    try {
      await remote.syncNote(note);
      note.isSynced = true;
      await local.saveNote(note);
    } catch (_) {}
  }

  @override
  Future<void> deleteNote(String id) async {
    await local.deleteNote(id);
  }

  @override
  Future<void> syncNote(Note note) async {
    await remote.syncNote(note);
    note.isSynced = true;
    await local.saveNote(note);
  }
}
