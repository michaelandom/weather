import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/internet/internet_bloc.dart';
import 'package:weather/bloc/theme/theme_bloc.dart';
import 'package:weather/bloc/weather/weather_repo.dart';
import 'package:weather/presentation/home_pages.dart';

import 'bloc/weather/weather_bloc.dart';
import 'mybloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(InitLayer(
    connectivity: Connectivity(),
  ));
}

class InitLayer extends StatelessWidget {
  // This widget is the root of your application.
  final Connectivity connectivity;

  InitLayer({this.connectivity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => InternetBloc(connectivity: connectivity),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(weatherRepo: WeatherRepo()),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, event) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: event.themeData,
          home: MyHomePage(),
        );
      },
    );
  }
}
