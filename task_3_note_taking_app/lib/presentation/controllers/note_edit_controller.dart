import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecase/create_note.dart';
import '../../domain/usecase/update_note.dart';

class NoteEditController extends GetxController {
  final CreateNoteUseCase createNote;
  final UpdateNoteUseCase updateNote;

  NoteEditController({required this.createNote, required this.updateNote});

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  Color selectedColor = Colors.white;
  String? noteId;

  void loadForEdit(Note? note) {
    if (note != null) {
      noteId = note.id;
      titleController.text = note.title;
      contentController.text = note.content;
      selectedColor = Color(note.color);
    } else {
      noteId = null;
      titleController.clear();
      contentController.clear();
      selectedColor = Colors.white;
    }
  }

  Future<void> saveNote() async {
    final note = Note(
      id: noteId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      content: contentController.text,
      color: selectedColor.value,
    );
    if (noteId == null) {
      await createNote(note);
    } else {
      await updateNote(note);
    }
    Get.back();
  }
}
