import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/song.dart';

class MusicService {
  final String apiUrl = 'https://itunes.apple.com';

  Future<List<Song>> searchSongs(String query) async {
    try {
      final encodedQuery = Uri.encodeQueryComponent(query);
      final response = await http.get(Uri.parse('$apiUrl/search?term=$encodedQuery&media=music'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['results'] == null || data['results'] is! List) {
          throw Exception('Invalid or unexpected response format');
        }

        final List<dynamic> songs = data['results'];
        return songs.map((song) => Song.fromJson(song)).toList();
      } else {
        throw Exception('Failed to search songs: HTTP ${response.statusCode}');
      }
    } catch (e) {
      // Additional context added for the exception message
      throw Exception('Error fetching data: $e');
    }
  }
}
