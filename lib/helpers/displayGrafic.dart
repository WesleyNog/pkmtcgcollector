import 'package:flutter/material.dart';

class BusterHorizontalChart extends StatelessWidget {
  final Map<String, int> packCounts;
  final Map<String, Color> packColors;
  final int totalPokemonCount;

  const BusterHorizontalChart({
    Key? key,
    required this.packCounts,
    required this.packColors,
    required this.totalPokemonCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Soma a quantidade já obtida dos boosters
    final int obtainedTotal = packCounts.entries
        .where((entry) => entry.key != 'Total')
        .fold(0, (sum, entry) => sum + entry.value);

    // Calcula o que falta
    final int missingCount = totalPokemonCount - obtainedTotal;

    return Column(
      children: [
        Row(
          children: [
            // Gerar as partes da barra dinamicamente
            ...packCounts.entries.map((entry) {
              final color = packColors[entry.key] ?? Colors.grey;
              final flexValue = entry.value;

              return Expanded(
                flex: flexValue,
                child: Container(
                  height: 30,
                  color: color,
                ),
              );
            }).toList(),
            if (missingCount > 0)
              Expanded(
                flex: missingCount,
                child: Container(
                  height: 30,
                  color: Colors.grey.shade300,
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
        // Legenda automática
        Wrap(
          spacing: 20,
          children: packCounts.entries.map((entry) {
            final color = packColors[entry.key] ?? Colors.grey;
            return LegendItem(
              color: color,
              text: entry.key,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 16, height: 16, color: color),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
