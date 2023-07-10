import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Model/Apimodel.dart';
import '../Provider/Provider.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectionProvider>(context, listen: false)
        .checkInternetConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Provider.of<ThemeProvider>(context).isdark
          ? const Color(0xFF0674D8).withOpacity(
              0.4,
            )
          : const Color(0xFF0674D8),
    ));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Provider.of<ThemeProvider>(context).isdark
          ? const Color(0xFF0475DD).withOpacity(
              0.4,
            )
          : const Color(0xFF061F3E).withOpacity(0.4),
    ));

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            color: (Provider.of<ThemeProvider>(context, listen: false).isdark)
                ? const Color(0xFF061F3E)
                : const Color(0xFF97C8F1),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Button 1',
                child:
                    (Provider.of<ThemeProvider>(context, listen: false).isdark)
                        ? const Text("Change to Dark Mode")
                        : const Text("Change to Light Mode"),
              ),
              PopupMenuItem(
                child:
                    Provider.of<PlatformProvider>(context, listen: false).isIos
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Change  ios to android'),
                              Switch(
                                value: Provider.of<PlatformProvider>(context,
                                        listen: false)
                                    .isIos,
                                onChanged: (value) {
                                  Provider.of<PlatformProvider>(context,
                                          listen: false)
                                      .changePlatform(value as bool);
                                },
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Change android to ios'),
                              Switch(
                                value: Provider.of<PlatformProvider>(context,
                                        listen: false)
                                    .isIos,
                                onChanged: (value) {
                                  Provider.of<PlatformProvider>(context,
                                          listen: false)
                                      .changePlatform(value as bool);
                                },
                              ),
                            ],
                          ),
                value: 'Button 2',
              ),
            ],
            onSelected: (value) {
              if (value == 'Button 1') {
                Provider.of<ThemeProvider>(context, listen: false)
                    .Themechanger();
              } else if (value == 'Button 2') {}
            },
            child: Icon(
              Icons.settings,
              color: Provider.of<ThemeProvider>(context).isdark
                  ? Colors.black87
                  : Colors.white,
            ),
          ),
          SizedBox(
            width: w * 0.03,
          ),
        ],
        backgroundColor:
            Provider.of<ThemeProvider>(context, listen: false).isdark
                ? const Color(0xFF0674D8)
                : const Color(0xFF061F3E),
        title: Text(
          "Weather Forecast",
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isdark
                ? Colors.black
                : Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: (Provider.of<ConnectionProvider>(context)
                  .connectivityModel
                  .connectivityStatus ==
              "Waiting")
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/download.png',
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Text(
                    "No Internet Connection",
                    style: TextStyle(fontSize: h * 0.022),
                  ),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        Provider.of<ThemeProvider>(context, listen: false)
                                .isdark
                            ? "assets/images/light.jpg"
                            : "assets/images/dark.jpg"),
                    fit: BoxFit.cover),
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: Provider.of<WeatherProvider>(context)
                                .searchLocation
                                .locationController,
                            style: TextStyle(
                              color: Provider.of<ThemeProvider>(context).isdark
                                  ? Colors.black87
                                  : Colors.white,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Provider.of<ThemeProvider>(context,
                                              listen: false)
                                          .isdark
                                      ? Colors.black.withOpacity(0.4)
                                      : const Color(0xFF073947)
                                          .withOpacity(0.8),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Provider.of<ThemeProvider>(context,
                                              listen: false)
                                          .isdark
                                      ? Colors.black.withOpacity(0.4)
                                      : const Color(0xFF073947)
                                          .withOpacity(0.8),
                                ),
                              ),
                              fillColor: Colors.transparent,
                              filled: true,
                              suffixIcon: Icon(
                                Icons.search_sharp,
                                color:
                                    Provider.of<ThemeProvider>(context).isdark
                                        ? Colors.black87
                                        : Colors.white,
                              ),
                              hintText: "Search for a city or airport",
                              hintStyle: TextStyle(
                                color: Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .isdark
                                    ? Colors.black87
                                    : Colors.white,
                              ),
                            ),
                            onSubmitted: (val) {
                              if (val.isNotEmpty) {
                                Provider.of<WeatherProvider>(context,
                                        listen: false)
                                    .searchWeather(val);
                                Provider.of<WeatherProvider>(context,
                                        listen: false)
                                    .searchLocation
                                    .locationController
                                    .clear();
                              } else {
                                Provider.of<WeatherProvider>(context,
                                        listen: false)
                                    .searchWeather(Provider.of<WeatherProvider>(
                                            context,
                                            listen: false)
                                        .searchLocation
                                        .Location);
                              }
                            },
                          )),
                    ),
                    FutureBuilder(
                      future:
                          Provider.of<WeatherProvider>(context, listen: false)
                              .weatherData(
                                  (Provider.of<WeatherProvider>(context)
                                      .searchLocation
                                      .Location)),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: h * 0.3,
                                ),
                                Image.asset(
                                  'assets/images/download.png',
                                  height: 200,
                                  width: 200,
                                ),
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Text(
                                  "No Internet Connection\n Please Connect a Network",
                                  style: TextStyle(
                                      fontSize: h * 0.022,
                                      color: Provider.of<ThemeProvider>(context)
                                              .isdark
                                          ? Colors.red
                                          : Colors.red),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasData) {
                          Weather? data = snapshot.data;
                          return (data == null)
                              ? Center(
                                  child: Text(
                                    "No Data Available..",
                                    style: TextStyle(
                                        color:
                                            Provider.of<ThemeProvider>(context)
                                                    .isdark
                                                ? Colors.black
                                                : Colors.white),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 50,
                                                  color:
                                                      Provider.of<ThemeProvider>(
                                                                  context)
                                                              .isdark
                                                          ? Colors.black87
                                                          : Colors.white,
                                                ),
                                                Text(
                                                  data.name,
                                                  style: TextStyle(
                                                    color:
                                                        Provider.of<ThemeProvider>(
                                                                    context)
                                                                .isdark
                                                            ? Colors.black87
                                                            : Colors.white,
                                                    fontSize: h * 0.03,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: w * 0.05,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${data.temp_c}°",
                                                  style: TextStyle(
                                                    color:
                                                        Provider.of<ThemeProvider>(
                                                                    context)
                                                                .isdark
                                                            ? Colors.black87
                                                            : Colors.white,
                                                    fontSize: h * 0.06,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  data.condition,
                                                  style: TextStyle(
                                                    color:
                                                        Provider.of<ThemeProvider>(
                                                                    context)
                                                                .isdark
                                                            ? Colors.black87
                                                            : Colors.white,
                                                    fontSize: h * 0.02,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: h * 0.01,
                                        ),
                                        Column(
                                          children: List.generate(
                                            data.hour.length,
                                            (index) => Container(
                                              margin: EdgeInsets.all(h * 0.01),
                                              padding: EdgeInsets.all(h * 0.02),
                                              height: h * 0.09,
                                              width: w,
                                              decoration: BoxDecoration(
                                                color: Provider.of<
                                                                ThemeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isdark
                                                    ? Colors.white.withOpacity(
                                                        0.4,
                                                      )
                                                    : const Color(0xFF04293E)
                                                        .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        h * 0.02),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  (data.hour[DateTime.now().hour]
                                                                      ['time']
                                                                  .split(
                                                                      "${DateTime.now().day}")[
                                                              0] ==
                                                          data.hour[index]
                                                                  ['time']
                                                              .split(
                                                                  "${DateTime.now().day}")[0])
                                                      ? Text(
                                                          "Now",
                                                          style: TextStyle(
                                                            color: Provider.of<
                                                                            ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                            fontSize: h * 0.022,
                                                          ),
                                                        )
                                                      : Text(
                                                          data.hour[index]
                                                                  ['time']
                                                              .split(
                                                                  "${DateTime.now().day}")[0],
                                                          style: TextStyle(
                                                            color: Provider.of<
                                                                            ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                            fontSize: h * 0.022,
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    height: h * 0.01,
                                                  ),
                                                  Image.network(
                                                    "http:${data.hour[index]['condition']['icon']}",
                                                    height: h * 0.05,
                                                    width: h * 0.05,
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.01,
                                                  ),
                                                  Text(
                                                    "${data.hour[index]['temp_c']}°C",
                                                    style: TextStyle(
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? Colors.black87
                                                              : Colors.white,
                                                      fontSize: h * 0.022,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: h * 0.05,
                                        ),
                                        Container(
                                          height: h * 0.25,
                                          width: w,
                                          decoration: BoxDecoration(
                                            color: Provider.of<ThemeProvider>(
                                                        context,
                                                        listen: false)
                                                    .isdark
                                                ? Colors.white.withOpacity(
                                                    0.4,
                                                  )
                                                : const Color(0xFF04293E)
                                                    .withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(h * 0.02),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.sunny,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? Colors.black87
                                                              : Colors.white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "Sunrise",
                                                      style: TextStyle(
                                                        color:
                                                            Provider.of<ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                        fontSize: h * 0.02,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.003,
                                                    ),
                                                    Text(
                                                      data.sunrise,
                                                      style: TextStyle(
                                                        color:
                                                            Provider.of<ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                        fontSize: h * 0.024,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons.dark_mode_outlined,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? Colors.black87
                                                              : Colors.white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "Sunset",
                                                      style: TextStyle(
                                                        color:
                                                            Provider.of<ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                        fontSize: h * 0.02,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.003,
                                                    ),
                                                    Text(
                                                      data.sunset,
                                                      style: TextStyle(
                                                        color:
                                                            Provider.of<ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                        fontSize: h * 0.024,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: h * 0.05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: h * 0.2,
                                              width: w * 0.45,
                                              decoration: BoxDecoration(
                                                color: Provider.of<
                                                                ThemeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isdark
                                                    ? Colors.white.withOpacity(
                                                        0.4,
                                                      )
                                                    : const Color(0xFF04293E)
                                                        .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        h * 0.02),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.water_drop,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? Colors.black87
                                                              : Colors.white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "Humidity",
                                                      style: TextStyle(
                                                        color:
                                                            Provider.of<ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                        fontSize: h * 0.02,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.003,
                                                    ),
                                                    Row(
                                                      textBaseline: TextBaseline
                                                          .ideographic,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .baseline,
                                                      children: [
                                                        Text(
                                                          "${data.humidity}%",
                                                          style: TextStyle(
                                                            color: Provider.of<
                                                                            ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                            fontSize: h * 0.025,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: h * 0.2,
                                              width: w * 0.45,
                                              decoration: BoxDecoration(
                                                color: Provider.of<
                                                                ThemeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isdark
                                                    ? Colors.white.withOpacity(
                                                        0.4,
                                                      )
                                                    : const Color(0xFF04293E)
                                                        .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        h * 0.02),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.light_mode_outlined,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? Colors.black87
                                                              : Colors.white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "UV Rays",
                                                      style: TextStyle(
                                                        color:
                                                            Provider.of<ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                        fontSize: h * 0.02,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.003,
                                                    ),
                                                    Row(
                                                      textBaseline: TextBaseline
                                                          .ideographic,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .baseline,
                                                      children: [
                                                        Text(
                                                          "${data.uv} Stronger",
                                                          style: TextStyle(
                                                            color: Provider.of<
                                                                            ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                            fontSize: h * 0.025,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: h * 0.2,
                                              width: w * 0.45,
                                              decoration: BoxDecoration(
                                                color: Provider.of<
                                                                ThemeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isdark
                                                    ? Colors.white.withOpacity(
                                                        0.4,
                                                      )
                                                    : const Color(0xFF04293E)
                                                        .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        h * 0.02),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.visibility_outlined,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? Colors.black87
                                                              : Colors.white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "Visibility",
                                                      style: TextStyle(
                                                        color:
                                                            Provider.of<ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                        fontSize: h * 0.02,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.003,
                                                    ),
                                                    Row(
                                                      textBaseline: TextBaseline
                                                          .ideographic,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .baseline,
                                                      children: [
                                                        Text(
                                                          "${data.vis_km} Km",
                                                          style: TextStyle(
                                                            color: Provider.of<
                                                                            ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                            fontSize: h * 0.025,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: h * 0.2,
                                              width: w * 0.45,
                                              decoration: BoxDecoration(
                                                color: Provider.of<
                                                                ThemeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isdark
                                                    ? Colors.white.withOpacity(
                                                        0.4,
                                                      )
                                                    : const Color(0xFF04293E)
                                                        .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        h * 0.02),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.wind_power_rounded,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? Colors.black87
                                                              : Colors.white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "Pressure of Air",
                                                      style: TextStyle(
                                                        color:
                                                            Provider.of<ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                        fontSize: h * 0.02,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.003,
                                                    ),
                                                    Row(
                                                      textBaseline: TextBaseline
                                                          .ideographic,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .baseline,
                                                      children: [
                                                        Text(
                                                          "${data.pressure_mb} hPa",
                                                          style: TextStyle(
                                                            color: Provider.of<
                                                                            ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                            fontSize: h * 0.025,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: h * 0.2,
                                              width: w * 0.45,
                                              decoration: BoxDecoration(
                                                color: Provider.of<
                                                                ThemeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isdark
                                                    ? Colors.white.withOpacity(
                                                        0.4,
                                                      )
                                                    : const Color(0xFF04293E)
                                                        .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        h * 0.02),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.thermostat,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? Colors.black87
                                                              : Colors.white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "Feels Like",
                                                      style: TextStyle(
                                                        color:
                                                            Provider.of<ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                        fontSize: h * 0.02,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.003,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${data.feelslike_c}°C",
                                                          style: TextStyle(
                                                            color: Provider.of<
                                                                            ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                            fontSize: h * 0.025,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: h * 0.2,
                                              width: w * 0.45,
                                              decoration: BoxDecoration(
                                                color: Provider.of<
                                                                ThemeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isdark
                                                    ? Colors.white.withOpacity(
                                                        0.4,
                                                      )
                                                    : const Color(0xFF04293E)
                                                        .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        h * 0.02),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.air,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? Colors.black87
                                                              : Colors.white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "SW wind",
                                                      style: TextStyle(
                                                        color:
                                                            Provider.of<ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                        fontSize: h * 0.02,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.003,
                                                    ),
                                                    Row(
                                                      textBaseline: TextBaseline
                                                          .ideographic,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .baseline,
                                                      children: [
                                                        Text(
                                                          "${data.wind_kph}km/h",
                                                          style: TextStyle(
                                                            color: Provider.of<
                                                                            ThemeProvider>(
                                                                        context)
                                                                    .isdark
                                                                ? Colors.black87
                                                                : Colors.white,
                                                            fontSize: h * 0.025,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        }
                        return Center(
                          child: SizedBox(
                            height: h,
                            width: w,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
