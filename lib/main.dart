import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/current_location_provider.dart';
import 'package:weather_app/ui/background/splash_scree.dart';
import 'provider/weather_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherProvider>(
            create: (context) => WeatherProvider()),
        ChangeNotifierProvider<CurrentLocationProvider>(
            create: (context) => CurrentLocationProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: const TextTheme(
                headline1: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                headline6: TextStyle(
                    fontSize: 30, color: Colors.white, letterSpacing: 1),
                bodyText2: TextStyle(fontSize: 20, color: Colors.white)),
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen()),
    );
  }
}
