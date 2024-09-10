import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_player/data/models/song/song.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_player/data/models/song/song.dart';

class SongService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<SongModel>> searchSongs(String query) {
    if (query.isEmpty) {
      return Stream.value([]);
    }

    String lowerCaseQuery = query.toLowerCase();

    return _firestore
        .collection('songs')
        .where('titleLowerCase', isGreaterThanOrEqualTo: lowerCaseQuery)
        .where('titleLowerCase', isLessThanOrEqualTo: lowerCaseQuery + '\uf8ff')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            var songModel = SongModel.fromJson(doc.data());
            songModel.songId = doc.id; // Gán ID tài liệu
            return songModel;
          }).toList();
        });
  }
}