// ignore_for_file: overridden_fields

part of 'song_bloc.dart';

@immutable
sealed class SongState {
  final SongModel? song;
  final Duration? duration;
  const SongState({this.song, this.duration});
}

final class SongInitial extends SongState {}

final class SongPaused extends SongState {
  @override
  final SongModel song;
  @override
  final Duration duration;
  const SongPaused(this.song, this.duration)
      : super(song: song, duration: duration);
}

final class SongPlayed extends SongState {
  @override
  final SongModel song;
  @override
  final Duration duration;
  const SongPlayed(this.song, this.duration)
      : super(song: song, duration: duration);
}

final class SongError extends SongState {}

final class SongLoading extends SongState {
  @override
  final SongModel song;
  const SongLoading(this.song) : super(song: song);
}
