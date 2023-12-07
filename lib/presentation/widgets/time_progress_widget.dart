import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/injection_container.dart';
import 'package:just_audio/just_audio.dart';

class TimeProgressWidget extends StatelessWidget {
  const TimeProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
        stream: sl<AudioPlayer>().positionStream,
        builder: (context, snapshot) {
          return Row(
            children: [
              Text(((snapshot.data ?? const Duration(milliseconds: 0))
                      .toString())
                  .substring(3, 7)),
              const Text("/"),
              Text(((sl<AudioPlayer>().duration ??
                          const Duration(milliseconds: 0))
                      .toString())
                  .substring(3, 7)),
              const SizedBox(
                width: 24,
              ),
            ],
          );
        });
  }
}
