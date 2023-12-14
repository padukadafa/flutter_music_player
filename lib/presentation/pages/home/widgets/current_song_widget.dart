import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/injection_container.dart';
import 'package:flutter_music_player/presentation/bloc/song/song_bloc.dart';
import 'package:flutter_music_player/presentation/pages/song_detail/song_detail_page.dart';
import 'package:flutter_music_player/presentation/widgets/play_pause_song_widget.dart';
import 'package:flutter_music_player/presentation/widgets/time_progress_widget.dart';
import 'package:just_audio/just_audio.dart';
import 'package:page_transition/page_transition.dart';

class CurrentSongWidget extends StatelessWidget {
  const CurrentSongWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int?>(
        stream: sl<AudioPlayer>().currentIndexStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return const SizedBox();
          }
          final song = context.read<SongBloc>().state.songList![snapshot.data!];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  curve: Curves.easeIn,
                  child: SongDetailPage(song: song),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(song.title),
                          Text(
                            song.artist ?? "",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          TimeProgressWidget(),
                          PlayPauseSongWidget(
                            iconSize: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
