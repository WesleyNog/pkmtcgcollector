import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BusterBarChart extends StatelessWidget {
  final Map<String, int> packCounts;
  final Map<String, Color> packColors;
  final int totalPokemonCount;

  const BusterBarChart({
    Key? key,
    required this.packCounts,
    required this.packColors,
    required this.totalPokemonCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entries = packCounts.entries.toList();

    return AspectRatio(
      aspectRatio: 5,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final entry =
                    rodIndex < entries.length ? entries[rodIndex] : null;
                return entry != null
                    ? BarTooltipItem(
                        '${entry.key}\n${entry.value}',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )
                    : null;
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: 100,
                  rodStackItems: [
                    ...entries.asMap().entries.map((entry) {
                      final index = entry.key;
                      final key = entry.value.key;
                      final value = entry.value.value;
                      double start =
                          _calcStart(entries, index, totalPokemonCount);
                      double percentage = (value / totalPokemonCount) * 100;
                      return BarChartRodStackItem(
                        start,
                        start + percentage,
                        packColors[key] ?? Colors.grey,
                      );
                    }),
                    // Preenchendo espaço vazio (cinza)
                    BarChartRodStackItem(
                      _calcStart(entries, entries.length, totalPokemonCount),
                      100,
                      Colors.grey.shade300,
                    ),
                  ],
                  width: 30,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _calcStart(List<MapEntry<String, int>> entries, int index, int total) {
    double start = 0;
    for (int i = 0; i < index; i++) {
      start += (entries[i].value / total) * 100;
    }
    return start;
  }
}
