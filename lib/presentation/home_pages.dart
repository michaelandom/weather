import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/internet/internet_bloc.dart';
import 'package:weather/bloc/theme/theme_bloc.dart';
import 'package:weather/bloc/weather/weather_bloc.dart';
import 'package:weather/consetance/enums.dart';
import 'package:weather/models/weather_model.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDark = false;
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("here"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Switch(
                value: isDark,
                onChanged: (value) {
                  print(value);
                  isDark = value;

                  if (value) {
                    BlocProvider.of<ThemeBloc>(context)
                        .add(ThemeChange(appTheme: AppTheme.Dark));
                  } else {
                    BlocProvider.of<ThemeBloc>(context)
                        .add(ThemeChange(appTheme: AppTheme.Light));
                  }
                }),
            BlocBuilder<InternetBloc, InternetState>(
              builder: (context, state) {
                print("state $state");
                if (state is InternetWifiOrMobileState)
                  return Icon(
                    Icons.wifi,
                    size: 100,
                  );
                else if (state is NoInternetState)
                  return Icon(
                    Icons.wifi_off,
                    size: 100,
                  );
                else
                  return CircularProgressIndicator();
              },
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherIsNotSearched) {
                  return searchWeather();
                } else if (state is WeatherIsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is WeatherIsLoaded) {
                  return searchResult(state.weather, controller.text);
                } else if (state is WeatherIsNotLoaded) {
                  return Center(child: Text("error"));
                }

                return searchWeather();
              },
            ),
            //searchResult(),
          ],
        ),
      ),
    );
  }

  Widget searchWeather() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "location",
              prefix: Icon(Icons.search),
            ),
            onChanged: (value) {},
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<WeatherBloc>(context)
                  .add(FetchWeather(city: controller.text));
            },
            child: Text("get Data"),
          ),
        ],
      ),
    );
  }

  Widget searchResult(WeatherModel weather, String city) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          city,
          style: Theme.of(context).textTheme.headline3,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("temp"),
                Text("${weather.getTemp}"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("temp_max"),
                    Text("${weather.getTempMax}"),
                  ],
                ),
                Column(
                  children: [
                    Text("temp_min"),
                    Text("${weather.getTempMin}"),
                  ],
                ),
              ],
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
          },
          child: Text("search"),
        ),
      ],
    );
  }
}
