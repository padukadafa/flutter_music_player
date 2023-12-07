import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/domain/usecases/get_song_list_use_case.dart';
import 'package:flutter_music_player/injection_container.dart';
import 'package:flutter_music_player/presentation/bloc/song/song_bloc.dart';
import 'package:flutter_music_player/presentation/pages/home/widgets/current_song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Simple Song Player"),
        ),
        body: Column(
          children: [
            FutureBuilder<List<SongModel>>(
              future: sl<GetSongListUseCase>().call(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            context
                                .read<SongBloc>()
                                .add(PlaySongEvent(data[index]));
                          },
                          title: Text(data[index].title),
                          subtitle: Text(
                            Duration(milliseconds: data[index].duration ?? 0)
                                .toString()
                                .substring(3, 7),
                          ),
                        );
                      },
                    ),
                  );
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
