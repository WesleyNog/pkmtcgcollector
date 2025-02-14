import 'package:flutter/material.dart';

Future<void> displayBottomSheet({
  required BuildContext context,
  required List<bool?> raridades,
  required List<bool?> packs,
  required bool mewCards,
  required Function(String) filterList,
  required Function(void Function()) updateParentState,
}) {
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
                        value: raridades[0],
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            raridades[0] = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
                          });
                        }),
                    const Text("🔹"),
                    Checkbox(
                        value: raridades[1],
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            raridades[1] = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
                          });
                        }),
                    const Text("🔹🔹"),
                    Checkbox(
                        value: raridades[2],
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            raridades[2] = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
                          });
                        }),
                    const Text("🔹🔹🔹"),
                    Checkbox(
                        value: raridades[3],
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            raridades[3] = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
                          });
                        }),
                    const Text("🔹🔹🔹🔹")
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        value: raridades[4],
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            raridades[4] = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
                          });
                        }),
                    const Text("⭐️"),
                    Checkbox(
                        value: raridades[5],
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            raridades[5] = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
                          });
                        }),
                    const Text("⭐️⭐️"),
                    Checkbox(
                        value: raridades[6],
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            raridades[6] = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
                          });
                        }),
                    const Text("⭐️⭐️⭐️"),
                    Checkbox(
                        value: raridades[7],
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            raridades[7] = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
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
                        value: packs[0],
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            packs[0] = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
                          });
                        }),
                    Image.asset("assets/images/charizard.jpg"),
                    Checkbox(
                        value: packs[1],
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            packs[1] = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
                          });
                        }),
                    Image.asset("assets/images/mewtwo.jpg"),
                    Checkbox(
                        value: packs[2],
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            packs[2] = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
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
                        value: raridades[8],
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            raridades[8] = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
                          });
                        }),
                    Image.asset("assets/images/promoA.png"),
                    Checkbox(
                        value: packs[3],
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            packs[3] = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
                          });
                        }),
                    Image.asset("assets/images/buster_promoA.png"),
                    Checkbox(
                        value: mewCards,
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            mewCards = newValue ?? false;
                          });
                          updateParentState(() {
                            filterList("");
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
