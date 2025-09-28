import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetAllNotesUseCase {
  final NoteRepository repository;
  GetAllNotesUseCase(this.repository);

  Future<List<Note>> call() async {
    return await repository.getAllNotes();
  }
}
