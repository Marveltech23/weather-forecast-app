import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather________app/views/weather__screen.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());
  void emitWeatherLoaded(WeatherPage weatherPage) {
    emit(WeatherLoaded(weatherPage));
  }
}
