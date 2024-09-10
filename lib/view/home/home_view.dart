import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/color_extension.dart';
import 'package:music_player/common_widget/recommended_cell.dart';
import 'package:music_player/common_widget/title_section.dart';
import 'package:music_player/presentation/home/widgets/news_songs.dart';
import 'package:music_player/presentation/home/widgets/play_list.dart';
import 'package:music_player/view/seach_page.dart';
import 'package:music_player/view_model/splash_view_model.dart';

import '../../common_widget/playlist_cell.dart';
import '../../common_widget/songs_row.dart';
import '../../common_widget/view_all_section.dart';
import '../../view_model/home_view_model.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeVM = Get.put(HomeViewModel());
  final splashVM = Get.put( SplashViewMode() );
   @override
  void initState() {
     super.initState();
    splashVM.loadView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.bg,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.find<SplashViewMode>().openDrawer();
            },
            icon: Image.asset(
              "assets/img/menu.png",
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            )),
        // title: Row(
        //   children: [
        //     Expanded(
        //       child: Container(
        //         height: 38,
        //         decoration: BoxDecoration(
        //           color: const Color(0xff292E4B),
        //           borderRadius: BorderRadius.circular(19),
        //         ),
        //         child: TextField(
        //           controller: homeVM.txtSearch.value,
        //           decoration: InputDecoration(
        //               focusedBorder: InputBorder.none,
        //               enabledBorder: InputBorder.none,
        //               errorBorder: InputBorder.none,
        //               contentPadding: const EdgeInsets.symmetric(
        //                   vertical: 4, horizontal: 20),
        //               prefixIcon: Container(
        //                 margin: const EdgeInsets.only(left: 20),
        //                 alignment: Alignment.centerLeft,
        //                 width: 30,
        //                 child: Image.asset(
        //                   "assets/img/search.png",
        //                   width: 20,
        //                   height: 20,
        //                   fit: BoxFit.contain,
        //                   color: TColor.primaryText28,
        //                 ),
        //               ),
        //               hintText: "Tìm kiếm bài hát",
        //               hintStyle: TextStyle(
        //                 color: TColor.primaryText28,
        //                 fontSize: 16,
        //               )),
        //         ),
        //       ),
        //     )
        //   ],
        // ),
         title: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Navigate to SearchPage when the search field is tapped
                  Get.to(() =>  SongSearchPage());
                },
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xff292E4B),
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        width: 30,
                        child: Image.asset(
                          "assets/img/search.png",
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          color: TColor.primaryText28,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Tìm kiếm bài hát",
                        style: TextStyle(
                          color: TColor.primaryText28,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleSection(title: "Tuyển tập nhạc hay nhất của các nghệ sĩ" ),
            SizedBox(
              height: 190,
              child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeVM.hostRecommendedArr.length,
                  itemBuilder: (context, index) {
                    var mObj = homeVM.hostRecommendedArr[index];
                    return RecommendedCell(mObj: mObj);
                  }),
            ),
            Divider(
              color: Colors.white.withOpacity(0.07),
              indent: 20,
              endIndent: 20,
            ),
            ViewAllSection(
              title: "Danh sách phát",
              onPressed: () {},
            ),
            SizedBox(
              height: 220,
              child: NewsSongs(),
              // child: ListView.builder(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              //     scrollDirection: Axis.horizontal,
              //     itemCount: homeVM.playListArr.length,
              //     itemBuilder: (context, index) {
              //       var mObj = homeVM.playListArr[index];
              //       return PlaylistCell(mObj: mObj);
              //     }),
            ),
            Divider(
              color: Colors.white.withOpacity(0.07),
              indent: 20,
              endIndent: 20,
            ),
            ViewAllSection(
              title: "Mới phát gần đây",
              onPressed: () {},
            ),
            PlayList(),
            // ListView.builder(
            //     physics: const NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     itemCount: homeVM.recentlyPlayedArr.length,
            //     itemBuilder: (context, index) {
            //       var sObj = homeVM.recentlyPlayedArr[index];
            //       return SongsRow(
            //         sObj: sObj,
            //         onPressed: () {},
            //         onPressedPlay: () {},
            //       );
            //     })
          ],
        ),
      ),
    );
  }
}
