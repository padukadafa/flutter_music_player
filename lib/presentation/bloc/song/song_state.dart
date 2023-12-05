part of 'song_bloc.dart';

@immutable
sealed class SongState {
  final SongModel? song;
  final Duration? duration;
  SongState({this.song, this.duration});
}

final class SongInitial extends SongState {}

final class SongPaused extends SongState {
  final SongModel song;
  final Duration duration;
  SongPaused(this.song, this.duration) : super(song: song, duration: duration);
}

final class SongPlayed extends SongState {
  final SongModel song;
  final Duration duration;
  SongPlayed(this.song, this.duration) : super(song: song, duration: duration);
}

final class SongError extends SongState {}

final class SongLoading extends SongState {
  final SongModel song;
  SongLoading(this.song) : super(song: song);
}
