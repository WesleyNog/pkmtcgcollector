import 'package:flutter/material.dart';

Color getBusterColor(String buster) {
  const Map<String, Color> busterColors = {
    "Charizard": Colors.deepOrange,
    "Mewtwo": Colors.deepPurple,
    "MEW": Colors.green,
    "Pikachu": Colors.amberAccent,
    "Dialga": Colors.blueAccent,
    "Palkia": Colors.pink,
    "All": Colors.grey
  };

  return busterColors[buster]?.withOpacity(0.4) ?? Colors.cyan.withOpacity(0.4);
}
