import 'package:flutter/material.dart';
import 'package:weather_app/weather/controllers/weather_controller.dart'; // Adjust path if needed
import 'package:weather_app/weather/models/weather_model.dart'; // Adjust path if needed
import 'package:intl/intl.dart'; // For date formatting

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherController _weatherController = WeatherController();
  Future<Weather>? _weatherFuture;
  final TextEditingController _cityController = TextEditingController();
  String _currentCity = 'London'; // Default city

  @override
  void initState() {
    super.initState();
    _fetchWeatherForCity(_currentCity);
  }

  void _fetchWeatherForCity(String city) {
    setState(() {
      _weatherFuture = _weatherController.fetchWeather(city);
    });
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_cityController.text.isNotEmpty) {
                      _currentCity = _cityController.text;
                      _fetchWeatherForCity(_currentCity);
                    }
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _currentCity = value;
                  _fetchWeatherForCity(_currentCity);
                }
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<Weather>(
                future: _weatherFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}. Please try again with a valid city name.'),
                    );
                  } else if (snapshot.hasData) {
                    final weather = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            weather.cityName,
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            DateFormat('EEEE, MMMM d').format(DateTime.now()),
                            style: const TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 20),
                          Image.network(
                            weather.iconUrl,
                            width: 100,
                            height: 100,
                          ),
                          Text(
                            '${weather.temperature.round()}°C',
                            style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            weather.description,
                            style: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(height: 30),
                          _buildWeatherDetailRow(
                            icon: Icons.thermostat_outlined,
                            label: 'Feels Like',
                            value: '${weather.feelsLike.round()}°C',
                          ),
                          _buildWeatherDetailRow(
                            icon: Icons.opacity,
                            label: 'Humidity',
                            value: '${weather.humidity}%',
                          ),
                          _buildWeatherDetailRow(
                            icon: Icons.waves,
                            label: 'Wind Speed',
                            value: '${weather.windSpeed.round()} m/s',
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text('Enter a city to get weather information.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetailRow({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}