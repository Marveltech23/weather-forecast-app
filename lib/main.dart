import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather________app/views/weather__screen.dart';
import 'package:weather________app/weather_cubic_logic.dart';
import 'package:weather________app/weather_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(),
          child: const WeatherCubitLogics(),
        ));
  }
}
