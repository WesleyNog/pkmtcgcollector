import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pocket_collect/helpers/infosAndUpdates.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: ManuPageContent());
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
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       const UserAccountsDrawerHeader(
      //         accountName: Text("Collector TCG Pocket"),
      //         accountEmail: Text("example_mail@example.com"),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.live_help_rounded),
      //         title: const Text("Help"),
      //         onTap: () {
      //           print("Clicou no Help");
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.feedback_rounded),
      //         title: const Text("Feedback"),
      //         onTap: () {
      //           print("Clicou no feedback");
      //         },
      //       )
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          locale.help,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.deepOrange, Colors.amberAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${locale.colectionLabel} TCG Pocket\n FAQ, ${locale.introHelp}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    locale.subIntroHelp,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                locale.update,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.deepOrange),
              ),
            ),
            buildUpdateList(context),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                locale.info,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.deepOrange),
              ),
            ),
            buildNoteList(context),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                textAlign: TextAlign.justify,
                locale.guid,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.deepOrange),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                textAlign: TextAlign.justify,
                locale.guidInfo_0,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset("assets/images/ExempleColors.png"),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                textAlign: TextAlign.justify,
                locale.guidInfo_1,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset("assets/images/ExempleGrafic.png"),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                textAlign: TextAlign.justify,
                locale.guidInfo_2,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
