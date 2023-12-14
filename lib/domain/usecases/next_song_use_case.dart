import 'package:flutter_music_player/domain/repositories/song_repository.dart';
import 'package:just_audio/just_audio.dart';

class NextSongUseCase {
  final SongRepository _songRepository;
  NextSongUseCase(this._songRepository);
  Future<void> call(AudioPlayer player) {
    return _songRepository.nextSong(player);
  }
}
