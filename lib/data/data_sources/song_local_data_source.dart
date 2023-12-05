import 'package:on_audio_query/on_audio_query.dart';

abstract class SongLocalDataSource {
  Future<List<SongModel>> getSongList();
}
