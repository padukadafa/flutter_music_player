import 'package:flutter_music_player/domain/repositories/song_repository.dart';
import 'package:just_audio/just_audio.dart';

class PauseSongUseCase {
  final SongRepository _songRepository;
  PauseSongUseCase(this._songRepository);

  Future<void> call(AudioPlayer player) {
    return _songRepository.pauseSong(player);
  }
}
