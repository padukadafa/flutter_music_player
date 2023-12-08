// ignore_for_file: overridden_fields

part of 'song_bloc.dart';

@immutable
sealed class SongState {
  final SongModel? song;
  final Duration? duration;
  final int? currentSongIndex;
  final List<SongModel>? songList;
  const SongState({
    this.songList,
    this.song,
    this.duration,
    this.currentSongIndex,
  });
}

final class SongInitial extends SongState {}

final class SongLoading extends SongState {}

final class SongLoaded extends SongState {
  final SongModel? song;
  final Duration? duration;
  final int? currentSongIndex;
  @override
  final List<SongModel>? songList;
  const SongLoaded(
      {this.song, this.duration, this.currentSongIndex, this.songList})
      : super(
          songList: songList,
          currentSongIndex: currentSongIndex,
          duration: duration,
          song: song,
        );
  SongState copyWith(
      {SongModel? song,
      Duration? duration,
      int? currentSongIndex,
      List<SongModel>? songList}) {
    return SongLoaded(
        song: song ?? this.song,
        duration: this.duration,
        currentSongIndex: currentSongIndex ?? this.currentSongIndex,
        songList: songList ?? this.songList);
  }
}

final class SongPlayed extends SongLoaded {
  @override
  final SongModel song;
  @override
  final Duration duration;
  @override
  final int currentSongIndex;
  final List<SongModel>? songList;
  const SongPlayed(
      this.song, this.duration, this.currentSongIndex, this.songList)
      : super(
          song: song,
          duration: duration,
          currentSongIndex: currentSongIndex,
          songList: songList,
        );
}

final class SongError extends SongLoaded {
  final String message;
  SongError(this.message);
}

final class SongPlayLoading extends SongLoaded {
  @override
  final int currentSongIndex;
  final List<SongModel>? songList;
  const SongPlayLoading(this.currentSongIndex, this.songList)
      : super(
          currentSongIndex: currentSongIndex,
          songList: songList,
        );
}
