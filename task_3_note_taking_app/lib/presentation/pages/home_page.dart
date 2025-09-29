import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../controllers/notes_controller.dart';
import '../controllers/note_edit_controller.dart';
import '../controllers/settings_controller.dart';
import '../widgets/note_card.dart';
import 'note_edit_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesController = Get.find<NotesController>();
    final settingsController = Get.find<SettingsController>();

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
          color: Colors.deepPurple.shade300,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        title: const Text('My Notes'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => notesController.syncAll(),
          ),
          IconButton(
            icon: Icon(
              settingsController.isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () => settingsController.toggleDarkMode(),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: notesController.notes.length,
          itemBuilder: (context, index) {
            final note = notesController.notes[index];
            return NoteCard(
              note: note,
              onDelete: () => notesController.removeNote(note.id),
              onTap: () {
                final editController = Get.find<NoteEditController>();
                editController.loadForEdit(note);
                Get.to(() => NoteEditPage());
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final editController = Get.find<NoteEditController>();
          editController.loadForEdit(null);
          Get.to(() => NoteEditPage());
        },
      ),
    );
  }
}
