import 'package:get/get.dart';

class PlaylistsViewModel extends GetxController {
    final playlistArr = [
        {
            "image":"assets/img/playlist_1.png",
            "name":"Trap Việt",
            "songs":"100 bài hát"
        },
        {
            "image": "assets/img/playlist_2.png",
            "name": "Daily Mix 3",
            "songs": "323 bài hát"
        },
        {
            "image": "assets/img/playlist_3.png",
            "name": "Hot Hits Vietnam",
            "songs": "450 bài hát"
        },
        {
            "image": "assets/img/playlist_4.png",
            "name": "lofi",
            "songs": "966 bài hát"
        }
    ].obs;

    final myPlaylistArr = [
        {
            "image": "assets/img/mp_1.png",
            "name": "Trap Việt"
        },
        {
            "image": "assets/img/mp_2.png",
            "name": "lofi chill"
        },
        {
            "image": "assets/img/mp_3.png",
            "name": "Dangrangto"
        },
        {
            "image": "assets/img/mp_4.png",
            "name": "Daily Mix 2"
        }
    ].obs;

}
