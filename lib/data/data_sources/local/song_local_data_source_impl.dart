import 'package:flutter_music_player/data/data_sources/song_local_data_source.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_query_platform_interface/src/models/song_model.dart';

class SongLocalDataSourceImpl extends SongLocalDataSource {
  final audioQuery = OnAudioQuery();
  @override
  Future<List<SongModel>> getSongList() async {
    await getPermission();
    final List<SongModel> songs = await audioQuery.querySongs();
    return songs;
  }

  Future<void> getPermission() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();
    }
  }
}
