import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocket_collect/helpers/centralLabel.dart';
import 'package:pocket_collect/helpers/dataTable.dart';
import 'package:pocket_collect/helpers/displayGrafic.dart';
import 'package:pocket_collect/helpers/pokemonInfos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MysticalMetrics extends StatefulWidget {
  MysticalMetrics({super.key});

  @override
  State<MysticalMetrics> createState() => _MysticalMetricsState();
}

class _MysticalMetricsState extends State<MysticalMetrics> {
  int touchedIndex = -1;
  List<Map<String, dynamic>> pokemonList = [];

  int obtido(String pack, {String tipo = "Normal"}) {
    if (pack == "Total") {
      return pokemonList
          .where((pokemon) =>
              pokemon["obtido"] == true && pokemon["seasson"] == "Mystical")
          .length;
    }

    return pokemonList
        .where(
            (pokemon) => pokemon["buster"] == pack && pokemon["obtido"] == true)
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
          .where((seasson) => seasson["seasson"] == "Mystical")
          .length;
    }

    return pokemonList.where((pokemon) => pokemon["buster"] == pack).length;
  }

  String percentBuster(String pack, {String tipo = "Normal"}) {
    return ((obtido(pack) / totalPokemon(pack)) * 100).toStringAsFixed(3);
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
              pokemon["promoA"] == false)
          .fold(0.0, (soma, pokemon) {
        return soma + (pokemon[chance] ?? 0.0);
      });
      var sumAll = pokemonList
          .where((pokemon) =>
              pokemon["obtido"] == false &&
              pokemon["raridade"] == raridade &&
              pokemon["buster"] == "All" &&
              pokemon["promoA"] == false)
          .fold(0.0, (soma, pokemon) {
        return soma + (pokemon[chance] ?? 0.0);
      });

      _sum = _sum + sumPack + sumAll;
    }
    return _sum.toStringAsFixed(3);
  }

  currentTask(String tipoTask,
      {List<String>? remove, List<String>? add, String tipoPack = "Normal"}) {
    List<String> onlyCount = ["MEW"];
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
            trainer["obtido"] == true)
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
    Map<String, int> packCounts = {
      "MEW": obtido("MEW"),
      // "Total": totalPokemon("Total") - obtido("MEW")
    };

    Map<String, Color> packColors = {
      "MEW": Colors.greenAccent,
      "Total": Colors.grey.shade200
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
              "MEW",
              "${obtido("MEW")}/${totalPokemon("MEW")}",
              "${percentBuster("MEW")}%"
            ],
            [
              "Total",
              "${obtido("Total")}/${totalPokemon("Total")}",
              "${percentBuster("Total")}%"
            ],
          ]),
        ],
      ),
    );
  }
}
