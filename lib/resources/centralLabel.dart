import 'package:flutter/material.dart';

Widget centralLabel(String label,
    {String obtido = "",
    String total = "",
    Color corBordar = Colors.green,
    Color corFundo = Colors.greenAccent,
    bool complete = false}) {
  return Container(
    height: 40,
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 30.0),
    decoration: BoxDecoration(
        color: corFundo,
        border: Border.all(color: corBordar),
        borderRadius: BorderRadius.circular(5)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              obtido != "" || total != ""
                  ? Text(
                      "$obtido/$total",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  : Text(""),
              SizedBox(
                width: 5,
              ),
              complete
                  ? Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                    )
                  : Text("")
            ],
          )
        ],
      ),
    ),
  );
}
