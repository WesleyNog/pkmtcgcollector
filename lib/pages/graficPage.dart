import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pkmtcgcollector/resources/pokemonInfos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

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
  List<Map<String, dynamic>> _pokemonList = [];

  Future<void> _loadPokemonList() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getString('pokemonList');

    if (savedList != null) {
      setState(() {
        _pokemonList = List<Map<String, dynamic>>.from(jsonDecode(savedList));
      });
    } else {
      // Carregar a lista padrão
      setState(() {
        _pokemonList = infoPokemons;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPokemonList();
  }

  int obtido(String pack) {
    if (pack == "Total") {
      return _pokemonList.where((pokemon) => pokemon["obtido"] == true).length;
    }

    return _pokemonList
        .where(
            (pokemon) => pokemon["buster"] == pack && pokemon["obtido"] == true)
        .length;
  }

  int totalPokemon(String pack) {
    if (pack == "Total") {
      return _pokemonList.length;
    }

    return _pokemonList
        .where((pokemon) =>
            pokemon["buster"] == pack || pokemon["buster"] == "All")
        .length;
  }

  String percentBuster(String pack) {
    return ((obtido(pack) / totalPokemon(pack)) * 100).toStringAsFixed(3);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> packCounts = {
      "Charizard": obtido("Charizard"),
      "Mewtwo": obtido("Mewtwo"),
      "Pikachu": obtido("Pikachu"),
      "All": obtido("All"),
    };
    Map<String, Color> packColors = {
      "Charizard": Colors.deepOrange,
      "Mewtwo": Colors.deepPurple,
      "Pikachu": Colors.amberAccent,
      "All": Colors.green,
    };

    List<PieChartSectionData> sections = [];
    packCounts.forEach((key, value) {
      double percentage = (value / obtido("Total")) * 100;
      sections.add(
        PieChartSectionData(
          value: percentage,
          title: '${percentage.toStringAsFixed(1)}%',
          color: packColors[key] ?? Colors.grey,
          radius: 50,
          titleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Métricas",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              obtido("Total") <= 0
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.5,
                          child: PieChart(
                            PieChartData(
                              sectionsSpace: 5,
                              // centerSpaceRadius: 110,
                              sections: sections,
                            ),
                          ),
                        ),
                        Positioned(
                            left: 135,
                            top: 80,
                            child: Text(
                              "${obtido("Total")}",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Coleção",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DataTable(sortColumnIndex: 0, sortAscending: true, columns: [
                DataColumn(label: Text("Buster")),
                DataColumn(label: Text("Totais")),
                DataColumn(label: Text("%")),
              ], rows: [
                DataRow(cells: [
                  DataCell(Text("Charizard")),
                  DataCell(Text(
                      "${obtido("Charizard")}/${totalPokemon("Charizard")}")),
                  DataCell(Text("${percentBuster("Charizard")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Mewtwo")),
                  DataCell(
                      Text("${obtido("Mewtwo")}/${totalPokemon("Mewtwo")}")),
                  DataCell(Text("${percentBuster("Mewtwo")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Pikachu")),
                  DataCell(
                      Text("${obtido("Pikachu")}/${totalPokemon("Pikachu")}")),
                  DataCell(Text("${percentBuster("Pikachu")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Total")),
                  DataCell(Text("${obtido("Total")}/${totalPokemon("Total")}")),
                  DataCell(Text("${percentBuster("Total")}%")),
                ]),
              ]),
              SizedBox(
                height: 20,
              ),
              Text(
                "Caminho p/ MEW",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DataTable(sortColumnIndex: 0, sortAscending: true, columns: [
                DataColumn(label: Text("Buster")),
                DataColumn(label: Text("Totais")),
                DataColumn(label: Text("%")),
              ], rows: [
                DataRow(cells: [
                  DataCell(Text("Charizard")),
                  DataCell(Text(
                      "${obtido("Charizard")}/${totalPokemon("Charizard")}")),
                  DataCell(Text("${percentBuster("Charizard")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Mewtwo")),
                  DataCell(
                      Text("${obtido("Mewtwo")}/${totalPokemon("Mewtwo")}")),
                  DataCell(Text("${percentBuster("Mewtwo")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Pikachu")),
                  DataCell(
                      Text("${obtido("Pikachu")}/${totalPokemon("Pikachu")}")),
                  DataCell(Text("${percentBuster("Pikachu")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Total")),
                  DataCell(Text("${obtido("Total")}/${totalPokemon("Total")}")),
                  DataCell(Text("${percentBuster("Total")}%")),
                ]),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
