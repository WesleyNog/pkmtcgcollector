import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pocket_collect/adState.dart';
import 'package:pocket_collect/pages/metricsSeasson.dart/CelestialMetrics.dart';
import 'package:pocket_collect/pages/metricsSeasson.dart/SpaceMetrics.dart';
import 'package:pocket_collect/pages/metricsSeasson.dart/TriumphantMetrics.dart';
import 'package:pocket_collect/pages/metricsSeasson.dart/apexMetrics.dart';
import 'package:pocket_collect/pages/metricsSeasson.dart/mysticalMetrics.dart';
import 'package:pocket_collect/pages/metricsSeasson.dart/shiningMetrics.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class GraficPage extends StatefulWidget {
  GraficPage({super.key});

  @override
  State<GraficPage> createState() => _GraficPageState();
}

class _GraficPageState extends State<GraficPage> {
  BannerAd? _bannerAd;

  void _loadBannerAd() {
    final adState = Provider.of<AdState>(context, listen: false);
    adState.initialization.then((status) {
      setState(() {
        _bannerAd = BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: AdRequest(),
          listener: BannerAdListener(
            onAdLoaded: (ad) => print('Ad loaded: ${ad.adUnitId}'),
            onAdFailedToLoad: (ad, error) {
              print('Ad failed to load: ${ad.adUnitId}, $error');
              ad.dispose();
            },
          ),
        )..load();
      });
    });
  }

  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<String> _logos = [
    "LogoCelestial",
    "LogoShining",
    "LogoTriumph",
    "LogoSpace",
    "LogoMystical",
    "LogoApex"
  ];

  List<Widget> _pages = [
    CelestialMetrics(),
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
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppLocalizations.of(context)!.language == "português"
            ? Image.asset("assets/images/Logo/${_logos[_currentIndex]}_PT.png")
            : Image.asset("assets/images/Logo/${_logos[_currentIndex]}.png"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(Icons.info_outline_rounded),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index];
              },
            ),
          ),
          if (_bannerAd != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 50,
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
        ],
      ),
    );
  }
}
