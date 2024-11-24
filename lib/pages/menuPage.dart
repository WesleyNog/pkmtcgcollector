import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: ManuPageContent());
  }
}

class ManuPageContent extends StatefulWidget {
  const ManuPageContent({super.key});

  @override
  State<ManuPageContent> createState() => _ManuPageContentState();
}

class _ManuPageContentState extends State<ManuPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ajuda / Guia",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.deepOrange, Colors.amberAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Collect TCG Pocket\n FAQ, Guia e Informação",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Todos precisão saber como funciona o app",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Atualizações:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.deepOrange),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "01/01/2024:",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                textAlign: TextAlign.justify,
                """Versão 1.0.0\nImplementação inicial de todas as funcionalidades como marcação das carta que possui e métricas do quão próxima está para concluir a coleção e/ou os desafios""",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Informação:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.deepOrange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
