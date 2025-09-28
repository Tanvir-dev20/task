import '../entities/note.dart';
import '../repositories/note_repository.dart';

class SyncPendingNotesUseCase {
  final NoteRepository repository;
  SyncPendingNotesUseCase(this.repository);

  Future<void> call(Note note) => repository.syncNote(note);
}
