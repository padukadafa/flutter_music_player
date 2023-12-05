import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class SongRepository {
  Future<List<SongModel>> getSongList();
  Future<void> playSong(AudioPlayer player, SongModel song);
  Future<void> stopSong(AudioPlayer player);
  Future<void> seekSong(AudioPlayer player, Duration duration);
  Future<void> pauseSong(AudioPlayer player);
  Future<void> resumeSong(AudioPlayer player);
}
