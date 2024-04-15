part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoaded extends WeatherState {
  final WeatherPage weatherPage;
  const WeatherLoaded(this.weatherPage);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherLoaded && other.weatherPage == weatherPage;
  }

  @override
  int get hashCode => weatherPage.hashCode;
}
