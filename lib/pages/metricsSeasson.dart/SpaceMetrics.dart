import 'dart:convert';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pkmtcgcollector/helpers/centralLabel.dart';
import 'package:pkmtcgcollector/helpers/dataTable.dart';
import 'package:pkmtcgcollector/helpers/pokemonInfos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SpaceMetrics extends StatefulWidget {
  SpaceMetrics({super.key});

  @override
  State<SpaceMetrics> createState() => _SpaceMetricsState();
}

class _SpaceMetricsState extends State<SpaceMetrics> {
  int touchedIndex = -1;
  List<Map<String, dynamic>> pokemonList = [];

  int obtido(String pack, {String tipo = "Normal"}) {
    if (pack == "Total") {
      return pokemonList
          .where((pokemon) =>
              pokemon["obtido"] == true && pokemon["seasson"] == "Space")
          .length;
    }

    return pokemonList
        .where((pokemon) =>
            pokemon["buster"] == pack &&
            pokemon["obtido"] == true &&
            pokemon["seasson"] == "Space")
        .length;
  }

  Future<void> _loadPokemonList() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getString('pokemonList');

    if (savedList != null) {
      setState(() {
        pokemonList = List<Map<String, dynamic>>.from(jsonDecode(savedList));
      });
    } else {
      // Carregar a lista padrão
      setState(() {
        pokemonList = infoPokemons;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPokemonList();
  }

  int totalPokemon(String pack, {String tipo = "Normal"}) {
    if (pack == "Total") {
      return pokemonList
          .where((seasson) => seasson["seasson"] == "Space")
          .length;
    }

    return pokemonList
        .where((pokemon) =>
            pokemon["buster"] == pack && pokemon["seasson"] == "Space")
        .length;
  }

  String percentBuster(String pack, {String tipo = "Normal"}) {
    return ((obtido(pack) / totalPokemon(pack)) * 100).toStringAsFixed(3);
  }

  // Verificar qual pack tem menos cartas obtidas
  String bestPack({String tipo = "Normal"}) {
    Map<double, dynamic> percentBusters = {
      double.parse(percentBuster("Dialga")): "Dialga",
      double.parse(percentBuster("Palkia")): "Palkia",
    };
    double minPercent = percentBusters.keys.reduce(min);

    return percentBusters[minPercent];
  }

  // Função para calcular a chance que a carta ainda pode vir no buster
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
      var sumPack = pokemonList
          .where((pokemon) =>
              pokemon["obtido"] == false &&
              pokemon["raridade"] == raridade &&
              pokemon["buster"] == pack &&
              pokemon["promoA"] == false &&
              pokemon["seasson"] == "Space")
          .fold(0.0, (soma, pokemon) {
        return soma + (pokemon[chance] ?? 0.0);
      });
      var sumAll = pokemonList
          .where((pokemon) =>
              pokemon["obtido"] == false &&
              pokemon["raridade"] == raridade &&
              pokemon["buster"] == "All" &&
              pokemon["promoA"] == false &&
              pokemon["seasson"] == "Space")
          .fold(0.0, (soma, pokemon) {
        return soma + (pokemon[chance] ?? 0.0);
      });

      _sum = _sum + sumPack + sumAll;
    }
    return _sum.toStringAsFixed(3);
  }

  currentTask(String tipoTask,
      {List<String>? remove, List<String>? add, String tipoPack = "Normal"}) {
    List<String> onlyCount = ["Dialga", "Palkia", "All"];
    if (remove != null && remove.isNotEmpty) {
      remove.forEach((item) {
        onlyCount.remove(item);
      });
    }
    if (add != null && add.isNotEmpty) {
      add.forEach((item) {
        onlyCount.add(item);
      });
    }

    Set qntPacks = {};
    int qntComplete = 0;
    if (tipoTask == "Total") {
      for (var item in pokemonList) {
        if (onlyCount.contains(item["buster"])) {
          qntPacks.add(item["buster"]);
        }
      }
      return qntPacks.length.toString().padLeft(2, "0");
    } else if (tipoTask == "Unit") {
      for (var pack in onlyCount) {
        if (obtido(pack, tipo: tipoPack) ==
            totalPokemon(pack, tipo: tipoPack)) {
          qntComplete += 1;
        }
      }
      return qntComplete.toString().padLeft(2, "0");
    }
  }

  bool completeTask({String tipo = "Normal"}) {
    if (currentTask("Unit", tipoPack: tipo) ==
        currentTask("Total", tipoPack: tipo)) {
      return true;
    }
    return false;
  }

  String treinador(String nome) {
    return pokemonList
        .where((trainer) =>
            trainer["nome"] == nome &&
            trainer["raridade"] == "⭐️⭐️" &&
            trainer["obtido"] == true &&
            trainer["seasson"] == "Space")
        .length
        .toString()
        .padLeft(2, "0");
  }

  String busterTrainer(String nome) {
    final buster = pokemonList.firstWhere((pack) => pack["nome"] == nome);
    return buster["buster"];
  }

  @override
  Widget build(BuildContext context) {
    int totalObtido = obtido("Total");
    int totalPokemonCount = totalPokemon("Total");

    Map<String, int> packCounts = {
      "Dialga": obtido("Dialga"),
      "Palkia": obtido("Palkia"),
      "All": obtido("All"),
    };

    if (totalObtido > (totalPokemonCount * 0.5)) {
      packCounts["Total"] = totalPokemonCount - totalObtido;
    }

    Map<String, Color> packColors = {
      "Dialga": Colors.blue,
      "Palkia": Colors.pink.shade100,
      "All": Colors.green,
      "Total": Colors.grey.shade200,
      if (packCounts.containsKey("Total")) "Total": Colors.grey.shade200,
    };

    List<PieChartSectionData> sections = [];
    final entries = packCounts.entries.toList();
    for (int i = 0; i < entries.length; i++) {
      final key = entries[i].key;
      final value = entries[i].value;
      double percentage = (value / totalPokemon("Total")) * 100;
      final isTouched = i == touchedIndex;
      final radios = isTouched ? 130.0 : 100.0;
      sections.add(
        PieChartSectionData(
          value: percentage,
          title: '${percentage.toStringAsFixed(2)}%',
          color: packColors[key] ?? Colors.grey,
          radius: radios,
          titleStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
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
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      sectionsSpace: 5,
                      centerSpaceRadius: 0,
                      sections: sections,
                    ),
                  ),
                ),
          SizedBox(
            height: 30,
          ),
          centralLabel(AppLocalizations.of(context)!.colectionLabel,
              obtido: currentTask("Unit"),
              total: currentTask("Total"),
              corFundo: Colors.green.shade100,
              complete: completeTask()),
          createDataTable(labels: [
            AppLocalizations.of(context)!.busterPack,
            AppLocalizations.of(context)!.totalsLabel,
            "%"
          ], packs: [
            [
              "Dialga",
              "${obtido("Dialga")}/${totalPokemon("Dialga")}",
              "${percentBuster("Dialga")}%"
            ],
            [
              "Palkia",
              "${obtido("Palkia")}/${totalPokemon("Palkia")}",
              "${percentBuster("Palkia")}%"
            ],
            [
              AppLocalizations.of(context)!.allLabel,
              "${obtido("All")}/${totalPokemon("All")}",
              "${percentBuster("All")}%"
            ],
            [
              "Total",
              "${obtido("Total")}/${totalPokemon("Total")}",
              "${percentBuster("Total")}%"
            ],
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  AppLocalizations.of(context)!.bestPackLabel,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: pokemonList.isEmpty
                        ? Colors.grey
                        : bestPack() == "Dialga"
                            ? Colors.blue
                            : bestPack() == "Palkia"
                                ? Colors.pink.shade100
                                : Colors.grey,
                  ),
                  child: Center(
                    child: pokemonList.isEmpty
                        ? CircularProgressIndicator()
                        : Text(
                            bestPack(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          centralLabel(AppLocalizations.of(context)!.newCards,
              corFundo: Colors.green.shade100, complete: completeTask()),
          DataTable(
              columnSpacing: 25,
              headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
              columns: [
                DataColumn(
                    label: Text(AppLocalizations.of(context)!.busterPack)),
                DataColumn(label: Text("1-3")),
                DataColumn(label: Text("4")),
                DataColumn(label: Text("5")),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("Dialga")),
                  DataCell(Text("${chanceCard("chance_1_3", "Dialga")}%")),
                  DataCell(Text("${chanceCard("chance_4", "Dialga")}%")),
                  DataCell(Text("${chanceCard("chance_5", "Dialga")}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Palkia")),
                  DataCell(Text("${chanceCard("chance_1_3", "Palkia")}%")),
                  DataCell(Text("${chanceCard("chance_4", "Palkia")}%")),
                  DataCell(Text("${chanceCard("chance_5", "Palkia")}%")),
                ]),
              ]),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
