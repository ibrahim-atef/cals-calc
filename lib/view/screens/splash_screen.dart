import 'package:cals_calc/view/screens/add_user_info_screen.dart';
import 'package:cals_calc/view/screens/main_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isNew = true;

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isNew = preferences.getBool("isNew") ?? true;
    await Future.delayed(const Duration(seconds: 1));
    isNew
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AddInfoScreen()))
        : Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MainScreenLayout()));
  }

  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/icon.png",
              width: 200,
              height: 200,
            ),
          ),
          const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Made by LEVI",
                ),
              ))
        ],
      ),
    );
  }
}
