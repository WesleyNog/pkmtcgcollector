import 'package:flutter/material.dart';

Color getBusterColor(String buster) {
  const Map<String, Color> busterColors = {
    "Charizard": Colors.deepOrange,
    "Mewtwo": Colors.deepPurple,
    "MEW": Colors.green,
    "Pikachu": Colors.amberAccent,
    "Dialga": Colors.blueAccent,
    "Palkia": Colors.pink,
    "Arceus": Colors.amber,
    "All": Colors.grey
  };

  var color = busterColors[buster] == "Arceus"
      ? busterColors[buster]?.withOpacity(0.8)
      : busterColors[buster]?.withOpacity(0.4);

  return color ?? Colors.cyan.withOpacity(0.4);
}
