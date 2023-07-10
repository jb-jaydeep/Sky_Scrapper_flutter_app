import 'dart:convert';
import '../Apimodel.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();

  static APIHelper apiHelper = APIHelper._();

  Future<Weather?> fetchWeatherDetails(String location) async {
    String Url =
        "https://api.weatherapi.com/v1/forecast.json?key=e09f03988e1048d2966132426232205&q=";
    String Location = "$location&aqi=no";

    String api = Url + Location;

    http.Response response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);

      Weather weatherData = Weather.formMap(data: decodedData);

      return weatherData;
    }
    return null;
  }
}
