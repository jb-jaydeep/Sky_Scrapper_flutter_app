import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../Model/Apimodel.dart';
import '../Model/Helper/HelperModel.dart';

class WeatherProvider extends ChangeNotifier {
  SearchLocation searchLocation = SearchLocation(
    Location: "London",
    locationController: TextEditingController(),
  );

  searchWeather(String location) {
    searchLocation.Location = location;
    notifyListeners();
  }

  Future<Weather?>? weatherData(String location) async {
    searchLocation.weather =
        (await APIHelper.apiHelper.fetchWeatherDetails(location));
    return searchLocation.weather;
  }
}

class ConnectionProvider extends ChangeNotifier {
  Connectivity connectivity = Connectivity();

  ConnectionModel connectivityModel =
      ConnectionModel(connectivityStatus: "waiting");

  void checkInternetConnectivity() {
    connectivityModel.connectivityStream = connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        connectivityModel.connectivityStatus = "WiFi";
        notifyListeners();
      } else if (connectivityResult == ConnectivityResult.mobile) {
        connectivityModel.connectivityStatus = "MobileData";
        notifyListeners();
      } else {
        connectivityModel.connectivityStatus = "waiting";
        notifyListeners();
      }
    });
  }
}

class ThemeProvider extends ChangeNotifier {
  bool isdark = true;
  void Themechanger() {
    isdark = !isdark;
    notifyListeners();
  }
}

class PlatformProvider extends ChangeNotifier {
  bool isIos = false;
  void changePlatform(bool n) {
    isIos = n;
    notifyListeners();
  }
}
