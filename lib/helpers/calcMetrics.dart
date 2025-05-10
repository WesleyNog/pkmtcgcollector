// Função para calcular a chance que a carta ainda pode vir no buster
String chanceCard(
    String chance, String pack, String seasson, List pokemonList) {
  List<String> _raridades = [
    "🔹",
    "🔹🔹",
    "🔹🔹🔹",
    "🔹🔹🔹🔹",
    "⭐️",
    "⭐️⭐️",
    "⭐️⭐️⭐️",
    "S1",
    "S2",
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
            pokemon["seasson"] == seasson)
        .fold(0.0, (soma, pokemon) {
      return soma + (pokemon[chance] ?? 0.0);
    });
    var sumAll = pokemonList
        .where((pokemon) =>
            pokemon["obtido"] == false &&
            pokemon["raridade"] == raridade &&
            pokemon["buster"] == "All" &&
            pokemon["promoA"] == false &&
            pokemon["seasson"] == seasson)
        .fold(0.0, (soma, pokemon) {
      return soma + (pokemon[chance] ?? 0.0);
    });

    _sum = _sum + sumPack + sumAll;
  }
  return _sum.toStringAsFixed(3);
}
