import 'package:get/get.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecase/get_all_notes.dart';
import '../../domain/usecase/delete_note.dart';
import '../../domain/usecase/sync_pending_notes.dart';

class NotesController extends GetxController {
  final GetAllNotesUseCase getAllNotes;
  final SyncPendingNotesUseCase syncPendingNotes;
  final DeleteNoteUseCase deleteNote;

  NotesController({
    required this.getAllNotes,
    required this.syncPendingNotes,
    required this.deleteNote,
  });

  List<Note> notes = [];

  Future<void> init() async {
    await loadNotes();
  }

  Future<void> loadNotes() async {
    notes = await getAllNotes();
    update();
  }

  Future<void> removeNote(String id) async {
    await deleteNote(id);
    await loadNotes();
  }

  Future<void> syncAll() async {
    for (var note in notes.where((n) => !n.isSynced)) {
      await syncPendingNotes(note);
    }
    await loadNotes();
  }
}
