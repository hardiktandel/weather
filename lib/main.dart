import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_provider.dart';
import 'constants/strings.dart';
import 'utils/snack_bar.dart';
import 'view/weather/weather_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: appProviders,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        scaffoldMessengerKey: scaffoldMessengerKey,
        home: const WeatherPage(),
      );
}
