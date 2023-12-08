import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_music_player/domain/usecases/get_song_list_use_case.dart';
import 'package:flutter_music_player/domain/usecases/pause_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/play_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/resume_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/seek_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/shuffle_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/toggle_loop_mode_use_case.dart';
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
  final ToggleLoopModeUseCase toggleLoopModeUseCase;
  final GetSongListUseCase getSongListUseCase;
  final ShuffleSongUseCase shuffleSongUseCase;
  final AudioPlayer audioPlayer;
  SongBloc({
    required this.audioPlayer,
    required this.playSongUseCase,
    required this.pauseSongUseCase,
    required this.resumeSongUseCase,
    required this.seekSongUseCase,
    required this.toggleLoopModeUseCase,
    required this.getSongListUseCase,
    required this.shuffleSongUseCase,
  }) : super(SongInitial()) {
    on<GetSongEvent>((event, emit) async {
      try {
        emit(SongLoading());
        final result = await getSongListUseCase.call();

        if (result.isEmpty) {
          emit(SongError("Can't find song on this device"));
        } else {
          emit(SongLoaded(songList: result));
        }
      } catch (e) {
        emit(SongError("Something Wrong!"));
      }
    });
    on<PlaySongEvent>((event, emit) async {
      try {
        emit(SongPlayLoading(event.songIndex, state.songList));
        playSongUseCase.call(audioPlayer, event.songIndex, state.songList!);
        emit(SongPlayed(state.songList![event.songIndex], audioPlayer.position,
            event.songIndex, state.songList));
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    });
    on<PauseSongEvent>((event, emit) async {
      if (state is SongPlayed) {
        await pauseSongUseCase.call(audioPlayer);
      }
    });
    on<ResumeSongEvent>((event, emit) async {
      try {
        if ((!sl<AudioPlayer>().playing)) {
          resumeSongUseCase.call(audioPlayer);
        }
        if (sl<AudioPlayer>().playing &&
            sl<AudioPlayer>().playerState.processingState ==
                ProcessingState.completed) {
          resumeSongUseCase.call(audioPlayer);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    });
    on<SeekSongEvent>((event, emit) {
      try {
        if (state is SongPlayed) {
          seekSongUseCase.call(audioPlayer, event.duration);
          emit(SongPlayed(state.song!, event.duration, state.currentSongIndex!,
              state.songList));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    });
    on<ChangeSongPositionEvent>((event, emit) {
      emit(SongPlayed(state.song!, event.duration, state.currentSongIndex!,
          state.songList));
    });
    on<ToggleLoopModeEvent>((event, emit) {
      try {
        toggleLoopModeUseCase.call(audioPlayer);
      } catch (e) {
        print(e.toString());
      }
    });
    on<NextSongEvent>((event, emit) {
      try {
        emit(SongPlayLoading(event.songIndex, state.songList));
        playSongUseCase.call(audioPlayer, event.songIndex, state.songList!);
        emit(SongPlayed(state.songList![event.songIndex], audioPlayer.position,
            event.songIndex, state.songList));
      } catch (e) {
        print(e.toString());
      }
    });
    on<PreviousSongEvent>((event, emit) {
      try {
        emit(SongPlayLoading(event.songIndex, state.songList));
        playSongUseCase.call(audioPlayer, event.songIndex, state.songList!);
        emit(SongPlayed(state.songList![event.songIndex], audioPlayer.position,
            event.songIndex, state.songList));
      } catch (e) {
        print(e.toString());
      }
    });
    on<ShuffleSongEvent>((event, emit) {
      try {
        shuffleSongUseCase.call(audioPlayer);
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
