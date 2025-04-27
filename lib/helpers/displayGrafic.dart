import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class BusterHorizontalChart extends StatelessWidget {
  final Map<String, int> packCounts;
  final Map<String, Color> packColors;
  final int totalPokemonCount;
  final Gradient? gradient;

  const BusterHorizontalChart({
    Key? key,
    required this.packCounts,
    required this.packColors,
    required this.totalPokemonCount,
    this.gradient,
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
            ...packCounts.entries.mapIndexed((index, entry) {
              final color = packColors[entry.key] ?? Colors.grey;
              final flexValue = entry.value;

              BorderRadius borderRadius = BorderRadius.zero;
              if (index == 0) {
                borderRadius = const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                );
              } else if (index == packCounts.length - 1 && missingCount <= 0) {
                borderRadius = const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                );
              }

              return Expanded(
                flex: flexValue,
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: gradient == null ? color : null,
                      gradient: gradient,
                    ),
                  ),
                ),
              );
            }).toList(),
            if (missingCount > 0)
              Expanded(
                flex: missingCount,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: Container(
                    height: 30,
                    color: Colors.grey.shade300,
                  ),
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
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(5)),
        ),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
