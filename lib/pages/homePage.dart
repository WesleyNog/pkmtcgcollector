import 'package:flutter/material.dart';

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
  final List<Map<String, dynamic>> _pokemonList = [
    {
      "Possui": true,
      "ID": "A001",
      "Nome": "Pikachu EX",
      "Buster": "Pickachu",
      "Raridade": "☆☆",
      "1-3": 2.0,
      "4": 1.0,
      "5": 0.8
    },
    {
      "Possui": false,
      "ID": "A002",
      "Nome": "Charizard",
      "Buster": "Charizard",
      "Raridade": "♢♢♢",
      "1-3": 2.0,
      "4": 1.0,
      "5": 0.8
    },
    {
      "Possui": true,
      "ID": "A003",
      "Nome": "Mewtwo EX",
      "Buster": "Todos",
      "Raridade": "♛",
      "1-3": 2.0,
      "4": 1.0,
      "5": 0.8
    },
    {
      "Possui": true,
      "ID": "A004",
      "Nome": "Jinx",
      "Buster": "Mewtwo",
      "Raridade": "♢",
      "1-3": 2.0,
      "4": 1.0,
      "5": 0.8
    },
    {
      "Possui": false,
      "ID": "A005",
      "Nome": "Zapdos",
      "Buster": "Pikachu",
      "Raridade": "♢♢♢",
      "1-3": 2.0,
      "4": 1.0,
      "5": 0.8
    },
    {
      "Possui": true,
      "ID": "A006",
      "Nome": "Arcanine",
      "Buster": "Charizard",
      "Raridade": "♢♢",
      "1-3": 2.0,
      "4": 1.0,
      "5": 0.8
    },
  ];

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
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {},
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
                    print(_pokemonList[0]["Possui"]);
                  },
                  child: Center(
                    child: Icon(
                      Icons.filter_list_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(0, 60),
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
                    "ID",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Nome",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Buster",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Raridade",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Text(
                  //   "QNT",
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
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
                      children: _pokemonList.map((item) {
                        return Row(
                          children: [
                            Checkbox(
                                value: item["Possui"],
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    item["Possui"] = newValue ?? false;
                                  });
                                }),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: item["Buster"] == "Charizard"
                                        ? Colors.deepOrange[100]
                                        : item["Buster"] == "Mewtwo"
                                            ? Colors.deepPurple[100]
                                            : item["Buster"] == "Todos"
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
                                          Text(item["ID"]),
                                          Divider(),
                                          Text(item["Nome"]),
                                          Divider(),
                                          Text(item["Buster"]),
                                          Divider(),
                                          Text(
                                            item["Raridade"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: item["Raridade"]
                                                        .contains("♢")
                                                    ? Colors.grey
                                                    : Colors.amber[700]),
                                          ),
                                          // Text(item["QNT"])
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
                                                fontSize: 11,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "1-3º: ${item["1-3"].toString()}%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "4º: ${item["4"].toString()}%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "5º: ${item["5"].toString()}%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                                color: Colors.grey),
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
