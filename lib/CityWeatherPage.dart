import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CityWeatherScreen extends StatefulWidget {
  const CityWeatherScreen({super.key});

  @override
  State<CityWeatherScreen> createState() => _CityWeatherScreenState();
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF7895CB),
    ));
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor:
          Color(0xFFA0BFE0), // Change the navigation bar color here
    ));
    return Scaffold(
      backgroundColor: Colors.transparent,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7895CB),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF7895CB),
                Color(0xFFA0BFE0),
              ],
            ),
          ),
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     // Header
          //     Container(
          //       padding: const EdgeInsets.all(16.0),
          //       child: const Text(
          //         'City, Country',
          //         style: TextStyle(
          //           fontSize: 24.0,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //     // Current Weather
          //     Container(
          //       padding: const EdgeInsets.symmetric(
          //           vertical: 16.0, horizontal: 16.0),
          //       child: const Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Icon(
          //             Icons.cloud,
          //             size: 64.0,
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 '24°C',
          //                 style: TextStyle(
          //                   fontSize: 48.0,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               Text(
          //                 'Cloudy',
          //                 style: TextStyle(
          //                   fontSize: 24.0,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     // Forecast
          //     Container(
          //       padding: const EdgeInsets.symmetric(
          //           vertical: 16.0, horizontal: 16.0),
          //       child: const Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Forecast',
          //             style: TextStyle(
          //               fontSize: 24.0,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           SizedBox(height: 16.0),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Column(
          //                 children: [
          //                   Text(
          //                     'Mon',
          //                     style: TextStyle(
          //                       fontSize: 20.0,
          //                     ),
          //                   ),
          //                   Icon(Icons.cloud),
          //                   Text('22°C'),
          //                 ],
          //               ),
          //               Column(
          //                 children: [
          //                   Text(
          //                     'Tue',
          //                     style: TextStyle(
          //                       fontSize: 20.0,
          //                     ),
          //                   ),
          //                   Icon(Icons.wb_sunny),
          //                   Text('30°C'),
          //                 ],
          //               ),
          //               Column(
          //                 children: [
          //                   Text(
          //                     'Wed',
          //                     style: TextStyle(
          //                       fontSize: 20.0,
          //                     ),
          //                   ),
          //                   Icon(Icons.cloud),
          //                   Text('26°C'),
          //                 ],
          //               ),
          //               Column(
          //                 children: [
          //                   Text(
          //                     'Thu',
          //                     style: TextStyle(
          //                       fontSize: 20.0,
          //                     ),
          //                   ),
          //                   Icon(Icons.wb_sunny),
          //                   Text('32°C'),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Hiii",
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    "Hiii",
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "City Name ",
                      style: TextStyle(color: Color(0xFFC5DFF8)),
                    ),
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3C5186),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "City Name ",
                          style: TextStyle(color: Color(0xFFC5DFF8)),
                        ),
                        height: 200,
                        width: 175,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3C5186),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "City Name ",
                          style: TextStyle(color: Color(0xFFC5DFF8)),
                        ),
                        height: 200,
                        width: 175,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3C5186),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "City Name ",
                          style: TextStyle(color: Color(0xFFC5DFF8)),
                        ),
                        height: 200,
                        width: 175,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3C5186),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "City Name ",
                          style: TextStyle(color: Color(0xFFC5DFF8)),
                        ),
                        height: 200,
                        width: 175,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3C5186),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "City Name ",
                          style: TextStyle(color: Color(0xFFC5DFF8)),
                        ),
                        height: 200,
                        width: 175,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3C5186),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "City Name ",
                          style: TextStyle(color: Color(0xFFC5DFF8)),
                        ),
                        height: 200,
                        width: 175,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3C5186),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "City Name ",
                          style: TextStyle(color: Color(0xFFC5DFF8)),
                        ),
                        height: 200,
                        width: 175,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3C5186),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "City Name ",
                          style: TextStyle(color: Color(0xFFC5DFF8)),
                        ),
                        height: 200,
                        width: 175,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3C5186),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "City Name ",
                          style: TextStyle(color: Color(0xFFC5DFF8)),
                        ),
                        height: 200,
                        width: 175,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3C5186),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "City Name ",
                          style: TextStyle(color: Color(0xFFC5DFF8)),
                        ),
                        height: 200,
                        width: 175,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3C5186),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
