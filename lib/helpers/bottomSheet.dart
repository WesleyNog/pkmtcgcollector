import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> displayBottomSheet({
  required BuildContext context,
  required List<bool?> raridades,
  required List<bool?> packs,
  required bool mewCards,
  required Function(String) filterList,
  required Function(void Function()) updateParentState,
}) {
  return showModalBottomSheet(
      backgroundColor: Colors.indigoAccent[100],
      barrierColor: Colors.black87.withOpacity(0.5),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, StateSetter setModalState) {
          return DraggableScrollableSheet(
              initialChildSize: 0.6, // Começa ocupando 50% da tela
              minChildSize: 0.3, // Pode encolher até 30% da tela
              maxChildSize: 0.9, // Pode expandir até 90% da tela
              expand: false,
              builder: (context, ScrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent[100],
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                        width: 50,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Text(AppLocalizations.of(context)!.rarityLabel),
                      Divider(
                        color: Colors.indigoAccent,
                      ),
                      Column(
                        children: [
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
                      Text(AppLocalizations.of(context)!.busterPack),
                      Divider(
                        color: Colors.indigoAccent,
                      ),
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
                          Image.asset("assets/images/charizard.png"),
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
                          Image.asset("assets/images/mewtwo.png"),
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
                          Image.asset("assets/images/pikachu.png"),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                          Image.asset("assets/images/MEW.png"),
                          Checkbox(
                              value: packs[4],
                              onChanged: (bool? newValue) {
                                setModalState(() {
                                  packs[4] = newValue ?? false;
                                });
                                updateParentState(() {
                                  filterList("");
                                });
                              }),
                          Image.asset("assets/images/dialga.png"),
                          Checkbox(
                              value: packs[5],
                              onChanged: (bool? newValue) {
                                setModalState(() {
                                  packs[5] = newValue ?? false;
                                });
                                updateParentState(() {
                                  filterList("");
                                });
                              }),
                          Image.asset("assets/images/palkia.png"),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                        ],
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Divider(
                      //   color: Colors.indigoAccent,
                      // ),
                      // TextButton(
                      //     onPressed: () {
                      //       print("Pressionou");
                      //     },
                      //     child: Text(AppLocalizations.of(context)!.clear))
                    ],
                  ),
                );
              });
        });
      });
}
