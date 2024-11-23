import 'package:flutter/material.dart';

Widget createDataTable({
  // double columnSpace = 20.0,
  required List<String> labels,
  required List<List<String>> packs,
}) {
  return DataTable(
    // columnSpacing: columnSpace > 0 ? columnSpace : null,
    headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
    columns: labels
        .map(
          (label) => DataColumn(label: Text(label)),
        )
        .toList(),
    rows: packs
        .map((pack) => DataRow(
              cells: pack.map((item) => DataCell(Text(item))).toList(),
            ))
        .toList(),
  );
}
