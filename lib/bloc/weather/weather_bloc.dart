import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather/bloc/weather/weather_repo.dart';
import 'package:weather/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo weatherRepo;
  WeatherBloc({this.weatherRepo}) : super(WeatherIsNotSearched());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is FetchWeather) {
      yield WeatherIsLoading();

      try {
        WeatherModel weatherModel = await weatherRepo.getWeather(event.city);
        yield WeatherIsLoaded(weatherModel);
      } catch (e) {
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherIsNotSearched();
    }
  }
}
