import 'package:flutter/material.dart';
import 'package:pkmtcgcollector/pages/metricsSeasson.dart/SpaceMetrics.dart';
import 'package:pkmtcgcollector/pages/metricsSeasson.dart/apexMetrics.dart';
import 'package:pkmtcgcollector/pages/metricsSeasson.dart/mysticalMetrics.dart';

class GraficPage extends StatefulWidget {
  GraficPage({super.key});

  @override
  State<GraficPage> createState() => _GraficPageState();
}

class _GraficPageState extends State<GraficPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<String> _logos = ["LogoApex", "LogoMystical", "LogoSpace"];

  List<Widget> _pages = [ApexMetrics(), MysticalMetrics(), SpaceMetrics()];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/${_logos[_currentIndex]}.png"),
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
