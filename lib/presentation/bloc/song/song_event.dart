part of 'song_bloc.dart';

@immutable
sealed class SongEvent {}

class PlaySongEvent extends SongEvent {
  final int songIndex;

  PlaySongEvent(this.songIndex);
}

class GetSongEvent extends SongEvent {}

class StopSongEvent extends SongEvent {}

class PauseSongEvent extends SongEvent {}

class SeekSongEvent extends SongEvent {
  final Duration duration;

  SeekSongEvent(this.duration);
}

class ChangeSongPositionEvent extends SongEvent {
  final Duration duration;
  ChangeSongPositionEvent(this.duration);
}

class ResumeSongEvent extends SongEvent {}

class ToggleLoopModeEvent extends SongEvent {}

class ShuffleSongEvent extends SongEvent {}

class NextSongEvent extends SongEvent {}

class PreviousSongEvent extends SongEvent {}
