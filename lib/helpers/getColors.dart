import 'package:flutter/material.dart';

Gradient getBusterGradient(String buster) {
  const Map<String, List<Color>> baseColors = {
    "Charizard": [Colors.deepOrange, Colors.deepOrange],
    "Mewtwo": [Colors.deepPurple, Colors.deepPurple],
    "MEW": [Colors.green, Colors.green],
    "Pikachu": [Colors.amberAccent, Colors.amberAccent],
    "Dialga": [Colors.blueAccent, Colors.blueAccent],
    "Palkia": [Colors.pink, Colors.pink],
    "Arceus": [Colors.amber, Colors.amberAccent],
    "LucarioShining": [Colors.deepPurple, Colors.green, Colors.amberAccent],
    "All": [Colors.grey, Colors.grey],
  };

  final defaultColors = [
    Colors.cyan.withOpacity(0.4),
    Colors.cyan.withOpacity(0.4)
  ];
  final base = baseColors[buster] ?? defaultColors;

  double opacity = (buster == "Arceus") ? 0.8 : 0.4;

  final fadedColors = base.map((c) => c.withOpacity(opacity)).toList();

  return LinearGradient(
    colors: fadedColors,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
