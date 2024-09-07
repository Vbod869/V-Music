import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lagu_kw_new/services/music_service.dart';
import '../models/song.dart';

class MusicProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Song> songs = [];
  Song? currentSong;
  bool isPlaying = false;
  bool isSearching = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> searchSongs(String query) async {
    isSearching = true;
    notifyListeners();

    try {
      final musicService = MusicService();
      songs = await musicService.searchSongs(query);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching songs: $e');
      }
    } finally {
      isSearching = false;
      notifyListeners();
    }
  }

  Future<void> playSong(Song song) async {
    if (currentSong == song && isPlaying) return;

    try {
      await _audioPlayer.setUrl(song.previewUrl);
      await _audioPlayer.play();
      currentSong = song;
      isPlaying = true;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error playing song: $e");
      }
      // You might want to set a fallback state here, such as notifying listeners
      // about an error or resetting the `currentSong` to null.
    }
  }

  void stopSong() {
    if (!isPlaying) return;

    _audioPlayer.stop();
    currentSong = null;
    isPlaying = false;
    notifyListeners();
  }
}
