import 'package:flutter/material.dart';
import 'package:pkmtcgcollector/pages/graficPage.dart';
import 'package:pkmtcgcollector/pages/homePage.dart';
import 'package:pkmtcgcollector/pages/menuPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon TCG Collector',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [HomePage(), MenuPage(), GraficPage()];

    return Scaffold(
      body: _pages[_selectPageIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _selectPageIndex = 1;
                });
              },
              icon: Icon(Icons.menu_open_rounded),
              color: _selectPageIndex == 1 ? Colors.greenAccent : Colors.black,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectPageIndex = 0;
                });
              },
              icon: Icon(Icons.home_max_rounded),
              color: _selectPageIndex == 0 ? Colors.greenAccent : Colors.black,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectPageIndex = 2;
                });
              },
              icon: Icon(Icons.pie_chart_sharp),
              color: _selectPageIndex == 2 ? Colors.greenAccent : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
