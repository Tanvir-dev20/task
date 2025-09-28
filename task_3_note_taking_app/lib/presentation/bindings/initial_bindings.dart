import 'package:get/get.dart';
import '../../data/datasources/note_local_datasource.dart';
import '../../data/datasources/note_remote_datasource.dart';
import '../../data/repositories/note_repository_impl.dart';
import '../../domain/repositories/note_repository.dart';
import '../../domain/usecase/create_note.dart';
import '../../domain/usecase/delete_note.dart';
import '../../domain/usecase/get_all_notes.dart';
import '../../domain/usecase/sync_pending_notes.dart';
import '../../domain/usecase/update_note.dart';
import '../controllers/note_edit_controller.dart';
import '../controllers/notes_controller.dart';
import '../controllers/settings_controller.dart';

class InitialBindings {
  Future<void> init() async {
    Get.put(NoteLocalDataSource());
    Get.put(NoteRemoteDataSource());
    Get.put<NoteRepository>(
      NoteRepositoryImpl(local: Get.find(), remote: Get.find()),
    );

    // Use cases
    Get.put(CreateNoteUseCase(Get.find<NoteRepository>()));
    Get.put(UpdateNoteUseCase(Get.find<NoteRepository>()));
    Get.put(DeleteNoteUseCase(Get.find<NoteRepository>()));
    Get.put(GetAllNotesUseCase(Get.find<NoteRepository>()));
    Get.put(SyncPendingNotesUseCase(Get.find<NoteRepository>()));

    // Controllers
    Get.put(SettingsController());
    Get.put(
      NotesController(
        getAllNotes: Get.find(),
        syncPendingNotes: Get.find(),
        deleteNote: Get.find(),
      ),
    );
    Get.put(NoteEditController(createNote: Get.find(), updateNote: Get.find()));

    await Get.find<NotesController>().init();
  }
}
