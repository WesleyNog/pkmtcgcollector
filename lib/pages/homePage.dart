import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pkmtcgcollector/adState.dart';
import 'package:pkmtcgcollector/resources/pokemonInfos.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: HomePageContent());
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: AdRequest(),
          listener: BannerAdListener(
            onAdLoaded: (ad) => print('Ad loaded: ${ad.adUnitId}'),
            onAdFailedToLoad: (ad, error) {
              print('Ad failed to load: ${ad.adUnitId}, $error');
              ad.dispose();
            },
            onAdOpened: (ad) => print('Ad opened: ${ad.adUnitId}'),
            onAdClosed: (ad) => print('Ad closed: ${ad.adUnitId}'),
          ),
        )..load();
      });
    });
  }

  List<Map<String, dynamic>> _pokemonList = [];
  List<Map<String, dynamic>> _pokemonListFiltered = [];
  final TextEditingController _filterController = TextEditingController();
  final List<bool?> _raridades = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  final List<String> nivelRaridades = [
    "🔹",
    "🔹🔹",
    "🔹🔹🔹",
    "🔹🔹🔹🔹",
    "⭐️",
    "⭐️⭐️",
    "⭐️⭐️⭐️",
    "👑",
    "promoA"
  ];
  final List<bool?> _packs = [false, false, false, false];
  final List<String> nivelPakcs = [
    "Charizard",
    "Mewtwo",
    "Pikachu",
    "Promo pack"
  ];
  bool mewCards = false;

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
    // Verifica se nenhuma raridade/Pack estão selecionados
    final isAnyRaridadeSelected = _raridades.contains(true);
    final isAnyPackSelected = _packs.contains(true);

    final filteredList = _pokemonList.where((pokemon) {
      // Filtrar por nome do Pokemon
      final name = pokemon['nome']?.toLowerCase() ?? '';

      // Filtrar por Raridade
      final raridadePokemon = pokemon["raridade"];
      bool raridadeValida = !isAnyRaridadeSelected ||
          _raridades.asMap().entries.any((entry) {
            final index = entry.key;
            final isSelected = entry.value;
            return isSelected! && raridadePokemon == nivelRaridades[index];
          });

      // Filtrar por Packs
      final packPokemon = pokemon["buster"];
      bool packValida = !isAnyPackSelected ||
          _packs.asMap().entries.any((entry) {
            final index = entry.key;
            final isSelected = entry.value;
            return isSelected! && packPokemon == nivelPakcs[index];
          });

      // Filtrar as cartas que obtem o MEW
      if (mewCards) {
        final mewPokemon = pokemon["MEW"] ?? false;

        return name.contains(lowerCaseQuery) &&
            raridadeValida &&
            packValida &&
            mewPokemon;
      }

      return name.contains(lowerCaseQuery) && raridadeValida && packValida;
    }).toList();

    setState(() {
      _pokemonListFiltered = filteredList;
    });
  }

  bool verifyFilter() {
    final isRarity = _raridades.contains(true);
    final isPack = _packs.contains(true);
    final isMew = mewCards;

    if (isRarity || isPack || isMew) {
      return true;
    }
    return false;
  }

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.blueAccent[50],
        barrierColor: Colors.black87.withOpacity(0.5),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setModalState) {
            return SizedBox(
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
                  const Text("Raridade"),
                  const Divider(),
                  Row(
                    children: [
                      Checkbox(
                          value: _raridades[0],
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              _raridades[0] = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      const Text("🔹"),
                      Checkbox(
                          value: _raridades[1],
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              _raridades[1] = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      const Text("🔹🔹"),
                      Checkbox(
                          value: _raridades[2],
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              _raridades[2] = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      const Text("🔹🔹🔹"),
                      Checkbox(
                          value: _raridades[3],
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              _raridades[3] = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      const Text("🔹🔹🔹🔹")
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: _raridades[4],
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              _raridades[4] = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      const Text("⭐️"),
                      Checkbox(
                          value: _raridades[5],
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              _raridades[5] = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      const Text("⭐️⭐️"),
                      Checkbox(
                          value: _raridades[6],
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              _raridades[6] = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      const Text("⭐️⭐️⭐️"),
                      Checkbox(
                          value: _raridades[7],
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              _raridades[7] = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      const Text("👑"),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Packs"),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: _packs[0],
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              _packs[0] = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      Image.asset("assets/images/charizard.jpg"),
                      Checkbox(
                          value: _packs[1],
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              _packs[1] = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      Image.asset("assets/images/mewtwo.jpg"),
                      Checkbox(
                          value: _packs[2],
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              _packs[2] = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      Image.asset("assets/images/pikachu.jpg"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Checkbox(
                          value: _raridades[8],
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              _raridades[8] = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      Image.asset("assets/images/promoA.png"),
                      Checkbox(
                          value: _packs[3],
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              _packs[3] = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      Image.asset("assets/images/buster_promoA.png"),
                      Checkbox(
                          value: mewCards,
                          onChanged: (bool? newValue) {
                            setModalState(() {
                              mewCards = newValue ?? false;
                            });
                            setState(() {
                              _filterList("");
                            });
                          }),
                      Image.asset("assets/images/MEW.jpeg"),
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    EasyLoading.show(status: "Carregando lista completa");
    _loadPokemonList().then((_) {
      setState(() {
        _pokemonListFiltered = List.from(_pokemonList);
      });
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
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
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                "Lista de Pokemons",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Buscar Pokemon",
                            hintText: "Nome do pokemon",
                          ),
                          onChanged: (value) => _filterList(value),
                          onSubmitted: (value) =>
                              _filterList(_filterController.text),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: -4,
                        child: IconButton(
                          onPressed: () {
                            _filterList(_filterController.text);
                          },
                          icon: const Icon(Icons.search_rounded),
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    _displayBottomSheet(context);
                  },
                  child: Center(
                    child: Icon(
                      Icons.filter_list_rounded,
                      color: Colors.blue[100],
                      size: 30,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      // minimumSize: Size(0, 60),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
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
                  // Text(
                  //   "buster",
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  Text(
                    "raridade",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: _pokemonListFiltered.length +
                    (_pokemonListFiltered.length ~/ 50),
                itemBuilder: (context, index) {
                  if ((index + 1) % 51 == 0) {
                    return banner == null
                        ? const SizedBox(
                            height: 50,
                          )
                        : Container(
                            height: 50,
                            child: AdWidget(ad: banner!),
                          );
                  }
                  final realIndex = index - (index ~/ 50);
                  final item = _pokemonListFiltered[realIndex];
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
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              color: item["buster"] == "Charizard"
                                  ? Colors.deepOrange[100]
                                  : item["buster"] == "Mewtwo"
                                      ? Colors.deepPurple[100]
                                      : item["buster"] == "MEW"
                                          ? Colors.pinkAccent[100]
                                          : item["buster"] == "Shop"
                                              ? Colors.cyan[100]
                                              : item["buster"] == "Wonder Pick"
                                                  ? Colors.orangeAccent[100]
                                                  : item["buster"] ==
                                                          "Promo pack"
                                                      ? Colors.purple[100]
                                                      : item["buster"] == "All"
                                                          ? Colors.green[100]
                                                          : Colors
                                                              .amberAccent[100],
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
                                    Text(item["nome"]),
                                    // Text(item["buster"]),
                                    item["raridade"] == "promoA"
                                        ? Image.asset(
                                            "assets/images/promoA_rarity.png")
                                        : Text(
                                            item["raridade"]?.toString() ?? "")
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
                                    const Text(
                                      "Taxas:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11),
                                    ),
                                    Text(
                                      "1-3º : ${item["chance_1_3"].toString()}%",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11),
                                    ),
                                    Text(
                                      "4º : ${item["chance_4"].toString()}%",
                                      style: const TextStyle(
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
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topRight,
              child: Text(
                "Pokemons: ${_pokemonListFiltered.where((pokemon) => pokemon["obtido"] == true).length.toString().padLeft(2, "0")}/${_pokemonListFiltered.length.toString().padLeft(2, "0")}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // banner == null
            //     ? SizedBox(
            //         height: 50,
            //       )
            //     : Container(
            //         height: 50,
            //         child: AdWidget(ad: banner!),
            //       )
          ],
        ),
      ),
    );
  }
}
