import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Shartflix'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @uploadProfilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Profile Photo'**
  String get uploadProfilePhoto;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorite movies yet.'**
  String get noFavorites;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @shortDescription.
  ///
  /// In en, this message translates to:
  /// **'Community every territories dogpile so...'**
  String get shortDescription;

  /// No description provided for @fullDescription.
  ///
  /// In en, this message translates to:
  /// **'Community every territories dogpile so. Last they investigation model and more details about the movie can be shown here for the user to read.'**
  String get fullDescription;

  /// No description provided for @alertTitle.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get alertTitle;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @subtitle.
  ///
  /// In en, this message translates to:
  /// **'Last Journey'**
  String get subtitle;

  /// No description provided for @genre.
  ///
  /// In en, this message translates to:
  /// **'Science Fiction'**
  String get genre;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'This is a movie about...'**
  String get description;

  /// No description provided for @loveAndAdventure.
  ///
  /// In en, this message translates to:
  /// **'Love and Adventure'**
  String get loveAndAdventure;

  /// No description provided for @midnight.
  ///
  /// In en, this message translates to:
  /// **'Midnight'**
  String get midnight;

  /// No description provided for @lostCity.
  ///
  /// In en, this message translates to:
  /// **'Lost City'**
  String get lostCity;

  /// No description provided for @lastJourney.
  ///
  /// In en, this message translates to:
  /// **'Last Journey'**
  String get lastJourney;

  /// No description provided for @secretGarden.
  ///
  /// In en, this message translates to:
  /// **'Secret Garden'**
  String get secretGarden;

  /// No description provided for @brokenDreams.
  ///
  /// In en, this message translates to:
  /// **'Broken Dreams'**
  String get brokenDreams;

  /// No description provided for @underTheStars.
  ///
  /// In en, this message translates to:
  /// **'Under the Stars'**
  String get underTheStars;

  /// No description provided for @lightInTheDark.
  ///
  /// In en, this message translates to:
  /// **'Light in the Dark'**
  String get lightInTheDark;

  /// No description provided for @onceUponATime.
  ///
  /// In en, this message translates to:
  /// **'Once Upon a Time'**
  String get onceUponATime;

  /// No description provided for @colorsOfLife.
  ///
  /// In en, this message translates to:
  /// **'Colors of Life'**
  String get colorsOfLife;

  /// No description provided for @watch.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get watch;

  /// No description provided for @dramaRomance.
  ///
  /// In en, this message translates to:
  /// **'Drama / Romance'**
  String get dramaRomance;

  /// No description provided for @thrillerMystery.
  ///
  /// In en, this message translates to:
  /// **'Thriller / Mystery'**
  String get thrillerMystery;

  /// No description provided for @adventureFantasy.
  ///
  /// In en, this message translates to:
  /// **'Adventure / Fantasy'**
  String get adventureFantasy;

  /// No description provided for @scienceFiction.
  ///
  /// In en, this message translates to:
  /// **'Science Fiction'**
  String get scienceFiction;

  /// No description provided for @familyComedy.
  ///
  /// In en, this message translates to:
  /// **'Family / Comedy'**
  String get familyComedy;

  /// No description provided for @actionCrime.
  ///
  /// In en, this message translates to:
  /// **'Action / Crime'**
  String get actionCrime;

  /// No description provided for @animation.
  ///
  /// In en, this message translates to:
  /// **'Animation'**
  String get animation;

  /// No description provided for @documentary.
  ///
  /// In en, this message translates to:
  /// **'Documentary'**
  String get documentary;

  /// No description provided for @horror.
  ///
  /// In en, this message translates to:
  /// **'Horror'**
  String get horror;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @profileDetail.
  ///
  /// In en, this message translates to:
  /// **'Profile Detail'**
  String get profileDetail;

  /// No description provided for @limitedOffer.
  ///
  /// In en, this message translates to:
  /// **'Limited Offer'**
  String get limitedOffer;

  /// No description provided for @userId.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get userId;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @favoriteMovies.
  ///
  /// In en, this message translates to:
  /// **'Favorite Movies'**
  String get favoriteMovies;

  /// No description provided for @uploadYourPhotos.
  ///
  /// In en, this message translates to:
  /// **'Upload Your Photos'**
  String get uploadYourPhotos;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can upload your profile photo here.'**
  String get profileSubtitle;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @offerDescription.
  ///
  /// In en, this message translates to:
  /// **'This is a limited time offer. Take advantage now!'**
  String get offerDescription;

  /// No description provided for @claimOffer.
  ///
  /// In en, this message translates to:
  /// **'Claim Offer'**
  String get claimOffer;

  /// No description provided for @perWeek.
  ///
  /// In en, this message translates to:
  /// **'Per week'**
  String get perWeek;

  /// No description provided for @yourBonuses.
  ///
  /// In en, this message translates to:
  /// **'Your Bonuses'**
  String get yourBonuses;

  /// No description provided for @premiumAccount.
  ///
  /// In en, this message translates to:
  /// **'Premium\nAccount'**
  String get premiumAccount;

  /// No description provided for @moreMatches.
  ///
  /// In en, this message translates to:
  /// **'More\nMatches'**
  String get moreMatches;

  /// No description provided for @highlight.
  ///
  /// In en, this message translates to:
  /// **'Highlight'**
  String get highlight;

  /// No description provided for @moreLikes.
  ///
  /// In en, this message translates to:
  /// **'More\nLikes'**
  String get moreLikes;

  /// No description provided for @selectCoinPackage.
  ///
  /// In en, this message translates to:
  /// **'Select a coin package to unlock'**
  String get selectCoinPackage;

  /// No description provided for @seeAllCoins.
  ///
  /// In en, this message translates to:
  /// **'See All Coins'**
  String get seeAllCoins;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

// app_localizations.dart: Uygulamanın çoklu dil desteği için otomatik üretilen localization dosyası.
// Tüm metin çevirileri ve AppLocalizations sınıfı burada bulunur.
