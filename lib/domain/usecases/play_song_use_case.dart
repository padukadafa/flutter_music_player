import 'package:flutter_music_player/domain/repositories/song_repository.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaySongUseCase {
  final SongRepository _songRepository;
  PlaySongUseCase(this._songRepository);
  Future<void> call(AudioPlayer player, SongModel song) {
    return _songRepository.playSong(player, song);
  }
}
