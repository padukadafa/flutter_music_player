import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/injection_container.dart';
import 'package:flutter_music_player/presentation/bloc/song/song_bloc.dart';
import 'package:just_audio/just_audio.dart';

class PlayPauseSongWidget extends StatelessWidget {
  final double iconSize;
  const PlayPauseSongWidget({super.key, this.iconSize = 40.0});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: sl<AudioPlayer>().playerStateStream,
      builder: (context, snapshot) {
        return Visibility(
          visible: snapshot.data?.processingState == ProcessingState.ready &&
              (snapshot.data?.playing ?? false),
          replacement: IconButton(
            onPressed: () {
              context.read<SongBloc>().add(ResumeSongEvent());
            },
            icon: Icon(
              Icons.play_arrow,
              size: iconSize,
            ),
          ),
          child: IconButton(
            onPressed: () {
              context.read<SongBloc>().add(PauseSongEvent());
            },
            icon: Icon(
              Icons.pause,
              size: iconSize,
            ),
          ),
        );
      },
    );
  }
}
