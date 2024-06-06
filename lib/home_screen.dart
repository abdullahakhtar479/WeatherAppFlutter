import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'styles.dart';
import 'login_screen.dart'; // Assuming you have a LoginScreen widget

class HomeScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const HomeScreen({Key? key, required this.onLogout}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  String _cityName = 'New York';
  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _isLoading = true;
    });

    final apiKey = '25825320e9cbeeec72c764327abb7714';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$_cityName&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _weatherData = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      // Handle error here
    }
  }

  String _getWeatherIcon(String condition) {
    if (condition == 'Clear') {
      return 'lib/assets/sunny.png';
    } else if (condition == 'Clouds') {
      return 'lib/assets/cloudy.png';
    } else if (condition == 'Rain') {
      return 'lib/assets/rainy.png';
    } else {
      return 'lib/assets/default.png'; // Use a default asset for unknown conditions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 8),
            Text(
              'Weather Dashboard',
              style: TextStyle(color: AppColors.primary),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primary,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Close drawer and call logout function
                Navigator.pop(context);
                widget.onLogout();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Enter city name',
                filled: true,
                fillColor: AppColors.inputBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  _cityName = value;
                });
                _fetchWeatherData();
              },
            ),
            SizedBox(height: 16),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _weatherData != null
                    ? Column(
                        children: [
                          Card(
                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Today\'s Weather',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        _getWeatherIcon(_weatherData!['weather']
                                            [0]['main']),
                                        height: 50,
                                      ),
                                      Text(
                                        '${_weatherData!['main']['temp']}°C',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        _weatherData!['weather'][0]
                                            ['description'],
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Humidity: ${_weatherData!['main']['humidity']}%',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        'Pressure: ${_weatherData!['main']['pressure']} hPa',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _fetchWeatherData,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('Refresh', style: AppTextStyles.button),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                            'Enter a city name to get weather information')),
          ],
        ),
      ),
    );
  }
}
