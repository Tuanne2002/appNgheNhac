import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:music_player/domain/entities/song/song.dart';

class HomeViewModel extends GetxController {
   // final txtSearch = TextEditingController().obs; 
   var txtSearch = TextEditingController().obs;
  var searchResults = <SongEntity>[].obs;
  var allSongs = <SongEntity>[].obs; // This should contain all your songs

  void search(String query) {
    if (query.isEmpty) {
      searchResults.value = allSongs;
    } else {
      searchResults.value = allSongs
          .where((song) => song.title.toLowerCase().contains(query.toLowerCase()) ||
                           song.artist.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
    final hostRecommendedArr = [
        {
            "image": "assets/img/img_1.png",
            "name": "Đừng Làm Trái Tim Anh Đau",
            "artists": "Sơn Tùng M-TP"
        },
        {
            "image": "assets/img/img_2.png",
            "name": "Phong cách",
            "artists": "MCK"
        },
        {
            "image": "assets/img/img_3.png",
            "name": "Bảnh",
            "artists": "Liên Quân 2"
        },
        {
            "image": "assets/img/img_4.png",
            "name": "One Of The Girls",
            "artists": "Jennie, Lily-Rose"
        }
    ].obs;

    final playListArr = [
        {
            "image": "assets/img/img_3.png",
            "name": "Trap Việt",
            "artists": ""
        },
        {
            "image": "assets/img/img_4.png",
            "name": "Hot Hits Vietnam",
            "artists": ""
        },
        {
            "image": "assets/img/img_5.png",
            "name": "Dangrangto",
            "artists": ""
        }
    ];

    final recentlyPlayedArr = [
        {
            "rate": 4,
            "name": "No Days Off",
            "artists": "Wrxdie, WOKEUP, 2pillz"
            
        },
        {
            "rate": 4,
            "name": "Zai Phố",
            "artists": "Gill"
        },
        {
            "rate": 4,
            "name": "Mai Linh",
            "artists": "Mason Nguyen, 24k.Right"
        },
        {
            "rate": 4,
            "name": "Ổ Quỷ",
            "artists": "DMT, Dangrangto, TeuYungBoy, summerdayy, Rocky CDE"
        }
    ].obs;
}

//.navigationViewStyle(StackNavigationViewStyle())
