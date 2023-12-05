part of 'song_bloc.dart';

@immutable
sealed class SongEvent {}

class PlaySongEvent extends SongEvent {
  final SongModel song;

  PlaySongEvent(this.song);
}

class StopSongEvent extends SongEvent {}

class PauseSongEvent extends SongEvent {}

class SeekSongEvent extends SongEvent {
  final Duration duration;
  SeekSongEvent(this.duration);
}

class ResumeSongEvent extends SongEvent {}
