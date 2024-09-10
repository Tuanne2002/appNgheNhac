import 'package:get/get.dart';

class ArtistsViewModel extends GetxController {
  final allList = [
    {
      "image": "assets/img/ar_1.png",
      "name": "Sơn Tùng M-TP",
      "albums": "4 albums",
      "songs": "38 bài hát"
    },
    {
      "image": "assets/img/ar_2.png",
      "name": "HIEUTHUHAI",
      "albums": "2 albums",
      "songs": "18 bài hát"
    },
    {
      "image": "assets/img/ar_3.png",
      "name": "MCK",
      "albums": "5 albums",
      "songs": "46 bài hát"
    },
    {
      "image": "assets/img/ar_4.png",
      "name": "tlinh",
      "albums": "10 albums",
      "songs": "50 bài hát"
    },
    {
      "image": "assets/img/ar_5.png",
      "name": "Wrxdie",
      "albums": "3 albums",
      "songs": "32 bài hát"
    },
    {
      "image": "assets/img/ar_6.png",
      "name": "Dangrangto",
      "albums": "1 albums",
      "songs": "13 bài hát"
    }
  ].obs;


  final albumsArr = [
    {
      "image":"assets/img/ar_d_1.png",
      "name":"m-tp M-TP",
      "year":"2017",
    },
    {
      "image": "assets/img/ar_d_2.png",
      "name": "Sky Tour",
      "year": "2020",
    },
    {
      "image":"assets/img/ar_d_3.png",
      "name":"Chúng ta",
      "year":"2021",
    },
    {
      "image": "assets/img/ar_d_4.png",
      "name": "Chàng trai năm ấy OST",
      "year": "2014",
    },
  ];


  final playedArr = [
    {"duration": "0:33", "name": "00", "artists": "MCK"},
    {"duration": "2:36", "name": "Chìm Sâu", "artists": "MCK"},
    {"duration": "3:58", "name": "Suit & Tie", "artists": "MCK, Hoàng Tôn"},
    {
      "duration": "3:10",
      "name": "Va Vào Giai Điệu Này",
      "artists": "MCK"
    },
    {"duration": "0:33", "name": "00", "artists": "MCK"},
    {"duration": "2:36", "name": "Chìm Sâu", "artists": "MCK"},
    {"duration": "3:58", "name": "Suit & Tie", "artists": "MCK, Hoàng Tôn"},
    {
      "duration": "3:10",
      "name": "Va Vào Giai Điệu Này",
      "artists": "MCK"
    },
    {"duration": "0:33", "name": "00", "artists": "MCK"},
    {"duration": "2:36", "name": "Chìm Sâu", "artists": "MCK"},
    {"duration": "3:58", "name": "Suit & Tie", "artists": "MCK, Hoàng Tôn"},
    {
      "duration": "3:10",
      "name": "Va Vào Giai Điệu Này",
      "artists": "MCK"
    }
  ].obs;
 
}
