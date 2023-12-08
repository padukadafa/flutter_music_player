import 'package:flutter_music_player/data/data_sources/local/song_local_data_source_impl.dart';
import 'package:flutter_music_player/data/data_sources/song_local_data_source.dart';
import 'package:flutter_music_player/data/repositories/song_repository_impl.dart';
import 'package:flutter_music_player/domain/repositories/song_repository.dart';
import 'package:flutter_music_player/domain/usecases/get_song_list_use_case.dart';
import 'package:flutter_music_player/domain/usecases/pause_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/play_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/resume_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/seek_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/shuffle_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/stop_song_use_case.dart';
import 'package:flutter_music_player/domain/usecases/toggle_loop_mode_use_case.dart';
import 'package:flutter_music_player/presentation/bloc/song/song_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

final sl = GetIt.instance;

void initInjection() {
  // usecase
  sl.registerLazySingleton<PlaySongUseCase>(() => PlaySongUseCase(sl()));
  sl.registerLazySingleton<PauseSongUseCase>(() => PauseSongUseCase(sl()));
  sl.registerLazySingleton<StopSongUseCase>(() => StopSongUseCase(sl()));
  sl.registerLazySingleton<SeekSongUseCase>(() => SeekSongUseCase(sl()));
  sl.registerLazySingleton<GetSongListUseCase>(() => GetSongListUseCase(sl()));
  sl.registerLazySingleton<ResumeSongUseCase>(() => ResumeSongUseCase(sl()));
  sl.registerLazySingleton<ShuffleSongUseCase>(() => ShuffleSongUseCase(sl()));
  sl.registerLazySingleton<ToggleLoopModeUseCase>(
      () => ToggleLoopModeUseCase(sl()));
  // Repository
  sl.registerLazySingleton<SongRepository>(() => SongRepositoryImpl(sl()));
  // Data source
  sl.registerLazySingleton<SongLocalDataSource>(
      () => SongLocalDataSourceImpl());
  // Player
  sl.registerLazySingleton<AudioPlayer>(() => AudioPlayer());

  // Bloc
  sl.registerFactory<SongBloc>(() => SongBloc(
        audioPlayer: sl(),
        playSongUseCase: sl(),
        pauseSongUseCase: sl(),
        resumeSongUseCase: sl(),
        seekSongUseCase: sl(),
        toggleLoopModeUseCase: sl(),
        getSongListUseCase: sl(),
        shuffleSongUseCase: sl(),
      ));
}
