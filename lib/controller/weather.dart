import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/weather/models/weather_model.dart'; // Adjust path if needed

class WeatherController {
  static const String _apiKey = 'YOUR_OPENWEATHERMAP_API_KEY'; // <<<<<<< IMPORTANT: Replace with your API key
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(String cityName) async {
    final response = await http.get(Uri.parse('$_baseUrl?q=$cityName&appid=$_apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}