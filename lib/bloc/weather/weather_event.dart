part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final city;
  FetchWeather({this.city});
  @override
  // TODO: implement props
  List<Object> get props => [city];
}

class ResetWeather extends WeatherEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
