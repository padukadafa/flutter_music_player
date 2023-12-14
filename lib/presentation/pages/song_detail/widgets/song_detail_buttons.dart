import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/injection_container.dart';
import 'package:flutter_music_player/presentation/bloc/song/song_bloc.dart';
import 'package:flutter_music_player/presentation/widgets/play_pause_song_widget.dart';
import 'package:just_audio/just_audio.dart';

class SongDetailButtons extends StatelessWidget {
  const SongDetailButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StreamBuilder(
          stream: sl<AudioPlayer>().shuffleModeEnabledStream,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return IconButton(
                onPressed: () {
                  context.read<SongBloc>().add(ShuffleSongEvent());
                },
                icon: const Icon(
                  Icons.shuffle_on_sharp,
                  size: 40,
                ),
              );
            }
            return IconButton(
              onPressed: () {
                context.read<SongBloc>().add(ShuffleSongEvent());
              },
              icon: const Icon(
                Icons.shuffle,
                size: 40,
              ),
            );
          },
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.skip_previous,
            size: 40,
          ),
        ),
        const PlayPauseSongWidget(),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.skip_next,
            size: 40,
          ),
        ),
        StreamBuilder(
          stream: sl<AudioPlayer>().loopModeStream,
          builder: (context, snapshot) {
            if (snapshot.data == LoopMode.all) {
              return IconButton(
                onPressed: () {
                  context.read<SongBloc>().add(ToggleLoopModeEvent());
                },
                icon: const Icon(
                  Icons.repeat_on_sharp,
                  size: 40,
                ),
              );
            }
            if (snapshot.data == LoopMode.one) {
              return IconButton(
                onPressed: () {
                  context.read<SongBloc>().add(ToggleLoopModeEvent());
                },
                icon: const Icon(
                  Icons.repeat_one_on_sharp,
                  size: 40,
                ),
              );
            }
            return IconButton(
              onPressed: () {
                context.read<SongBloc>().add(ToggleLoopModeEvent());
              },
              icon: const Icon(
                Icons.repeat,
                size: 40,
              ),
            );
          },
        ),
      ],
    );
  }
}
