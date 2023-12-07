import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/injection_container.dart';
import 'package:flutter_music_player/presentation/bloc/song/song_bloc.dart';
import 'package:flutter_music_player/presentation/pages/song_detail/song_detail_page.dart';
import 'package:just_audio/just_audio.dart';
import 'package:page_transition/page_transition.dart';

class CurrentSongWidget extends StatelessWidget {
  const CurrentSongWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        if (state is SongPlayed || state is SongPaused) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  curve: Curves.easeIn,
                  child: SongDetailPage(song: state.song!),
                ),
              );
            },
            child: Container(
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
                      StreamBuilder<PlayerState>(
                          stream: sl<AudioPlayer>().playerStateStream,
                          builder: (context, snapshot) {
                            return Visibility(
                              visible: snapshot.data?.processingState ==
                                      ProcessingState.ready &&
                                  (snapshot.data?.playing ?? false),
                              replacement: IconButton(
                                onPressed: () {
                                  context
                                      .read<SongBloc>()
                                      .add(ResumeSongEvent());
                                },
                                icon: const Icon(Icons.play_arrow),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  context
                                      .read<SongBloc>()
                                      .add(PauseSongEvent());
                                },
                                icon: const Icon(Icons.pause),
                              ),
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
