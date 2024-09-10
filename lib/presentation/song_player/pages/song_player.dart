import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:music_player/audio_helpers/page_manager.dart';
import 'package:music_player/audio_helpers/service_locator.dart';
import 'package:music_player/common/color_extension.dart';
import 'package:music_player/common_widget/player_bottom_button.dart';
import 'package:music_player/domain/entities/song/song.dart';
import 'package:music_player/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:music_player/presentation/song_player/bloc/song_player_state.dart';
import 'package:music_player/view/main_player/driver_mode_view.dart';
import 'package:music_player/view/main_player/play_playlist_view.dart';

import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../core/configs/constants/app_urls.dart';

class SongPlayerPage extends StatefulWidget {
  final SongEntity songEntity;
  const SongPlayerPage({
    required this.songEntity,
    super.key
  });

  @override
  _SongPlayerPageState createState() => _SongPlayerPageState();
}

class _SongPlayerPageState extends State<SongPlayerPage> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.bg,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            "assets/img/back.png",
            width: 25,
            height: 25,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          "Đang phát",
          style: TextStyle(
              color: TColor.primaryText80,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            color: const Color(0xff383B49),
            offset: const Offset(-10, 15),
            elevation: 1,
            icon: Image.asset(
              "assets/img/more_btn.png",
              width: 20,
              height: 20,
              color: Colors.white,
            ),
            padding: EdgeInsets.zero,
            onSelected: (selectIndex) {
              if (selectIndex == 2) {
                openPlayPlaylistQueue();
              } else if (selectIndex == 9) {
                openDriverModel();
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  height: 30,
                  child: Text(
                    "Chia sẻ",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const PopupMenuItem(
                  value: 2,
                  height: 30,
                  child: Text(
                    "Xếp vào hàng chờ",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const PopupMenuItem(
                  value: 3,
                  height: 30,
                  child: Text(
                    "Thêm vào danh sách...",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const PopupMenuItem(
                  value: 4,
                  height: 30,
                  child: Text(
                    "Lời bài hát",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const PopupMenuItem(
                  value: 5,
                  height: 30,
                  child: Text(
                    "Âm lượng",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const PopupMenuItem(
                  value: 6,
                  height: 30,
                  child: Text(
                    "Chi tiết",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const PopupMenuItem(
                  value: 7,
                  height: 30,
                  child: Text(
                    "Hẹn giờ",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const PopupMenuItem(
                  value: 8,
                  height: 30,
                  child: Text(
                    "Bộ cân bằng",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const PopupMenuItem(
                  value: 9,
                  height: 30,
                  child: Text(
                    "Ô tô",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(
          '${AppURLs.songFirestorage}${widget.songEntity.artist} - ${widget.songEntity.title}.mp3?${AppURLs.mediaAlt}'
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(height: 20,),
              _songDetail(),
              const SizedBox(height: 30,),
              _songPlayer(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            '${AppURLs.coverFirestorage}${widget.songEntity.artist} - ${widget.songEntity.title}.jpg?${AppURLs.mediaAlt}'
          )
        )
      ),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.songEntity.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              widget.songEntity.artist,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14
              ),
            ),
          ],
        ),
        FavoriteButton(
          songEntity: widget.songEntity
        )
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
     var media = MediaQuery.sizeOf(context);
    final pageManager = getIt<PageManager>();
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator();
        } 
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                min: 0.0,
                max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                onChanged: (value) {}
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(context.read<SongPlayerCubit>().songPosition)),
                  Text(formatDuration(context.read<SongPlayerCubit>().songDuration))
                ],
              ),
              const SizedBox(height: 20,),
              
              Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: pageManager.isFirstSongNotifier,
                          builder: (context, isFirst, child) {
                            return SizedBox(
                              width: 45,
                              height: 45,
                              child: IconButton(
                                onPressed:
                                    (isFirst) ? null : pageManager.previous,
                                icon: Image.asset(
                                  "assets/img/previous_song.png",
                                  color: (isFirst)
                                      ? TColor.primaryText35
                                      : TColor.primaryText,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ValueListenableBuilder<ButtonState>(
                          valueListenable: pageManager.playButtonNotifier,
                          builder: (context, value, child) {
                            return SizedBox(
                              width: 75,
                              height: 75,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  if (value == ButtonState.loading)
                                    SizedBox(
                                      width: 75,
                                      height: 75,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                TColor.primaryText),
                                      ),
                                    ),
                                  GestureDetector(
                onTap: () {
                  context.read<SongPlayerCubit>().playOrPauseSong();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 244, 241, 242)
                  ),
                  child: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause : Icons.play_arrow
                  ),
                ),
              ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: pageManager.isLastSongNotifier,
                          builder: (context, isLast, child) {
                            return SizedBox(
                              width: 45,
                              height: 45,
                              child: IconButton(
                                onPressed: (isLast) ? null : pageManager.next,
                                icon: Image.asset(
                                  "assets/img/next_song.png",
                                  color: (isLast)
                                      ? TColor.primaryText35
                                      : TColor.primaryText,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PlayerBottomButton(
                            title: "Danh sách phát",
                            icon: "assets/img/playlist.png",
                            onPressed: () {
                              openPlayPlaylistQueue();
                            }),
                        PlayerBottomButton(
                            title: "Trộn",
                            icon: "assets/img/shuffle.png",
                            onPressed: () {}),
                        PlayerBottomButton(
                            title: "Lặp lại",
                            icon: "assets/img/repeat.png",
                            onPressed: () {}),
                        PlayerBottomButton(
                            title: "EQ",
                            icon: "assets/img/eq.png",
                            onPressed: () {}),
                       
                      ],
                    ),
            ],
          );
        }

        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void openPlayPlaylistQueue() {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, ___, __) => const PlayPlayListView(),
      ),
    );
  }

  void openDriverModel() {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, ___, __) => const DriverModeView(),
      ),
    );
  }
}
