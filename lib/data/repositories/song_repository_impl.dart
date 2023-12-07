import 'package:flutter_music_player/core/error/song_error.dart';
import 'package:flutter_music_player/data/data_sources/song_local_data_source.dart';
import 'package:flutter_music_player/domain/repositories/song_repository.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongRepositoryImpl extends SongRepository {
  final SongLocalDataSource _songLocalDataSource;
  SongRepositoryImpl(this._songLocalDataSource);
  @override
  Future<List<SongModel>> getSongList() async {
    return _songLocalDataSource.getSongList();
  }

  @override
  Future<void> playSong(AudioPlayer player, SongModel song) async {
    if (song.uri != null) {
      await player.setUrl("file:${song.data}");
      // await player.setLoopMode(LoopMode.all);
      await player.play();
    } else {
      throw SongError(message: "Problem with audio source!");
    }
  }

  @override
  Future<void> seekSong(AudioPlayer player, Duration duration) async {
    try {
      await player.seek(duration);
      await player.play();
    } catch (e) {
      throw SongError(message: "Something happens while seek the song");
    }
  }

  @override
  Future<void> stopSong(AudioPlayer player) async {
    try {
      await player.stop();
    } catch (e) {
      throw SongError(message: "Something happens while stop the song");
    }
  }

  @override
  Future<void> pauseSong(AudioPlayer player) async {
    try {
      await player.pause();
    } catch (e) {
      throw SongError(message: "Something happens while pause the song");
    }
  }

  @override
  Future<void> resumeSong(AudioPlayer player) async {
    try {
      if (player.processingState == ProcessingState.completed) {
        await player.seek(const Duration(milliseconds: 0));
      }
      await player.play();
    } catch (e) {
      throw SongError(message: "Something happens while resume the song");
    }
  }
}
