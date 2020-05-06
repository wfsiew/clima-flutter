import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 15000));
const APPID = 'a7ad7659347f6a1abad3fb1dd2c0b30d';
const String API_URL = 'https://api.openweathermap.org/data/2.5/weather';

class NetworkHelper {

  Future getCityData(String cityName) async {
    var res = await dio.get(API_URL, queryParameters: {
      'q': cityName,
      'units': 'metric',
      'appid': APPID,
    });
    return res.data;
  }

  Future getData(double lat, double lon) async {
    var res = await dio.get(API_URL, queryParameters: {
      'lat': lat,
      'lon': lon,
      'units': 'metric',
      'appid': APPID,
    });
    return res.data;
  }
}