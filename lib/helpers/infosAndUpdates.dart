import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget buildNoteList(BuildContext context) {
  final localization = AppLocalizations.of(context);
  final notes = [
    localization?.infoNote_0,
    localization?.infoNote_1,
    localization?.infoNote_2,
    // Adicione mais notas aqui
  ];

  return Column(
    children: notes.map((note) {
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              textAlign: TextAlign.justify,
              note!,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          )
        ],
      );
    }).toList(),
  );
}

Widget buildUpdateList(BuildContext context) {
  final localization = AppLocalizations.of(context);
  final notes = [
    localization?.updateNote_0,
    // Adicione mais notas aqui
  ];

  return Column(
    children: notes.map((note) {
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              textAlign: TextAlign.justify,
              note!,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          )
        ],
      );
    }).toList(),
  );
}
