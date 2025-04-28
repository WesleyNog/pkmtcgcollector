import 'package:flutter/material.dart';

Widget showRarityImage({required String rarity}) {
  return rarity == "🔹"
      ? Image.asset("assets/images/rarity/rD.png")
      : rarity == "🔹🔹"
          ? Row(
              children: [
                Image.asset("assets/images/rarity/rD.png"),
                Image.asset("assets/images/rarity/rD.png")
              ],
            )
          : rarity == "🔹🔹🔹"
              ? Row(
                  children: [
                    Image.asset("assets/images/rarity/rD.png"),
                    Image.asset("assets/images/rarity/rD.png"),
                    Image.asset("assets/images/rarity/rD.png")
                  ],
                )
              : rarity == "🔹🔹🔹🔹"
                  ? Row(
                      children: [
                        Image.asset("assets/images/rarity/rD.png"),
                        Image.asset("assets/images/rarity/rD.png"),
                        Image.asset("assets/images/rarity/rD.png"),
                        Image.asset("assets/images/rarity/rD.png")
                      ],
                    )
                  : rarity == "⭐️"
                      ? Image.asset("assets/images/rarity/rS.png")
                      : rarity == "⭐️⭐️"
                          ? Row(
                              children: [
                                Image.asset("assets/images/rarity/rS.png"),
                                Image.asset("assets/images/rarity/rS.png")
                              ],
                            )
                          : rarity == "⭐️⭐️⭐️"
                              ? Row(
                                  children: [
                                    Image.asset("assets/images/rarity/rS.png"),
                                    Image.asset("assets/images/rarity/rS.png"),
                                    Image.asset("assets/images/rarity/rS.png")
                                  ],
                                )
                              : rarity == "S1"
                                  ? Image.asset("assets/images/rarity/rSh.png")
                                  : rarity == "S2"
                                      ? Row(
                                          children: [
                                            Image.asset(
                                                "assets/images/rarity/rSh.png"),
                                            Image.asset(
                                                "assets/images/rarity/rSh.png")
                                          ],
                                        )
                                      : rarity == "👑"
                                          ? Image.asset(
                                              "assets/images/rarity/rC.png")
                                          : Image.asset(
                                              "assets/images/rarity/promoA_rarity.png");
}
