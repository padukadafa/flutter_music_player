import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/injection_container.dart';
import 'package:flutter_music_player/presentation/bloc/song/song_bloc.dart';
import 'package:flutter_music_player/presentation/widgets/time_progress_widget.dart';
import 'package:just_audio/just_audio.dart';

class SongDetailTimeSlider extends StatelessWidget {
  const SongDetailTimeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StreamBuilder(
            stream: sl<AudioPlayer>().playbackEventStream,
            builder: (context, snap) {
              return StreamBuilder<Duration>(
                stream: sl<AudioPlayer>().positionStream,
                builder: (context, snapshot) {
                  return Expanded(
                    child: Slider(
                      value: (snapshot.data?.inMilliseconds ?? 0).toDouble(),
                      max: Duration(
                              milliseconds:
                                  (snap.data?.duration?.inMilliseconds ?? 1) +
                                      1000)
                          .inMilliseconds
                          .toDouble(),
                      onChanged: (val) {
                        BlocProvider.of<SongBloc>(context).add(
                            SeekSongEvent(Duration(milliseconds: val.toInt())));
                      },
                    ),
                  );
                },
                initialData: const Duration(milliseconds: 0),
              );
            }),
        const TimeProgressWidget(),
      ],
    );
  }
}
