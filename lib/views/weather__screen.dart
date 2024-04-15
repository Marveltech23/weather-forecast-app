import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather________app/models/const.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  TextEditingController _searchController = TextEditingController();

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Nigeria").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  void _fetchWeather(String cityName) {
    _wf.currentWeatherByCityName(cityName).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  Color generateColor(String input) {
    final int hash = input.hashCode;
    final Random random = Random(hash);
    return Color.fromRGBO(
        random.nextInt(256), random.nextInt(256), random.nextInt(256), 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: generateColor(_weather?.areaName ?? ""),
      body: SingleChildScrollView(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    String cityName = _searchController.text.trim();
                    if (cityName.isNotEmpty) {
                      _fetchWeather(cityName);
                    }
                  },
                ),
              ),
            ),
          ),

          // Expanded(
          //   child: TextField(

          //     controller: _searchController,
          //     decoration: InputDecoration(
          //       labelText: 'Enter city name',
          //     ),
          //   ),

          // ),
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     String cityName = _searchController.text.trim();
          //     if (cityName.isNotEmpty) {
          //       _fetchWeather(cityName);
          //     }
          //   },
          // ),
          _locationHeader(),
          const SizedBox(
            height: 10,
          ),
          _dateTimeInfo(),
          const SizedBox(
            height: 5,
          ),
          _weatherIcon(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _currentTemp(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _extraInfo(),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              " ${DateFormat("d.m.y").format(now)}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 90,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 7, 23, 255),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
