import 'package:flutter/foundation.dart';

class Song {
  final String title;
  final String artist;
  final String albumCover;
  final String previewUrl;

  Song({
    required this.title,
    required this.artist,
    required this.albumCover,
    required this.previewUrl,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    
    if (kDebugMode) {
      print('Received JSON: $json');
    }

    return Song(
      title: json['trackName'] ?? 'Unknown Title',
      artist: json['artistName'] ?? 'Unknown Artist',
      albumCover: json['artworkUrl100'] ?? '',
      previewUrl: json['previewUrl'] ?? '',
    );
  }
}
