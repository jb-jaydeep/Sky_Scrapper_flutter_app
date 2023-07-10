import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper_flutter_app/Views/utils.dart';

import '../Provider/Provider.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Duration duration = Duration(seconds: 3);

    Timer(duration, () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Provider.of<ThemeProvider>(context).isdark
          ? const Color(0xFF97DAE7).withOpacity(
              0.4,
            )
          : const Color(0xFF97DAE7),
    ));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Provider.of<ThemeProvider>(context).isdark
          ? const Color(0xFFF3D4D9).withOpacity(
              0.4,
            )
          : const Color(0xFF061F3E),
    ));
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  Provider.of<ThemeProvider>(context, listen: false).isdark
                      ? "assets/images/SPBG.png"
                      : "assets/images/dark.jpg"),
              fit: BoxFit.cover),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: h * 0.3,
              width: h * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/sp.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(h * 0.07),
              ),
            ),
            Text(
              "Weather",
              style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isdark
                      ? Colors.black87
                      : Colors.teal,
                  fontSize: 25),
            ),
            Text(
              "Your Quick Weather Report...",
              style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isdark
                      ? Colors.black
                      : Colors.white,
                  fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
