import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_edit_controller.dart';

class NoteEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final editController = Get.find<NoteEditController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(editController.noteId == null ? 'New Note' : 'Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => editController.saveNote(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: editController.titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: editController.contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Pick Color: '),
                GestureDetector(
                  onTap: () async {
                    final pickedColor = await showDialog<Color>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Wrap(
                            children: [
                              for (final c in [
                                Colors.white,
                                Colors.yellow,
                                Colors.blue,
                                Colors.green,
                                Colors.red,
                                Colors.black,
                              ])
                                GestureDetector(
                                  onTap: () => Navigator.pop(context, c),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    margin: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: c,
                                      border: Border.all(color: Colors.black26),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                    if (pickedColor != null) {
                      editController.selectedColor = pickedColor;
                    }
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: editController.selectedColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black26),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
