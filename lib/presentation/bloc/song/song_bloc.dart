import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/domain/usecases/pause_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/play_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/resume_song_use_case.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final PlaySongUseCase playSongUseCase;
  final PauseSongUseCase pauseSongUseCase;
  final ResumeSongUseCase resumeSongUseCase;
  final AudioPlayer audioPlayer;
  SongBloc({
    required this.audioPlayer,
    required this.playSongUseCase,
    required this.pauseSongUseCase,
    required this.resumeSongUseCase,
  }) : super(SongInitial()) {
    on<PlaySongEvent>((event, emit) async {
      try {
        emit(SongLoading(event.song));
        playSongUseCase.call(audioPlayer, event.song);

        emit(SongPlayed(event.song, audioPlayer.position));
      } catch (e) {
        print(e.toString());
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
        if (state is SongPaused) {
          resumeSongUseCase.call(audioPlayer);
          emit(SongPlayed((state as SongPaused).song, audioPlayer.position));
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
