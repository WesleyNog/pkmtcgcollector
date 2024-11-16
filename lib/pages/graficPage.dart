import 'package:flutter/material.dart';

class GraficPage extends StatelessWidget {
  const GraficPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: GraficPageContent());
  }
}

class GraficPageContent extends StatefulWidget {
  const GraficPageContent({super.key});

  @override
  State<GraficPageContent> createState() => _GraficPageContentState();
}

class _GraficPageContentState extends State<GraficPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Métricas",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Text("Pagina Grafic"),
    );
  }
}
