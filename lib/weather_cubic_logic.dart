import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather________app/views/weather__screen.dart';
import 'package:weather________app/weather_cubit.dart';

class WeatherCubitLogics extends StatefulWidget {
  const WeatherCubitLogics({super.key});

  @override
  State<WeatherCubitLogics> createState() => _WeatherCubitLogicsState();
}

class _WeatherCubitLogicsState extends State<WeatherCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        // ignore: unnecessary_type_check
        if (state is WeatherState) {
          return const WeatherPage();
        } else {
          return Container();
        }
      }),
    );
  }
}
