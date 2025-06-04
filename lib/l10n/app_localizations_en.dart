// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'english';

  @override
  String get colectionLabel => 'Collection';

  @override
  String get pkmList => 'List of Pokémon';

  @override
  String get placeholders => 'Search Pokémon';

  @override
  String get hintPlaceholder => 'Pokémon Name';

  @override
  String get codeLabel => 'Code';

  @override
  String get nameLabel => 'Name';

  @override
  String get rarityLabel => 'Rarity';

  @override
  String get rate => 'Rate';

  @override
  String get amountPokemon => 'Cards';

  @override
  String get busterPack => 'Pack';

  @override
  String get clear => 'Clear';

  @override
  String get noMetrics => 'No clean cards!';

  @override
  String get totalsLabel => 'Totals';

  @override
  String get allLabel => 'All';

  @override
  String get bestPackLabel => 'Best \nPack';

  @override
  String get newCards => 'Chance (%) - New Cards';

  @override
  String get mew => 'Mew Tracker';

  @override
  String get help => 'Help / Guide';

  @override
  String get introHelp => 'Guide and Information';

  @override
  String get subIntroHelp => 'Everyone needs to know how the app works';

  @override
  String get update => 'Updates';

  @override
  String get updateNote_0 =>
      'Version 1.0.0 in 2025-01-01:\n\nInitial implementation of all features such as marking the cards you have and metrics on how close you are to completing the collection and/or challenges';

  @override
  String get info => 'Information';

  @override
  String get infoNote_0 =>
      'Welcome to our Pokémon card collection management application! Here you can organize and track your letters in a practical and efficient way. Below, we explain how to use each available feature:';

  @override
  String get infoNote_1 =>
      '1. Marking your Cards\nWhen accessing the card list, you will be able to view all the cards available in the official game. To mark a card as obtained, simply tap the check box next to the corresponding Pokémon. You can deselect at any time if you need to adjust your collection.';

  @override
  String get infoNote_2 =>
      '2. Using Filters\nThe list of cards can be filtered to facilitate your search. You can apply filters by:\n- Rarity: Select common, rare or legendary cards.\n- Collection Packs: Choose a specific set of cards.\n- Promo Cards: View only special promotional letters.\nThese filters allow for more organized and faster navigation within the application.';

  @override
  String get infoNote_3 =>
      '3. Tracking Collection Progress\nThe application provides a metrics screen where you can view your collection progress through interactive graphs. On this screen you will find:\n- Percentage of Busters Obtained: A graph displaying the percentage of cards you have already collected in relation to the total available.\n- Challenges: Some personalized missions to encourage your collection, such as obtaining the MEW card in the first collection, among others.';

  @override
  String get infoNote_4 =>
      'Extra Tips\n- Keep your collection up to date to accurately track your progress.\n- Use the filters to quickly find the cards you need.\n- Check back frequently for challenges to motivate your search for new cards.';

  @override
  String get guid => 'Usage Guide';

  @override
  String get guidInfo_0 =>
      'The background colors of each card in the list represent each pack, these being so far:\n- Charizard: Represented by the color Orange\n- Pikachu: Represented by the color Yellow\n- Mewtwo: Represented by the color Purple\n- Celebi: Represented by the color Green\n- Palkia: Represented by the color Pink\n- Dialga: Represented by the color Blue\nBelow we have an example that illustrates this well';

  @override
  String get guidInfo_1 =>
      'In the line where the rates are displayed, the percentage for each place where it can appear is displayed:\n- 1-3: Appearance rate on the first three cards\n- 4: Appearance rate on the fourth card\n- 5: Appearance rate on the fifth card';

  @override
  String get guidInfo_2 =>
      'Regarding the graph, it will be filled as the cards are marked for each collection, and the total obtained for each buster will be displayed, however, when exceeding 50% of cards obtained from the collection, a gray layer will also be displayed that represents how much remains for the entire collection to be completed.\n\nBy sliding the screen to the side, the other collections available to date will be displayed with their appropriate information.';
}
