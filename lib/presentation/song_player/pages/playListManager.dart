import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:music_player/data/models/song/song.dart';
import 'package:music_player/domain/entities/song/song.dart';


class PlaylistManager extends GetxController {
  final List<SongEntity> playlist = <SongEntity>[].obs;
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPlaylist();
  }

  Future<void> fetchPlaylist() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('songs').get();
      playlist.addAll(snapshot.docs.map((doc) => SongModel.fromJson(doc.data() as Map<String, dynamic>).toEntity()).toList());
    } catch (e) {
      print('Error fetching playlist: $e');
    }
  }

  void nextSong() {
    if (currentIndex.value < playlist.length - 1) {
      currentIndex.value++;
    }
  }

  void previousSong() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
  }

  SongEntity get currentSong => playlist[currentIndex.value];
}
