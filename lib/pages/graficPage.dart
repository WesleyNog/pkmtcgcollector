import 'package:flutter/material.dart';
import 'package:pocket_collect/pages/metricsSeasson.dart/SpaceMetrics.dart';
import 'package:pocket_collect/pages/metricsSeasson.dart/TriumphantMetrics.dart';
import 'package:pocket_collect/pages/metricsSeasson.dart/apexMetrics.dart';
import 'package:pocket_collect/pages/metricsSeasson.dart/mysticalMetrics.dart';
import 'package:pocket_collect/pages/metricsSeasson.dart/shiningMetrics.dart';

class GraficPage extends StatefulWidget {
  GraficPage({super.key});

  @override
  State<GraficPage> createState() => _GraficPageState();
}

class _GraficPageState extends State<GraficPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<String> _logos = [
    "LogoShining",
    "LogoTriumph",
    "LogoSpace",
    "LogoMystical",
    "LogoApex"
  ];

  List<Widget> _pages = [
    ShiningMetrics(),
    TriumphantMetrics(),
    SpaceMetrics(),
    MysticalMetrics(),
    ApexMetrics()
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/images/Logo/${_logos[_currentIndex]}.png"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(Icons.info_outline_rounded),
          )
        ],
      ),
      body: PageView.builder(
          controller: _pageController,
          itemCount: _pages.length,
          onPageChanged: _onPageChanged,
          itemBuilder: (BuildContext context, int index) {
            return _pages[index];
          }),
    );
  }
}
