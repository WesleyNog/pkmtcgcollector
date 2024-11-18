import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: ManuPageContent());
  }
}

class ManuPageContent extends StatefulWidget {
  const ManuPageContent({super.key});

  @override
  State<ManuPageContent> createState() => _ManuPageContentState();
}

class _ManuPageContentState extends State<ManuPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Configurações",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Text("Pagina Menu"),
    );
  }
}
