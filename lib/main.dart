import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/domain/usecases/get_song_list_use_case.dart';
import 'package:flutter_music_player/init.dart';
import 'package:flutter_music_player/injection_container.dart';
import 'package:flutter_music_player/presentation/bloc/song/song_bloc.dart';
import 'package:flutter_music_player/presentation/pages/home/home_page.dart';
import 'package:on_audio_query/on_audio_query.dart';

main() async {
  initInjection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SongBloc>(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
