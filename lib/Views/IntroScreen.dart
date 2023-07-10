import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/Provider.dart';

class OneTimeIntroScreenPage extends StatefulWidget {
  OneTimeIntroScreenPage({super.key});

  @override
  State<OneTimeIntroScreenPage> createState() => _OneTimeIntroScreenPageState();
}

class _OneTimeIntroScreenPageState extends State<OneTimeIntroScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: IntroductionScreen(
            globalBackgroundColor: Provider.of<ThemeProvider>(context).isdark
                ? Colors.white
                : Colors.black,
            pages: [
              PageViewModel(
                title: "Welcome to Weather App",
                body: "",
                image: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/images/i1.png')),
                decoration: PageDecoration(
                  bodyTextStyle: TextStyle(
                      color: Provider.of<ThemeProvider>(context).isdark
                          ? Colors.black87
                          : Colors.teal),
                  titleTextStyle: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isdark
                        ? Colors.black87
                        : Colors.teal,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              PageViewModel(
                title: "Real-Time Weather Updates",
                body: "Get accurate weather information for your location.",
                image: Image.asset('assets/images/i2.jpg'),
                decoration: PageDecoration(
                  bodyTextStyle: TextStyle(
                      color: Provider.of<ThemeProvider>(context).isdark
                          ? Colors.black87
                          : Colors.teal),
                  titleTextStyle: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isdark
                        ? Colors.black87
                        : Colors.teal,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              PageViewModel(
                title: "Know your city's weather",
                body: "Stay up-to-date with the latest weather conditions.",
                image: Center(child: Image.asset('assets/images/i3.png')),
                decoration: PageDecoration(
                  bodyTextStyle: TextStyle(
                      color: Provider.of<ThemeProvider>(context).isdark
                          ? Colors.black87
                          : Colors.teal),
                  titleTextStyle: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isdark
                        ? Colors.black87
                        : Colors.teal,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              PageViewModel(
                title: "Weather Forecasts",
                body: '''Get detailed forecasts for the upcoming days...''',
                image: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/images/i4.png')),
                decoration: PageDecoration(
                  bodyTextStyle: TextStyle(
                      color: Provider.of<ThemeProvider>(context).isdark
                          ? Colors.black87
                          : Colors.teal),
                  titleTextStyle: TextStyle(
                    color: Provider.of<ThemeProvider>(context).isdark
                        ? Colors.black87
                        : Colors.teal,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            onDone: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setBool("isIntroVisited", true);
              Navigator.of(context).pushNamed('SplashScreen');
            },
            showSkipButton: true,
            skip: Text(
              'Skip',
              style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isdark
                      ? Colors.black87
                      : Colors.teal),
            ),
            done: Text(
              'Done',
              style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isdark
                      ? Colors.black87
                      : Colors.teal),
            ),
            next: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Provider.of<ThemeProvider>(context).isdark
                  ? Colors.black87
                  : Colors.teal,
            ),
            dotsDecorator: const DotsDecorator(
              activeSize: Size(15, 15),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
          ),
        ),
      ),
    );
    // });
  }
}
