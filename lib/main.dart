import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_collect/adState.dart';
import 'package:pocket_collect/pages/graficPage.dart';
import 'package:pocket_collect/pages/homePage.dart';
import 'package:pocket_collect/pages/menuPage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:pocket_collect/l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      Provider.value(
        value: adState,
        builder: (context, child) => const MyApp(),
      ),
    );
    configLoading();
  });
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Pokemon TCG Collector',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      builder: EasyLoading.init(),
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
                  _selectPageIndex = 2;
                });
              },
              icon: Icon(Icons.pie_chart_sharp),
              color: _selectPageIndex == 2 ? Colors.greenAccent : Colors.black,
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
                  _selectPageIndex = 1;
                });
              },
              icon: Icon(Icons.menu_open_rounded),
              color: _selectPageIndex == 1 ? Colors.greenAccent : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
