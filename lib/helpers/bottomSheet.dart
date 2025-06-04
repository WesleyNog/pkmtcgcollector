import 'package:flutter/material.dart';
import 'package:pocket_collect/l10n/app_localizations.dart';
import 'package:pocket_collect/helpers/showRarity.dart';

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
              initialChildSize: 0.7, // Começa ocupando 50% da tela
              minChildSize: 0.3, // Pode encolher até 30% da tela
              maxChildSize: 0.9, // Pode expandir até 90% da tela
              expand: false,
              builder: (context, ScrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent[50],
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
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                showRaritySheet(rarity: "🔹"),
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
                                showRaritySheet(rarity: "🔹🔹"),
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
                                showRaritySheet(rarity: "🔹🔹🔹"),
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
                                showRaritySheet(rarity: "🔹🔹🔹🔹")
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                            showRaritySheet(rarity: "⭐️"),
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
                            showRaritySheet(rarity: "⭐️⭐️"),
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
                            showRaritySheet(rarity: "⭐️⭐️⭐️"),
                            Checkbox(
                                value: raridades[9],
                                onChanged: (bool? newValue) {
                                  setModalState(() {
                                    raridades[9] = newValue ?? false;
                                  });
                                  updateParentState(() {
                                    filterList("");
                                  });
                                }),
                            showRaritySheet(rarity: "👑"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                            showRaritySheet(rarity: "S1"),
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
                            showRaritySheet(rarity: "S2"),
                          ],
                        ),
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
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                          Checkbox(
                              value: packs[6],
                              onChanged: (bool? newValue) {
                                setModalState(() {
                                  packs[6] = newValue ?? false;
                                });
                                updateParentState(() {
                                  filterList("");
                                });
                              }),
                          Image.asset("assets/images/arceus.png"),
                          Checkbox(
                              value: packs[7],
                              onChanged: (bool? newValue) {
                                setModalState(() {
                                  packs[7] = newValue ?? false;
                                });
                                updateParentState(() {
                                  filterList("");
                                });
                              }),
                          Image.asset("assets/images/giratina.png"),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: packs[8],
                              onChanged: (bool? newValue) {
                                setModalState(() {
                                  packs[8] = newValue ?? false;
                                });
                                updateParentState(() {
                                  filterList("");
                                });
                              }),
                          Image.asset("assets/images/solgaleo.png"),
                          Checkbox(
                              value: packs[9],
                              onChanged: (bool? newValue) {
                                setModalState(() {
                                  packs[9] = newValue ?? false;
                                });
                                updateParentState(() {
                                  filterList("");
                                });
                              }),
                          Image.asset("assets/images/lunala.png"),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: raridades[10],
                              onChanged: (bool? newValue) {
                                setModalState(() {
                                  raridades[10] = newValue ?? false;
                                });
                                updateParentState(() {
                                  filterList("");
                                });
                              }),
                          Image.asset("assets/images/promoA.png"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.indigoAccent,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setModalState(() {
                            for (int i = 0; i < raridades.length; i++) {
                              raridades[i] = false;
                            }
                            for (int i = 0; i < packs.length; i++) {
                              packs[i] = false;
                            }
                          });
                          updateParentState(() {
                            filterList("");
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.clear,
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            overlayColor: Colors.lightBlueAccent.shade100),
                      )
                    ],
                  ),
                );
              });
        });
      });
}
