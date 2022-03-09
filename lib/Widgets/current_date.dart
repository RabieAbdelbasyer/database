import 'package:dio/dio.dart';

Future<String?> getCurrentDate() async {
  Response response =
      await Dio().get('http://worldtimeapi.org/api/timezone/Africa/Cairo');
  return response.data['datetime'];
}
