import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_music_player/domain/usecases/pause_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/play_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/resume_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/seek_song_use_case.dart';
import 'package:flutter_music_player/injection_container.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final PlaySongUseCase playSongUseCase;
  final PauseSongUseCase pauseSongUseCase;
  final ResumeSongUseCase resumeSongUseCase;
  final SeekSongUseCase seekSongUseCase;
  final AudioPlayer audioPlayer;
  SongBloc({
    required this.audioPlayer,
    required this.playSongUseCase,
    required this.pauseSongUseCase,
    required this.resumeSongUseCase,
    required this.seekSongUseCase,
  }) : super(SongInitial()) {
    on<PlaySongEvent>((event, emit) async {
      try {
        emit(SongLoading(event.song));
        playSongUseCase.call(audioPlayer, event.song);
        emit(SongPlayed(event.song, audioPlayer.position));
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    });
    on<PauseSongEvent>((event, emit) async {
      if (state is SongPlayed) {
        await pauseSongUseCase.call(audioPlayer);
        emit(SongPaused((state as SongPlayed).song, audioPlayer.position));
      }
    });
    on<ResumeSongEvent>((event, emit) async {
      try {
        if ((!sl<AudioPlayer>().playing)) {
          resumeSongUseCase.call(audioPlayer);
          emit(SongPlayed((state as SongPaused).song, audioPlayer.position));
        }
        if (sl<AudioPlayer>().playing &&
            sl<AudioPlayer>().playerState.processingState ==
                ProcessingState.completed) {
          resumeSongUseCase.call(audioPlayer);
          emit(SongPlayed((state as SongPaused).song, audioPlayer.position));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    });
    on<SeekSongEvent>((event, emit) {
      try {
        if (state is SongPlayed || state is SongPaused) {
          seekSongUseCase.call(audioPlayer, event.duration);
          emit(SongPlayed(state.song!, event.duration));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    });
    on<ChangeSongPositionEvent>((event, emit) {
      if (state is SongPlayed) {
        emit(SongPlayed(state.song!, event.duration));
      }
      if (state is SongPaused) {
        emit(SongPaused(state.song!, event.duration));
      }
    });
  }
}
