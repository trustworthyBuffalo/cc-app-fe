import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

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
    Locale('id'),
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get signIn;

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

  /// No description provided for @cpassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get cpassword;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get name;

  /// No description provided for @signInMail.
  ///
  /// In en, this message translates to:
  /// **'Campus Email'**
  String get signInMail;

  /// No description provided for @nim.
  ///
  /// In en, this message translates to:
  /// **'Student ID'**
  String get nim;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @msg.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get msg;

  /// No description provided for @openChat.
  ///
  /// In en, this message translates to:
  /// **'Tap to Open Chat'**
  String get openChat;

  /// No description provided for @editChat.
  ///
  /// In en, this message translates to:
  /// **'Hold to Edit'**
  String get editChat;

  /// No description provided for @addPost.
  ///
  /// In en, this message translates to:
  /// **'New Post'**
  String get addPost;

  /// No description provided for @titleAddPost.
  ///
  /// In en, this message translates to:
  /// **'Add Post'**
  String get titleAddPost;

  /// No description provided for @addImageURL.
  ///
  /// In en, this message translates to:
  /// **'Enter Image URL'**
  String get addImageURL;

  /// No description provided for @writePost.
  ///
  /// In en, this message translates to:
  /// **'Write Description'**
  String get writePost;

  /// No description provided for @ads.
  ///
  /// In en, this message translates to:
  /// **'Advertisement'**
  String get ads;

  /// No description provided for @uploud.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get uploud;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @notifSet.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notifSet;

  /// No description provided for @likeNotifSet.
  ///
  /// In en, this message translates to:
  /// **'Like Notifications'**
  String get likeNotifSet;

  /// No description provided for @commentNotifSet.
  ///
  /// In en, this message translates to:
  /// **'Comment Notifications'**
  String get commentNotifSet;

  /// No description provided for @followNotifSet.
  ///
  /// In en, this message translates to:
  /// **'Follower Notifications'**
  String get followNotifSet;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @post.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get post;

  /// No description provided for @media.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get media;

  /// No description provided for @like.
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get like;

  /// No description provided for @vip.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get vip;

  /// No description provided for @followers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get followers;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get setting;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacy;

  /// No description provided for @aboutApk.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApk;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @desImgRequired.
  ///
  /// In en, this message translates to:
  /// **'Description and URL are Required Fields'**
  String get desImgRequired;

  /// No description provided for @succesSend.
  ///
  /// In en, this message translates to:
  /// **'Send!'**
  String get succesSend;

  /// No description provided for @chatNN.
  ///
  /// In en, this message translates to:
  /// **'Change NickName'**
  String get chatNN;

  /// No description provided for @chatBg.
  ///
  /// In en, this message translates to:
  /// **'Change Background Chat'**
  String get chatBg;

  /// No description provided for @likeNotif.
  ///
  /// In en, this message translates to:
  /// **'like your post'**
  String get likeNotif;

  /// No description provided for @commentNotif.
  ///
  /// In en, this message translates to:
  /// **'Commented your post'**
  String get commentNotif;

  /// No description provided for @followNotif.
  ///
  /// In en, this message translates to:
  /// **'started following you'**
  String get followNotif;

  /// No description provided for @chooseLang.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLang;

  /// No description provided for @indonesia.
  ///
  /// In en, this message translates to:
  /// **'Bahasa'**
  String get indonesia;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'english'**
  String get english;
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
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
