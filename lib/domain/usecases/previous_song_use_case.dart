import 'package:flutter_music_player/domain/repositories/song_repository.dart';
import 'package:just_audio/just_audio.dart';

class PreviousSongUseCase {
  final SongRepository _songRepository;
  PreviousSongUseCase(this._songRepository);
  Future<void> call(AudioPlayer player) {
    return _songRepository.previousSong(player);
  }
}
