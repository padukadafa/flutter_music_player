import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/presentation/bloc/song/song_bloc.dart';
import 'package:intl/intl.dart';

class CurrentSongWidget extends StatelessWidget {
  const CurrentSongWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        if (state is SongPlayed || state is SongPaused) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: const BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.song?.title ?? ""),
                    Visibility(
                      visible: state is SongPaused,
                      replacement: IconButton(
                        onPressed: () {
                          context.read<SongBloc>().add(PauseSongEvent());
                        },
                        icon: const Icon(Icons.pause),
                      ),
                      child: IconButton(
                        onPressed: () {
                          context.read<SongBloc>().add(ResumeSongEvent());
                        },
                        icon: const Icon(Icons.play_arrow),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
