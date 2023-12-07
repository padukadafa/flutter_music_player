import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/injection_container.dart';
import 'package:flutter_music_player/presentation/bloc/song/song_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongDetailPage extends StatelessWidget {
  final SongModel song;
  const SongDetailPage({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(song.title),
      ),
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 350,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 4),
              ],
              image: const DecorationImage(
                image: AssetImage("assets/imgs/sound-image.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          StreamBuilder<Duration>(
            stream: sl<AudioPlayer>().positionStream,
            builder: (context, snapshot) {
              return Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: (snapshot.data?.inMilliseconds ?? 0).toDouble(),
                      max: Duration(
                              milliseconds: (BlocProvider.of<SongBloc>(context)
                                          .state
                                          .song
                                          ?.duration ??
                                      1) +
                                  1000)
                          .inMilliseconds
                          .toDouble(),
                      onChanged: (val) {
                        BlocProvider.of<SongBloc>(context).add(
                            SeekSongEvent(Duration(milliseconds: val.toInt())));
                      },
                    ),
                  ),
                  Text((snapshot.data?.toString() ?? "").substring(3, 7)),
                  const Text("/"),
                  Text((sl<AudioPlayer>().duration.toString()).substring(3, 7)),
                  const SizedBox(
                    width: 24,
                  ),
                ],
              );
            },
            initialData: const Duration(milliseconds: 0),
          ),
          StreamBuilder(
              stream: sl<AudioPlayer>().playerStateStream,
              builder: (context, snapshot) {
                return Visibility(
                  visible:
                      snapshot.data?.processingState == ProcessingState.ready &&
                          (snapshot.data?.playing ?? false),
                  replacement: IconButton(
                    onPressed: () {
                      context.read<SongBloc>().add(ResumeSongEvent());
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      size: 40,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      context.read<SongBloc>().add(PauseSongEvent());
                    },
                    icon: const Icon(
                      Icons.pause,
                      size: 40,
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
