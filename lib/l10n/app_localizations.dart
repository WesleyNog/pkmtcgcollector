import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'english'**
  String get language;

  /// No description provided for @colectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get colectionLabel;

  /// No description provided for @pkmList.
  ///
  /// In en, this message translates to:
  /// **'List of Pokémon'**
  String get pkmList;

  /// No description provided for @placeholders.
  ///
  /// In en, this message translates to:
  /// **'Search Pokémon'**
  String get placeholders;

  /// No description provided for @hintPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Pokémon Name'**
  String get hintPlaceholder;

  /// No description provided for @codeLabel.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get codeLabel;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @rarityLabel.
  ///
  /// In en, this message translates to:
  /// **'Rarity'**
  String get rarityLabel;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @amountPokemon.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get amountPokemon;

  /// No description provided for @busterPack.
  ///
  /// In en, this message translates to:
  /// **'Pack'**
  String get busterPack;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @noMetrics.
  ///
  /// In en, this message translates to:
  /// **'No clean cards!'**
  String get noMetrics;

  /// No description provided for @totalsLabel.
  ///
  /// In en, this message translates to:
  /// **'Totals'**
  String get totalsLabel;

  /// No description provided for @allLabel.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allLabel;

  /// No description provided for @bestPackLabel.
  ///
  /// In en, this message translates to:
  /// **'Best \nPack'**
  String get bestPackLabel;

  /// No description provided for @newCards.
  ///
  /// In en, this message translates to:
  /// **'Chance (%) - New Cards'**
  String get newCards;

  /// No description provided for @mew.
  ///
  /// In en, this message translates to:
  /// **'Mew Tracker'**
  String get mew;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help / Guide'**
  String get help;

  /// No description provided for @introHelp.
  ///
  /// In en, this message translates to:
  /// **'Guide and Information'**
  String get introHelp;

  /// No description provided for @subIntroHelp.
  ///
  /// In en, this message translates to:
  /// **'Everyone needs to know how the app works'**
  String get subIntroHelp;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get update;

  /// No description provided for @updateNote_0.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0 in 2025-01-01:\n\nInitial implementation of all features such as marking the cards you have and metrics on how close you are to completing the collection and/or challenges'**
  String get updateNote_0;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get info;

  /// No description provided for @infoNote_0.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our Pokémon card collection management application! Here you can organize and track your letters in a practical and efficient way. Below, we explain how to use each available feature:'**
  String get infoNote_0;

  /// No description provided for @infoNote_1.
  ///
  /// In en, this message translates to:
  /// **'1. Marking your Cards\nWhen accessing the card list, you will be able to view all the cards available in the official game. To mark a card as obtained, simply tap the check box next to the corresponding Pokémon. You can deselect at any time if you need to adjust your collection.'**
  String get infoNote_1;

  /// No description provided for @infoNote_2.
  ///
  /// In en, this message translates to:
  /// **'2. Using Filters\nThe list of cards can be filtered to facilitate your search. You can apply filters by:\n- Rarity: Select common, rare or legendary cards.\n- Collection Packs: Choose a specific set of cards.\n- Promo Cards: View only special promotional letters.\nThese filters allow for more organized and faster navigation within the application.'**
  String get infoNote_2;

  /// No description provided for @infoNote_3.
  ///
  /// In en, this message translates to:
  /// **'3. Tracking Collection Progress\nThe application provides a metrics screen where you can view your collection progress through interactive graphs. On this screen you will find:\n- Percentage of Busters Obtained: A graph displaying the percentage of cards you have already collected in relation to the total available.\n- Challenges: Some personalized missions to encourage your collection, such as obtaining the MEW card in the first collection, among others.'**
  String get infoNote_3;

  /// No description provided for @infoNote_4.
  ///
  /// In en, this message translates to:
  /// **'Extra Tips\n- Keep your collection up to date to accurately track your progress.\n- Use the filters to quickly find the cards you need.\n- Check back frequently for challenges to motivate your search for new cards.'**
  String get infoNote_4;

  /// No description provided for @guid.
  ///
  /// In en, this message translates to:
  /// **'Usage Guide'**
  String get guid;

  /// No description provided for @guidInfo_0.
  ///
  /// In en, this message translates to:
  /// **'The background colors of each card in the list represent each pack, these being so far:\n- Charizard: Represented by the color Orange\n- Pikachu: Represented by the color Yellow\n- Mewtwo: Represented by the color Purple\n- Celebi: Represented by the color Green\n- Palkia: Represented by the color Pink\n- Dialga: Represented by the color Blue\nBelow we have an example that illustrates this well'**
  String get guidInfo_0;

  /// No description provided for @guidInfo_1.
  ///
  /// In en, this message translates to:
  /// **'In the line where the rates are displayed, the percentage for each place where it can appear is displayed:\n- 1-3: Appearance rate on the first three cards\n- 4: Appearance rate on the fourth card\n- 5: Appearance rate on the fifth card'**
  String get guidInfo_1;

  /// No description provided for @guidInfo_2.
  ///
  /// In en, this message translates to:
  /// **'Regarding the graph, it will be filled as the cards are marked for each collection, and the total obtained for each buster will be displayed, however, when exceeding 50% of cards obtained from the collection, a gray layer will also be displayed that represents how much remains for the entire collection to be completed.\n\nBy sliding the screen to the side, the other collections available to date will be displayed with their appropriate information.'**
  String get guidInfo_2;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
