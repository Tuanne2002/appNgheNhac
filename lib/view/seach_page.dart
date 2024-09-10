import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player/audio_helpers/player_invoke.dart';
import 'package:music_player/common/color_extension.dart';
import 'package:music_player/data/models/song/song.dart';
import 'package:music_player/data/models/song/song_service.dart';
import 'package:music_player/domain/entities/song/song.dart';
import 'package:music_player/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:music_player/presentation/song_player/pages/song_player.dart';
import 'package:music_player/core/configs/constants/app_urls.dart';
import 'package:music_player/view/main_player/main_player_view.dart';
import 'package:music_player/view/songs/all_songs_view.dart';
import 'package:music_player/view_model/all_songs_view_model.dart';
import '../../../common/widgets/favorite_button/favorite_button.dart';

class SongSearchPage extends StatelessWidget {
  final AllSongsViewModel viewModel = Get.put(AllSongsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm kiếm bài hát'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => viewModel.searchSongs(value),
              decoration: InputDecoration(
                hintText: 'Nhập từ khóa để tìm kiếm bài hát',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 212, 210, 210)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.search),prefixIconColor: Color.fromARGB(255, 212, 210, 210),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: viewModel.filteredList.length,
                itemBuilder: (context, index) {
                  final song = viewModel.filteredList[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(song['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      song['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: Text(
                      song['artists'],
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.play_arrow),
                      color: Color.fromARGB(255, 244, 65, 110),
                      onPressed: () {
                        playerPlayProcessDebounce(
                          viewModel.filteredList.map((sObj) => {
                            'id': sObj["id"].toString(),
                            'title': sObj["name"].toString(),
                            'artist': sObj["artists"].toString(),
                            'album': sObj["album"].toString(),
                            'genre': sObj["language"].toString(),
                            'image': sObj["image"].toString(),
                            'url': sObj["downloadUrl"].toString(),
                            'user_id': sObj["artistsId"].toString(),
                            'user_name': sObj["artists"].toString(),
                          }).toList(),
                          index,
                        );
                      },
                    ),
                    onTap: () {
                      playerPlayProcessDebounce(
                        viewModel.filteredList.map((sObj) => {
                          'id': sObj["id"].toString(),
                          'title': sObj["name"].toString(),
                          'artist': sObj["artists"].toString(),
                          'album': sObj["album"].toString(),
                          'genre': sObj["language"].toString(),
                          'image': sObj["image"].toString(),
                          'url': sObj["downloadUrl"].toString(),
                          'user_id': sObj["artistsId"].toString(),
                          'user_name': sObj["artists"].toString(),
                        }).toList(),
                        index,
                      );
                      Get.to(() => MainPlayerView(), arguments: song);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}