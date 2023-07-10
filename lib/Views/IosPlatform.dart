import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Model/Apimodel.dart';
import '../Provider/Provider.dart';

class IosPlatform extends StatefulWidget {
  const IosPlatform({super.key});

  @override
  State<IosPlatform> createState() => _IosPlatformState();
}

class _IosPlatformState extends State<IosPlatform> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).brightness == Brightness.light
          ? CupertinoColors.white.withOpacity(
              0.4,
            )
          : const Color(0xFF061F3E),
    ));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).brightness == Brightness.light
          ? CupertinoColors.white.withOpacity(
              0.4,
            )
          : const Color(0xFF061F3E),
    ));
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Provider.of<ThemeProvider>(context).isdark
            ? const Color(0xFF0674D8)
            : const Color(0xFF061F3E),
        middle: Text(
          "Weather Forecast",
          style: TextStyle(
            fontSize: h * 0.03,
            color: Provider.of<ThemeProvider>(context).isdark
                ? Colors.black
                : Colors.white,
          ),
        ),
        transitionBetweenRoutes: false,
        trailing: GestureDetector(
          onTap: () {
            showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) {
                return CupertinoActionSheet(
                  title: const Text('Settings'),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .Themechanger();
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Provider.of<ThemeProvider>(context).isdark
                          ? const Text('Change to Dark Mode')
                          : const Text('Change to Light Mode'),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {},
                      child: (Provider.of<PlatformProvider>(context).isIos ==
                              false)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Change android to ios'),
                                CupertinoSwitch(
                                  value: Provider.of<PlatformProvider>(context,
                                          listen: false)
                                      .isIos,
                                  onChanged: (value) {
                                    Provider.of<PlatformProvider>(context,
                                            listen: false)
                                        .changePlatform(value);
                                  },
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text('Change  ios to android'),
                                CupertinoSwitch(
                                  value: Provider.of<PlatformProvider>(context,
                                          listen: false)
                                      .isIos,
                                  onChanged: (value) {
                                    Provider.of<PlatformProvider>(context,
                                            listen: false)
                                        .changePlatform(value);
                                  },
                                ),
                              ],
                            ),
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                );
              },
            );
          },
          child: Icon(
            CupertinoIcons.settings,
            color: Provider.of<ThemeProvider>(context).isdark
                ? CupertinoColors.black
                : CupertinoColors.white,
          ),
        ),
      ),
      //  backgroundColor: Colors.red,
      child: (Provider.of<ConnectionProvider>(context)
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
                        child: CupertinoTextField(
                          controller: Provider.of<WeatherProvider>(context)
                              .searchLocation
                              .locationController,
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).isdark
                                ? Colors.black87
                                : Colors.white,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .isdark
                                  ? CupertinoColors.black.withOpacity(0.4)
                                  : const Color(0xFF073947).withOpacity(0.8),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          placeholder: "Search for a city or airport",
                          placeholderStyle: TextStyle(
                            color: Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .isdark
                                ? CupertinoColors.black
                                : CupertinoColors.white,
                          ),
                          prefix: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              CupertinoIcons.search,
                              color: Provider.of<ThemeProvider>(context).isdark
                                  ? CupertinoColors.black
                                  : CupertinoColors.white,
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
                        ),
                      ),
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
                            child: Text("Error : ${snapshot.error}"),
                          );
                        } else if (snapshot.hasData) {
                          Weather? data = snapshot.data;
                          return (data == null)
                              ? const Center(
                                  child: Text("No Data Available.."),
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
                                                  CupertinoIcons
                                                      .location_circle,
                                                  size: 50,
                                                  color: Provider.of<
                                                                  ThemeProvider>(
                                                              context)
                                                          .isdark
                                                      ? CupertinoColors.black
                                                      : CupertinoColors.white,
                                                ),
                                                Text(
                                                  data.name,
                                                  style: TextStyle(
                                                    color: Provider.of<
                                                                    ThemeProvider>(
                                                                context)
                                                            .isdark
                                                        ? CupertinoColors.black
                                                        : CupertinoColors.white,
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
                                                    color: Provider.of<
                                                                    ThemeProvider>(
                                                                context)
                                                            .isdark
                                                        ? CupertinoColors.black
                                                        : CupertinoColors.white,
                                                    fontSize: h * 0.06,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  data.condition,
                                                  style: TextStyle(
                                                    color: Provider.of<
                                                                    ThemeProvider>(
                                                                context)
                                                            .isdark
                                                        ? CupertinoColors.black
                                                        : CupertinoColors.white,
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
                                                    ? CupertinoColors.white
                                                        .withOpacity(
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
                                                                ? CupertinoColors
                                                                    .black
                                                                : CupertinoColors
                                                                    .white,
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
                                                                ? CupertinoColors
                                                                    .black
                                                                : CupertinoColors
                                                                    .white,
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
                                                              ? CupertinoColors
                                                                  .black
                                                              : CupertinoColors
                                                                  .white,
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
                                                ? CupertinoColors.white
                                                    .withOpacity(
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
                                                      CupertinoIcons.sun_max,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? CupertinoColors
                                                                  .black
                                                              : CupertinoColors
                                                                  .white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "Sunrise",
                                                      style: TextStyle(
                                                        color: Provider.of<
                                                                        ThemeProvider>(
                                                                    context)
                                                                .isdark
                                                            ? CupertinoColors
                                                                .black
                                                            : CupertinoColors
                                                                .white,
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
                                                        color: Provider.of<
                                                                        ThemeProvider>(
                                                                    context)
                                                                .isdark
                                                            ? CupertinoColors
                                                                .black
                                                            : CupertinoColors
                                                                .white,
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
                                                      CupertinoIcons.moon,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? CupertinoColors
                                                                  .black
                                                              : CupertinoColors
                                                                  .white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "Sunset",
                                                      style: TextStyle(
                                                        color: Provider.of<
                                                                        ThemeProvider>(
                                                                    context)
                                                                .isdark
                                                            ? CupertinoColors
                                                                .black
                                                            : CupertinoColors
                                                                .white,
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
                                                        color: Provider.of<
                                                                        ThemeProvider>(
                                                                    context)
                                                                .isdark
                                                            ? CupertinoColors
                                                                .black
                                                            : CupertinoColors
                                                                .white,
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
                                                    ? CupertinoColors.white
                                                        .withOpacity(
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
                                                      CupertinoIcons.drop_fill,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? CupertinoColors
                                                                  .black
                                                              : CupertinoColors
                                                                  .white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "Humidity",
                                                      style: TextStyle(
                                                        color: Provider.of<
                                                                        ThemeProvider>(
                                                                    context)
                                                                .isdark
                                                            ? CupertinoColors
                                                                .black
                                                            : CupertinoColors
                                                                .white,
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
                                                                ? CupertinoColors
                                                                    .black
                                                                : CupertinoColors
                                                                    .white,
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
                                                    ? CupertinoColors.white
                                                        .withOpacity(
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
                                                      CupertinoIcons.sun_max,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? CupertinoColors
                                                                  .black
                                                              : CupertinoColors
                                                                  .white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "UV Rays",
                                                      style: TextStyle(
                                                        color: Provider.of<
                                                                        ThemeProvider>(
                                                                    context)
                                                                .isdark
                                                            ? CupertinoColors
                                                                .black
                                                            : CupertinoColors
                                                                .white,
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
                                                                ? CupertinoColors
                                                                    .black
                                                                : CupertinoColors
                                                                    .white,
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
                                                    ? CupertinoColors.white
                                                        .withOpacity(
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
                                                      CupertinoIcons.eye_fill,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? CupertinoColors
                                                                  .black
                                                              : CupertinoColors
                                                                  .white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "Visibility",
                                                      style: TextStyle(
                                                        color: Provider.of<
                                                                        ThemeProvider>(
                                                                    context)
                                                                .isdark
                                                            ? CupertinoColors
                                                                .black
                                                            : CupertinoColors
                                                                .white,
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
                                                                ? CupertinoColors
                                                                    .black
                                                                : CupertinoColors
                                                                    .white,
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
                                                    ? CupertinoColors.white
                                                        .withOpacity(
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
                                                      CupertinoIcons
                                                          .leaf_arrow_circlepath,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? CupertinoColors
                                                                  .black
                                                              : CupertinoColors
                                                                  .white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "Pressure of Air",
                                                      style: TextStyle(
                                                        color: Provider.of<
                                                                        ThemeProvider>(
                                                                    context)
                                                                .isdark
                                                            ? CupertinoColors
                                                                .black
                                                            : CupertinoColors
                                                                .white,
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
                                                                ? CupertinoColors
                                                                    .black
                                                                : CupertinoColors
                                                                    .white,
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
                                                    ? CupertinoColors.white
                                                        .withOpacity(
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
                                                      CupertinoIcons
                                                          .thermometer,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? CupertinoColors
                                                                  .black
                                                              : CupertinoColors
                                                                  .white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "Feels Like",
                                                      style: TextStyle(
                                                        color: Provider.of<
                                                                        ThemeProvider>(
                                                                    context)
                                                                .isdark
                                                            ? CupertinoColors
                                                                .black
                                                            : CupertinoColors
                                                                .white,
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
                                                                ? CupertinoColors
                                                                    .black
                                                                : CupertinoColors
                                                                    .white,
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
                                                    ? CupertinoColors.white
                                                        .withOpacity(
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
                                                      CupertinoIcons.wind,
                                                      size: h * 0.04,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .isdark
                                                              ? CupertinoColors
                                                                  .black
                                                              : CupertinoColors
                                                                  .white,
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    Text(
                                                      "SW wind",
                                                      style: TextStyle(
                                                        color: Provider.of<
                                                                        ThemeProvider>(
                                                                    context)
                                                                .isdark
                                                            ? CupertinoColors
                                                                .black
                                                            : CupertinoColors
                                                                .white,
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
                                                                ? CupertinoColors
                                                                    .black
                                                                : CupertinoColors
                                                                    .white,
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
                                CupertinoActivityIndicator(),
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
