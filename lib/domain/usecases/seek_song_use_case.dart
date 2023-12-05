import 'package:flutter_music_player/domain/repositories/song_repository.dart';
import 'package:just_audio/just_audio.dart';

class SeekSongUseCase {
  final SongRepository _songRepository;
  SeekSongUseCase(this._songRepository);
  Future<void> call(AudioPlayer player, Duration duration) {
    return _songRepository.seekSong(player, duration);
  }
}
