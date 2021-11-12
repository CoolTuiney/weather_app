import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/adress.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/provider/current_location_provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/ui/background/background_image.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.context}) : super(key: key);
  final BuildContext context;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Address?> futureAddress;
  @override
  void initState() {
    futureAddress = context.read<CurrentLocationProvider>().fetchLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CurrentLocationProvider locationProvider =
        Provider.of<CurrentLocationProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<Address?>(
          future: futureAddress,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.connectionState == ConnectionState.done) {
              return BuildWeather(
                context: context,
                size: size,
                place: locationProvider.getAdress!.locality!,
              );
            } else if (snapshot.hasData && snapshot.data == null) {
              return BuildWeather(
                context: context,
                size: size,
                place: 'London',
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class BuildWeather extends StatefulWidget {
  const BuildWeather({
    Key? key,
    required this.size,
    required this.place,
    required this.context,
  }) : super(key: key);

  final Size size;
  final String place;
  final BuildContext context;

  @override
  State<BuildWeather> createState() => _BuildWeatherState();
}

class _BuildWeatherState extends State<BuildWeather> {
  late Future<Weather?> futureWeather;
  late FocusNode focusNode;
  final textController = TextEditingController();
  @override
  void initState() {
    futureWeather =
        context.read<WeatherProvider>().fetchWeather(widget.place, context);
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _weatherProvider = Provider.of<WeatherProvider>(context);
    return FutureBuilder<Weather?>(
        future: futureWeather,
        builder: (_, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () => focusNode.unfocus(),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: BackgroundImage(
                            temperature: _weatherProvider
                                .getWeather!.currentTemperature!)),
                    Positioned(
                        right: 30,
                        top: 110,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            'It\'s ${_weatherProvider.getWeather!.description}',
                            style: TextStyle(
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 0.5
                                  ..color = Colors.black45,
                                fontSize: 30,
                                letterSpacing: 1),
                          ),
                        )),
                    Positioned(
                        right: 30,
                        top: 110,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            'It\'s ${_weatherProvider.getWeather!.description}',
                            style: const TextStyle(
                                fontSize: 30,
                                letterSpacing: 1,
                                color: Colors.white),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: widget.size.width * 0.05,
                          vertical: widget.size.height * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextField(
                                controller: textController,
                                onSubmitted: (text) {
                                  if (text.isNotEmpty) {
                                    context
                                        .read<WeatherProvider>()
                                        .fetchWeather(text, context);
                                  }
                                },
                                textCapitalization: TextCapitalization.words,
                                style: const TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 0.9,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 0.9,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                  hintText: (focusNode.hasFocus)
                                      ? ''
                                      : context
                                          .read<WeatherProvider>()
                                          .getWeather!
                                          .name,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  suffixIcon: (focusNode.hasFocus)
                                      ? IconButton(
                                          onPressed: () {
                                            textController.clear();
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ))
                                      : const SizedBox(),
                                  prefixIcon: const Icon(Icons.search,
                                      color: Colors.white),
                                ),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            _weatherProvider.getWeather!.place!.toUpperCase(),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_weatherProvider.getWeather!.currentTemperature}',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              const Text(
                                '°C',
                                style: TextStyle(
                                    fontSize: 70, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Text(
                            'Feels like ${_weatherProvider.getWeather!.feelsLike}°C',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 130,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.white, width: 2)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${_weatherProvider.getWeather!.humidity}%',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                        const Text('Humidity'),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${_weatherProvider.getWeather!.wind} km/h',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                        const Text('Wind'),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Transform.rotate(
                                            angle: (_weatherProvider.getWeather!
                                                    .windDirection! *
                                                math.pi /
                                                180),
                                            child: const Icon(
                                              Icons.arrow_upward,
                                              color: Colors.white,
                                              size: 30,
                                            )),
                                        const Text('Direction'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
