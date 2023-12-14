import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/domain/usecases/get_song_list_use_case.dart';
import 'package:flutter_music_player/injection_container.dart';
import 'package:flutter_music_player/presentation/bloc/song/song_bloc.dart';
import 'package:flutter_music_player/presentation/pages/home/widgets/current_song_widget.dart';
import 'package:flutter_music_player/presentation/widgets/play_pause_song_widget.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Simple Music Player"),
        ),
        body: Column(
          children: [
            BlocBuilder<SongBloc, SongState>(
              builder: (context, state) {
                if (state is SongError) {
                  return Center(child: Text(state.message));
                }
                if (state is SongLoaded) {
                  final data = state.songList!;
                  return StreamBuilder(
                      stream: sl<AudioPlayer>().currentIndexStream,
                      builder: (context, snapshot) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  context
                                      .read<SongBloc>()
                                      .add(PlaySongEvent(index));
                                },
                                title: Text(data[index].title),
                                subtitle: Text(
                                  Duration(
                                          milliseconds:
                                              data[index].duration ?? 0)
                                      .toString()
                                      .substring(3, 7),
                                ),
                                trailing: Visibility(
                                  child: Visibility(
                                    visible: snapshot.data == index,
                                    child: const PlayPauseSongWidget(
                                      iconSize: 20,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            const CurrentSongWidget(),
          ],
        ));
  }
}
