import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player/common/widgets/appbar/app_bar.dart';
import 'package:music_player/common/widgets/button/basic_app_button.dart';
import 'package:music_player/core/configs/assets/app_vectors.dart';
import 'package:music_player/data/models/auth/signin_user_req.dart';
import 'package:music_player/presentation/auth/pages/signup.dart';
import 'package:music_player/view/home/home_view.dart';
import 'package:music_player/view_model/splash_view_model.dart';

import '../../../domain/usecases/auth/sigin.dart';
import '../../../service_locator.dart';
import '../../home/pages/home.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});


  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 30
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(height: 50,),
            _emailField(context),
            const SizedBox(height: 20,),
            _passwordField(context),
            const SizedBox(height: 20,),
            BasicAppButton(
              onPressed: () async {
                 var result = await sl<SigninUseCase>().call(
                  params: SigninUserReq(
                    email: _email.text.toString(),
                    password: _password.text.toString()
                  )
                );
                result.fold(
                  (l){
                    var snackbar = SnackBar(content: Text(l),behavior: SnackBarBehavior.floating,);
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  },
                  (r){
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (BuildContext context) => const HomeView()), 
                      (route) => false
                    );
                  }
                );
              },
              title: 'Đăng nhập'
            )
      
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Đăng nhập',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 35
      ),
      textAlign: TextAlign.center,
    );
  }
  
 
  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(
      hintText: 'Email',
      hintStyle: TextStyle(color: Colors.white), // Màu chữ của hintText
      enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white), // Màu viền khi không focus
      borderRadius: BorderRadius.circular(8.0), // Bo góc viền
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white), // Màu viền khi focus
      borderRadius: BorderRadius.circular(8.0), // Bo góc viền
    ),
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme
      ),
    );
  }

   Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      obscureText: true,
      decoration: InputDecoration(
      hintText: 'Mật khẩu',
      hintStyle: TextStyle(color: Colors.white), // Màu chữ của hintText
      enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white), // Màu viền khi không focus
      borderRadius: BorderRadius.circular(8.0), // Bo góc viền
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white), // Màu viền khi focus
      borderRadius: BorderRadius.circular(8.0), // Bo góc viền
    ),
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Chưa có tài khoản ? ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18
            ),
          ),
          TextButton(
            onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SignupPage()
                )
              );
            },
            child: const Text(
              'Đăng kí',style: TextStyle(fontSize: 18),
            )
          )
        ],
      ),
    );
  }
}


