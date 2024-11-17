import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pkmtcgcollector/resources/pokemonInfos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: HomePageContent());
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  List<Map<String, dynamic>> _pokemonList = [];
  List<Map<String, dynamic>> _pokemonListFiltered = [];
  final TextEditingController _filterController = TextEditingController();
  bool? raridade01 = false;
  bool? raridade02 = false;
  bool? raridade03 = false;
  bool? raridade04 = false;
  bool? raridade05 = false;
  bool? raridade06 = false;
  bool? raridade07 = false;
  bool? raridade08 = false;
  bool? packPikachu = false;
  bool? packCharizard = false;
  bool? packMewtwo = false;

  Future<void> _savedPokemonList() async {
    // Salve os dados atualizados no SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final updatedList = _pokemonList.map((pokemon) => pokemon).toList();
    await prefs.setString('pokemonList', jsonEncode(updatedList));
  }

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

  Future<void> _clearPokemonList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void _filterList(String query) {
    final lowerCaseQuery = query.toLowerCase();

    final filteredList = _pokemonList.where((pokemon) {
      final name = pokemon['nome']?.toLowerCase() ?? '';
      // final pack = pokemon['buster']?.toLowerCase() ?? '';

      return name.contains(lowerCaseQuery); //|| pack.contains(lowerCaseQuery);
    }).toList();

    setState(() {
      _pokemonListFiltered = filteredList;
    });
  }

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.amber[50],
      barrierColor: Colors.black87.withOpacity(0.5),
      isDismissible: false,
      context: context,
      builder: (context) => Container(
        height: 500,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8.0, bottom: 12.0),
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Filtros",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Raridade"),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                      title: Text("🔹"),
                      value: raridade01,
                      onChanged: (bool? newValue) async {
                        setState(() {
                          raridade01 = newValue ?? false;
                        });
                      }),
                ),
                Expanded(
                  child: CheckboxListTile(
                      title: Text("🔹🔹"),
                      value: raridade02,
                      onChanged: (bool? newValue) async {
                        setState(() {
                          raridade02 = newValue ?? false;
                        });
                      }),
                ),
                Expanded(
                  child: CheckboxListTile(
                      title: Text("🔹🔹🔹"),
                      value: raridade03,
                      onChanged: (bool? newValue) async {
                        setState(() {
                          raridade03 = newValue ?? false;
                        });
                      }),
                ),
                Expanded(
                  child: CheckboxListTile(
                      title: Text("🔹🔹🔹🔹"),
                      value: raridade04,
                      onChanged: (bool? newValue) async {
                        setState(() {
                          raridade04 = newValue ?? false;
                        });
                      }),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                      title: Text("⭐️"),
                      value: raridade05,
                      onChanged: (bool? newValue) async {
                        setState(() {
                          raridade05 = newValue ?? false;
                        });
                      }),
                ),
                Expanded(
                  child: CheckboxListTile(
                      title: Text("⭐️⭐️"),
                      value: raridade06,
                      onChanged: (bool? newValue) async {
                        setState(() {
                          raridade06 = newValue ?? false;
                        });
                      }),
                ),
                Expanded(
                  child: CheckboxListTile(
                      title: Text("⭐️⭐️⭐️"),
                      value: raridade07,
                      onChanged: (bool? newValue) async {
                        setState(() {
                          raridade07 = newValue ?? false;
                        });
                      }),
                ),
                Expanded(
                  child: CheckboxListTile(
                      title: Text("👑"),
                      value: raridade08,
                      onChanged: (bool? newValue) async {
                        setState(() {
                          raridade08 = newValue ?? false;
                        });
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Aplicar",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  shadowColor: Colors.cyan[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadPokemonList();
    _pokemonListFiltered = List.from(_pokemonList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coleção",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Lista de Pokemons",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Buscar Pokemon",
                          hintText: "Digite o nome do pokemon",
                        ),
                        onChanged: (value) => _filterList(value),
                        onSubmitted: (value) =>
                            _filterList(_filterController.text),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {
                            _filterList(_filterController.text);
                          },
                          icon: Icon(Icons.search_rounded),
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    _displayBottomSheet(context);
                  },
                  child: Center(
                    child: Icon(
                      Icons.filter_list_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      // minimumSize: Size(0, 60),
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "#",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Text(
                    "code",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "nome",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "buster",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "raridade",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: Container(
                width: double.infinity,
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: _pokemonListFiltered.map((item) {
                        return Row(
                          children: [
                            Checkbox(
                                value: item["obtido"],
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    item["obtido"] = newValue ?? false;
                                  });
                                  _savedPokemonList();
                                }),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: item["buster"] == "Charizard"
                                        ? Colors.deepOrange[100]
                                        : item["buster"] == "Mewtwo"
                                            ? Colors.deepPurple[100]
                                            : item["buster"] == "All"
                                                ? Colors.green[100]
                                                : Colors.amberAccent[100],
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0, top: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(item["code"]),
                                          Divider(),
                                          Text(item["nome"]),
                                          Divider(),
                                          Text(item["buster"]),
                                          Divider(),
                                          Text(item["raridade"]),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Taxas:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11),
                                          ),
                                          Text(
                                            "1-3º : ${item["chance_1_3"].toString()}%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11),
                                          ),
                                          Text(
                                            "4º : ${item["chance_4"].toString()}%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11),
                                          ),
                                          Text(
                                            "5º : ${item["chance_5"].toString()}%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
