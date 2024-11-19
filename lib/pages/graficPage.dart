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

  int obtidoMew(String pack) {
    if (pack == "Total") {
      return _pokemonList
          .where(
              (pokemon) => pokemon["MEW"] == true && pokemon["obtido"] == true)
          .length;
    }

    return _pokemonList
        .where((pokemon) =>
            pokemon["buster"] == pack &&
            pokemon["obtido"] == true &&
            pokemon["MEW"] == true)
        .length;
  }

  int totalPokemon(String pack) {
    if (pack == "Total") {
      return _pokemonList.length;
    }

    return _pokemonList.where((pokemon) => pokemon["buster"] == pack).length;
  }

  int totalMew(pack) {
    if (pack == "Total") {
      return _pokemonList.where((pokemon) => pokemon["MEW"] == true).length;
    }

    return _pokemonList
        .where((pokemon) => pokemon["buster"] == pack && pokemon["MEW"] == true)
        .length;
  }

  String percentBuster(String pack) {
    return ((obtido(pack) / totalPokemon(pack)) * 100).toStringAsFixed(3);
  }

  String percentMew(String pack) {
    return ((obtidoMew(pack) / totalMew(pack)) * 100).toStringAsFixed(3);
  }

  String chanceCard(String chance, String pack) {
    List<String> _raridades = [
      "🔹",
      "🔹🔹",
      "🔹🔹🔹",
      "🔹🔹🔹🔹",
      "⭐️",
      "⭐️⭐️",
      "⭐️⭐️⭐️",
      "👑"
    ];
    double _sum = 0.0;
    for (String raridade in _raridades) {
      var sumPack = _pokemonList
          .where((pokemon) =>
              pokemon["obtido"] == false &&
              pokemon["raridade"] == raridade &&
              pokemon["buster"] == pack)
          .fold(0.0, (soma, pokemon) {
        return soma + (pokemon[chance] ?? 0.0);
      });
      var sumAll = _pokemonList
          .where((pokemon) =>
              pokemon["obtido"] == false &&
              pokemon["raridade"] == raridade &&
              pokemon["buster"] == "All")
          .fold(0.0, (soma, pokemon) {
        return soma + (pokemon[chance] ?? 0.0);
      });

      _sum = _sum + sumPack + sumAll;
    }
    return _sum.toString().padLeft(3);
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
                  : AspectRatio(
                      aspectRatio: 2,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 5,
                          centerSpaceRadius: 50,
                          sections: sections,
                        ),
                      ),
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
                  DataCell(Text("All")),
                  DataCell(Text("${obtido("All")}/${totalPokemon("All")}")),
                  DataCell(Text("${percentBuster("All")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Total")),
                  DataCell(Text("${obtido("Total")}/${totalPokemon("Total")}")),
                  DataCell(Text("${percentBuster("Total")}%")),
                ]),
              ]),
              SizedBox(
                height: 40,
              ),
              Text(
                "Chance de novas cartas",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DataTable(columns: [
                DataColumn(label: Text("1-3")),
                DataColumn(label: Text("4")),
                DataColumn(label: Text("5")),
              ], rows: [
                DataRow(cells: [
                  DataCell(Text("${chanceCard("chance_1_3", "Charizard")}%")),
                  DataCell(Text("${chanceCard("chance_4", "Charizard")}%")),
                  DataCell(Text("${chanceCard("chance_5", "Charizard")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("${chanceCard("chance_1_3", "Mewtwo")}%")),
                  DataCell(Text("${chanceCard("chance_4", "Mewtwo")}%")),
                  DataCell(Text("${chanceCard("chance_5", "Mewtwo")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("${chanceCard("chance_1_3", "Pikachu")}%")),
                  DataCell(Text("${chanceCard("chance_4", "Pikachu")}%")),
                  DataCell(Text("${chanceCard("chance_5", "Pikachu")}%")),
                ])
              ]),
              SizedBox(
                height: 40,
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
                      "${obtidoMew("Charizard")}/${totalMew("Charizard")}")),
                  DataCell(Text("${percentMew("Charizard")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Mewtwo")),
                  DataCell(
                      Text("${obtidoMew("Mewtwo")}/${totalMew("Mewtwo")}")),
                  DataCell(Text("${percentMew("Mewtwo")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Pikachu")),
                  DataCell(
                      Text("${obtidoMew("Pikachu")}/${totalMew("Pikachu")}")),
                  DataCell(Text("${percentMew("Pikachu")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("All")),
                  DataCell(Text("${obtidoMew("All")}/${totalMew("All")}")),
                  DataCell(Text("${percentMew("All")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Total")),
                  DataCell(Text("${obtidoMew("Total")}/${totalMew("Total")}")),
                  DataCell(Text("${percentMew("Total")}%")),
                ]),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
