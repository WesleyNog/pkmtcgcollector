import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pocket_collect/helpers/calcMetrics.dart';
import 'package:pocket_collect/helpers/centralLabel.dart';
import 'package:pocket_collect/helpers/dataTable.dart';
import 'package:pocket_collect/helpers/displayGrafic.dart';
import 'package:pocket_collect/helpers/pokemonInfos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApexMetrics extends StatefulWidget {
  ApexMetrics({super.key});

  @override
  State<ApexMetrics> createState() => _ApexMetricsState();
}

class _ApexMetricsState extends State<ApexMetrics> {
  int touchedIndex = -1;
  List<Map<String, dynamic>> pokemonList = [];

  int obtido(String pack, {String tipo = "Normal"}) {
    if (tipo == "MEW") {
      if (pack == "Total") {
        return pokemonList
            .where((pokemon) =>
                pokemon["MEW"] == true &&
                pokemon["obtido"] == true &&
                pokemon["seasson"] == "Apex")
            .length;
      }

      return pokemonList
          .where((pokemon) =>
              pokemon["buster"] == pack &&
              pokemon["obtido"] == true &&
              pokemon["MEW"] == true &&
              pokemon["seasson"] == "Apex")
          .length;
    }

    if (pack == "Total") {
      return pokemonList
          .where((pokemon) =>
              pokemon["obtido"] == true && pokemon["seasson"] == "Apex")
          .length;
    }

    return pokemonList
        .where((pokemon) =>
            pokemon["buster"] == pack &&
            pokemon["obtido"] == true &&
            pokemon["seasson"] == "Apex")
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
    if (tipo == "MEW") {
      if (pack == "Total") {
        return pokemonList
            .where((pokemon) =>
                pokemon["MEW"] == true && pokemon["seasson"] == "Apex")
            .length;
      }

      return pokemonList
          .where((pokemon) =>
              pokemon["buster"] == pack &&
              pokemon["MEW"] == true &&
              pokemon["seasson"] == "Apex")
          .length;
    }

    if (pack == "Total") {
      return pokemonList
          .where((seasson) => seasson["seasson"] == "Apex")
          .length;
    }

    return pokemonList
        .where((pokemon) =>
            pokemon["buster"] == pack && pokemon["seasson"] == "Apex")
        .length;
  }

  String percentBuster(String pack, {String tipo = "Normal"}) {
    if (tipo == "MEW") {
      return ((obtido(pack, tipo: "MEW") / totalPokemon(pack, tipo: "MEW")) *
              100)
          .toStringAsFixed(3);
    }

    return ((obtido(pack) / totalPokemon(pack)) * 100).toStringAsFixed(3);
  }

  // Verificar qual pack tem menos cartas obtidas
  String bestPack({String tipo = "Normal"}) {
    if (tipo == "MEW") {
      Map<double, dynamic> percentBusters = {
        double.parse(percentBuster("Charizard", tipo: "MEW")): "Charizard",
        double.parse(percentBuster("Mewtwo", tipo: "MEW")): "Mewtwo",
        double.parse(percentBuster("Pikachu", tipo: "MEW")): "Pikachu"
      };
      double minPercent = percentBusters.keys.reduce(min);

      return percentBusters[minPercent];
    }

    Map<double, dynamic> percentBusters = {
      double.parse(percentBuster("Charizard")): "Charizard",
      double.parse(percentBuster("Mewtwo")): "Mewtwo",
      double.parse(percentBuster("Pikachu")): "Pikachu"
    };
    double minPercent = percentBusters.keys.reduce(min);

    return percentBusters[minPercent];
  }

  currentTask(String tipoTask,
      {List<String>? remove, List<String>? add, String tipoPack = "Normal"}) {
    List<String> onlyCount = ["Charizard", "Mewtwo", "Pikachu", "All"];
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
            trainer["seasson"] == "Apex")
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
      "Charizard": obtido("Charizard"),
      "Mewtwo": obtido("Mewtwo"),
      "Pikachu": obtido("Pikachu"),
      "All": obtido("All"),
    };

    if (totalObtido > (totalPokemonCount * 0.5)) {
      packCounts["Total"] = totalPokemonCount - totalObtido;
    }

    Map<String, Color> packColors = {
      "Charizard": Colors.deepOrange,
      "Mewtwo": Colors.deepPurple,
      "Pikachu": Colors.amberAccent,
      "All": Colors.green,
      // "Total": Colors.grey.shade200,
      if (packCounts.containsKey("Total")) "Total": Colors.grey.shade200,
    };

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          obtido("Total") <= 0
              ? Text(AppLocalizations.of(context)!.noMetrics)
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BusterHorizontalChart(
                    packColors: packColors,
                    packCounts: packCounts,
                    totalPokemonCount: totalPokemon("Total"),
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
              "Charizard",
              "${obtido("Charizard")}/${totalPokemon("Charizard")}",
              "${percentBuster("Charizard")}%"
            ],
            [
              "Mewtwo",
              "${obtido("Mewtwo")}/${totalPokemon("Mewtwo")}",
              "${percentBuster("Mewtwo")}%"
            ],
            [
              "Pikachu",
              "${obtido("Pikachu")}/${totalPokemon("Pikachu")}",
              "${percentBuster("Pikachu")}%"
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
                        : bestPack() == "Charizard"
                            ? Colors.deepOrange
                            : bestPack() == "Mewtwo"
                                ? Colors.deepPurple
                                : Colors.amberAccent,
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
                  DataCell(Text("Charizard")),
                  DataCell(Text(
                      "${chanceCard("chance_1_3", "Charizard", "Apex", pokemonList)}%")),
                  DataCell(Text(
                      "${chanceCard("chance_4", "Charizard", "Apex", pokemonList)}%")),
                  DataCell(Text(
                      "${chanceCard("chance_5", "Charizard", "Apex", pokemonList)}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Mewtwo")),
                  DataCell(Text(
                      "${chanceCard("chance_1_3", "Mewtwo", "Apex", pokemonList)}%")),
                  DataCell(Text(
                      "${chanceCard("chance_4", "Mewtwo", "Apex", pokemonList)}%")),
                  DataCell(Text(
                      "${chanceCard("chance_5", "Mewtwo", "Apex", pokemonList)}%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Pikachu")),
                  DataCell(Text(
                      "${chanceCard("chance_1_3", "Pikachu", "Apex", pokemonList)}%")),
                  DataCell(Text(
                      "${chanceCard("chance_4", "Pikachu", "Apex", pokemonList)}%")),
                  DataCell(Text(
                      "${chanceCard("chance_5", "Pikachu", "Apex", pokemonList)}%")),
                ])
              ]),
          SizedBox(
            height: 40,
          ),
          centralLabel(AppLocalizations.of(context)!.mew,
              obtido: currentTask("Unit", tipoPack: "MEW"),
              total: currentTask("Total"),
              corBordar: Colors.purple.shade100,
              corFundo: Colors.purple.shade50,
              complete: completeTask(tipo: "MEW")),
          createDataTable(labels: [
            AppLocalizations.of(context)!.busterPack,
            AppLocalizations.of(context)!.totalsLabel,
            "%"
          ], packs: [
            [
              "Charizard",
              "${obtido("Charizard", tipo: "MEW")}/${totalPokemon("Charizard", tipo: "MEW")}",
              "${percentBuster("Charizard", tipo: "MEW")}%"
            ],
            [
              "Mewtwo",
              "${obtido("Mewtwo", tipo: "MEW")}/${totalPokemon("Mewtwo", tipo: "MEW")}",
              "${percentBuster("Mewtwo", tipo: "MEW")}%"
            ],
            [
              "Pikachu",
              "${obtido("Pikachu", tipo: "MEW")}/${totalPokemon("Pikachu", tipo: "MEW")}",
              "${percentBuster("Pikachu", tipo: "MEW")}%"
            ],
            [
              AppLocalizations.of(context)!.allLabel,
              "${obtido("All", tipo: "MEW")}/${totalPokemon("All", tipo: "MEW")}",
              "${percentBuster("All", tipo: "MEW")}%"
            ],
            [
              "Total",
              "${obtido("Total", tipo: "MEW")}/${totalPokemon("Total", tipo: "MEW")}",
              "${percentBuster("Total", tipo: "MEW")}%"
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
                        : bestPack(tipo: "MEW") == "Charizard"
                            ? Colors.deepOrange
                            : bestPack(tipo: "MEW") == "Mewtwo"
                                ? Colors.deepPurple
                                : Colors.amberAccent,
                  ),
                  child: Center(
                    child: pokemonList.isEmpty
                        ? CircularProgressIndicator()
                        : Text(
                            bestPack(tipo: "MEW"),
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
          // SizedBox(
          //   height: 40,
          // ),
          // centralLabel("Treinadores", "00", "08",
          //     corFundo: Colors.green.shade100),
          // createDataTable(labels: [
          //   "Nome",
          //   "Totais",
          //   "Buster"
          // ], packs: [
          //   ["Erika", "${treinador("Erika")}/01", busterTrainer("Erika")],
          //   ["Misty", "${treinador("Misty")}/01", busterTrainer("Misty")],
          //   ["Blaine", "${treinador("Blaine")}/01", busterTrainer("Blaine")],
          //   ["Koga", "${treinador("Koga")}/01", busterTrainer("Koga")],
          //   [
          //     "Giovanni",
          //     "${treinador("Giovanni")}/01",
          //     busterTrainer("Giovanni")
          //   ],
          //   ["Brock", "${treinador("Brock")}/01", busterTrainer("Brock")],
          //   [
          //     "Sabrina",
          //     "${treinador("Sabrina")}/01",
          //     busterTrainer("Sabrina")
          //   ],
          //   [
          //     "Lt.Surge",
          //     "${treinador("Lt.Surge")}/01",
          //     busterTrainer("Lt.Surge")
          //   ],
          // ])
        ],
      ),
    );
  }
}
