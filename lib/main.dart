// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'CityWeatherPage.dart';
// import 'Views/weather.dart';
//
// class WeatherApp extends StatefulWidget {
//   @override
//   State<WeatherApp> createState() => _WeatherAppState();
// }
//
// class _WeatherAppState extends State<WeatherApp> {
//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     //   statusBarColor: Color(0xFFBFA2DB),
//     // ));
//     // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     //   systemNavigationBarColor:
//     //       Color(0xFFBFA2DB), // Change the navigation bar color here
//     // ));
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       //  title: 'Weather App',
//       theme: ThemeData(
//         //  primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       routes: {
//         '/': (context) => WeatherScreen(),
//         'cityWeather': (context) => CityWeatherScreen(),
//       },
//     );
//   }
// }
//
// void main() {
//   runApp(WeatherApp());
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CityWeatherPage.dart';
import 'Provider/Provider.dart';
import 'Views/IntroScreen.dart';
import 'Views/IosPlatform.dart';
import 'Views/SplashScreen.dart';
import 'Views/weather.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool visited = pref.getBool("isIntroVisited") ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlatformProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
      ],
      child: Consumer<PlatformProvider>(
        builder: (context, value, _) => (value.isIos == false)
            ? MaterialApp(
                theme: ThemeData(
                  useMaterial3: true,
                  // colorScheme: const ColorScheme.light(),
                ),
                darkTheme: ThemeData(
                  useMaterial3: true,
                  colorScheme: const ColorScheme.dark(
                    brightness: Brightness.dark,
                  ),
                ),
                themeMode: Provider.of<ThemeProvider>(context).isdark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                initialRoute: (visited) ? '/' : 'IntroScreen',
                routes: {
                  '/': (context) => WeatherScreen(),
                  "SplashScreen": (context) => const SplashScreenPage(),
                  'cityWeather': (context) => const CityWeatherScreen(),
                  'IntroScreen': (context) => OneTimeIntroScreenPage(),
                  // 'SplashScreenPage': (context) => const SplashScreenPage(),
                },
              )
            : const CupertinoApp(
                debugShowCheckedModeBanner: false,
                home: IosPlatform(),
              ),
      ),
    ),
  );
}
