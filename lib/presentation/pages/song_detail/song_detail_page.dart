import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/injection_container.dart';
import 'package:flutter_music_player/presentation/bloc/song/song_bloc.dart';
import 'package:flutter_music_player/presentation/pages/song_detail/widgets/song_detail_buttons.dart';
import 'package:flutter_music_player/presentation/pages/song_detail/widgets/song_detail_time_slider.dart';
import 'package:flutter_music_player/presentation/widgets/play_pause_song_widget.dart';
import 'package:flutter_music_player/presentation/widgets/time_progress_widget.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongDetailPage extends StatelessWidget {
  final SongModel song;
  const SongDetailPage({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<int?>(
            stream: sl<AudioPlayer>().currentIndexStream,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                final songList = context.read<SongBloc>().state.songList!;
                return Text(songList[snapshot.data!].displayName);
              }
              return Text(song.title);
            }),
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
          const SongDetailTimeSlider(),
          const SongDetailButtons(),
        ],
      ),
    );
  }
}
