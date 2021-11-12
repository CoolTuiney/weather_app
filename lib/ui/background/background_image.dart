import 'package:flutter/material.dart';


class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key, required this.temperature}) : super(key: key);
  final int temperature;

  @override
  Widget build(BuildContext context) {
    if (temperature > 20) {
      return Image.asset(
        'assets/background/summer.png',
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(
        'assets/background/winter.png',
        fit: BoxFit.fill,
      );
    }
  }
}
