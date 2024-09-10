import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player/core/configs/assets/app_vectors.dart';
import 'package:music_player/presentation/intro/pages/get_started.dart';
import 'package:music_player/view_model/splash_view_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const GetStartedPage()
      )
    );
  }
  //final splashVM = Get.put( SplashViewMode() );
  @override
  void initState() {
    super.initState();
    redirect();
    //splashVM.loadView();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      // body: Center(
      //   child: SvgPicture.asset(
      //     AppVectors.logo
      //   )
      // ),
      body: Center(
        child: Image.asset("assets/img/app_logo.png", width: media.width * 0.30, ),
      ),

    );
  }

  
}