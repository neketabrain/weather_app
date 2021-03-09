import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Weather {
  final int temperature;
  final double feelsLike;
  final String city;

  Weather({this.temperature, this.feelsLike, this.city});

  factory Weather.fromJson(json) {
    return Weather(
      temperature: json['main']['temp'],
      feelsLike: json['main']['feels_like'],
      city: json['name'],
    );
  }
}

Future<Weather> fetchWeather(String city) async {
  final response = await http.get(Uri.https(
    'api.openweathermap.org',
    '/data/2.5/weather',
    {
      'q': city,
      'appid': env['OPENWEATHER_TOKEN'],
      'units': 'metric',
    },
  ));

  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
