import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/note.dart';

class NoteRemoteDataSource {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<void> syncNote(Note note) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: json.encode({'title': note.title, 'body': note.content}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to sync note');
    }
  }
}
