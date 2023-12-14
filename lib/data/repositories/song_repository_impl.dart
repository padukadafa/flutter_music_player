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
  Future<void> playSong(
      AudioPlayer player, int index, List<SongModel> playlist) async {
    final songList = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: playlist
          .map((e) => AudioSource.uri(Uri.parse("file:${e.data}")))
          .toList(),
    );
    await player.setAudioSource(songList,
        initialIndex: index, initialPosition: Duration.zero);
    await player.play();
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

  @override
  Future<void> toggleLoopMode(AudioPlayer player) async {
    try {
      if (player.loopMode == LoopMode.all) {
        await player.setLoopMode(LoopMode.one);
      } else if (player.loopMode == LoopMode.one) {
        await player.setLoopMode(LoopMode.off);
      } else {
        await player.setLoopMode(LoopMode.all);
      }
    } catch (e) {
      throw SongError(message: "Something happens while change loop mode");
    }
  }

  @override
  Future<void> shuffleSong(AudioPlayer player) async {
    try {
      if (player.shuffleModeEnabled) {
        await player.setShuffleModeEnabled(false);
      } else {
        await player.setShuffleModeEnabled(true);
      }
    } catch (e) {
      throw SongError(message: "Something happens while enable shuffle");
    }
  }

  @override
  Future<void> nextSong(AudioPlayer player) async {
    try {
      await player.seekToNext();
    } catch (e) {
      throw SongError(message: "Something happens while play next song");
    }
  }

  @override
  Future<void> previousSong(AudioPlayer player) async {
    try {
      await player.seekToPrevious();
    } catch (e) {
      throw SongError(message: "Something happens while play previous song");
    }
  }
}
