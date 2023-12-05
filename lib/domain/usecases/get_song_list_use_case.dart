import 'package:flutter_music_player/domain/repositories/song_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GetSongListUseCase {
  final SongRepository _songRepository;
  GetSongListUseCase(this._songRepository);
  Future<List<SongModel>> call() {
    return _songRepository.getSongList();
  }
}
