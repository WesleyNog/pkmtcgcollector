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
    "Shining": [
      Colors.pinkAccent,
      Colors.deepPurple,
      Colors.blueAccent,
      Colors.green,
      Colors.greenAccent,
      Colors.amberAccent
    ],
    "Solgaleo": [Colors.red, Colors.red],
    "Lunala": [Colors.blue, Colors.blue],
    "Buzzwole": [Colors.red, Colors.red],
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
