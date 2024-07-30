// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Log in to access a wealth of courses designed to enhance your knowledge. Begin your journey of growth and learning today!`
  String get discover_text {
    return Intl.message(
      'Log in to access a wealth of courses designed to enhance your knowledge. Begin your journey of growth and learning today!',
      name: 'discover_text',
      desc: '',
      args: [],
    );
  }

  /// `Email must not be empty`
  String get email_empty {
    return Intl.message(
      'Email must not be empty',
      name: 'email_empty',
      desc: '',
      args: [],
    );
  }

  /// `Password must not be empty`
  String get password_empty {
    return Intl.message(
      'Password must not be empty',
      name: 'password_empty',
      desc: '',
      args: [],
    );
  }

  /// `teacher`
  String get teacher {
    return Intl.message(
      'teacher',
      name: 'teacher',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Or login with`
  String get or_login_with {
    return Intl.message(
      'Or login with',
      name: 'or_login_with',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password_label {
    return Intl.message(
      'Password',
      name: 'password_label',
      desc: '',
      args: [],
    );
  }

  /// `Let's create your account`
  String get create_account_title {
    return Intl.message(
      'Let\'s create your account',
      name: 'create_account_title',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message(
      'Last Name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `First Name must not be empty`
  String get first_name_empty {
    return Intl.message(
      'First Name must not be empty',
      name: 'first_name_empty',
      desc: '',
      args: [],
    );
  }

  /// `Last Name must not be empty`
  String get last_name_empty {
    return Intl.message(
      'Last Name must not be empty',
      name: 'last_name_empty',
      desc: '',
      args: [],
    );
  }

  /// `Phone must not be empty`
  String get phone_empty {
    return Intl.message(
      'Phone must not be empty',
      name: 'phone_empty',
      desc: '',
      args: [],
    );
  }

  /// `Age must not be empty`
  String get age_empty {
    return Intl.message(
      'Age must not be empty',
      name: 'age_empty',
      desc: '',
      args: [],
    );
  }

  /// `Hi`
  String get hi {
    return Intl.message(
      'Hi',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Or sign in with`
  String get or_sign_in_with {
    return Intl.message(
      'Or sign in with',
      name: 'or_sign_in_with',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email_label {
    return Intl.message(
      'Email',
      name: 'email_label',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone_label {
    return Intl.message(
      'Phone',
      name: 'phone_label',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age_label {
    return Intl.message(
      'Age',
      name: 'age_label',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Hi Houssam!`
  String get greetingUser {
    return Intl.message(
      'Hi Houssam!',
      name: 'greetingUser',
      desc: '',
      args: [],
    );
  }

  /// `Today is a good day\nto learn something new!`
  String get motivationalQuote {
    return Intl.message(
      'Today is a good day\nto learn something new!',
      name: 'motivationalQuote',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Proposal`
  String get proposal {
    return Intl.message(
      'Proposal',
      name: 'proposal',
      desc: '',
      args: [],
    );
  }

  /// `Prophets' Stories`
  String get prophetsStories {
    return Intl.message(
      'Prophets\' Stories',
      name: 'prophetsStories',
      desc: '',
      args: [],
    );
  }

  /// `Rulings and sermons`
  String get Rulings_and_sermons {
    return Intl.message(
      'Rulings and sermons',
      name: 'Rulings_and_sermons',
      desc: '',
      args: [],
    );
  }

  /// `Advice`
  String get advice {
    return Intl.message(
      'Advice',
      name: 'advice',
      desc: '',
      args: [],
    );
  }

  /// `Section created successfully`
  String get sectionCreatedSuccessfully {
    return Intl.message(
      'Section created successfully',
      name: 'sectionCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to create Delete`
  String get failedToCreateDelete {
    return Intl.message(
      'Failed to create Delete',
      name: 'failedToCreateDelete',
      desc: '',
      args: [],
    );
  }

  /// `Choose an option`
  String get chooseAnOption {
    return Intl.message(
      'Choose an option',
      name: 'chooseAnOption',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `No photo available`
  String get noPhotoAvailable {
    return Intl.message(
      'No photo available',
      name: 'noPhotoAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Number of lessons`
  String get lessons_numbers {
    return Intl.message(
      'Number of lessons',
      name: 'lessons_numbers',
      desc: '',
      args: [],
    );
  }

  /// `Playlist`
  String get playlist {
    return Intl.message(
      'Playlist',
      name: 'playlist',
      desc: '',
      args: [],
    );
  }

  /// `More Info`
  String get moreInfo {
    return Intl.message(
      'More Info',
      name: 'moreInfo',
      desc: '',
      args: [],
    );
  }

  /// `Supplement`
  String get supplement {
    return Intl.message(
      'Supplement',
      name: 'supplement',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Add a comment...`
  String get add_a_comment {
    return Intl.message(
      'Add a comment...',
      name: 'add_a_comment',
      desc: '',
      args: [],
    );
  }

  /// `Unknown User`
  String get unknown_user {
    return Intl.message(
      'Unknown User',
      name: 'unknown_user',
      desc: '',
      args: [],
    );
  }

  /// `Comment Deleted`
  String get comment_deleted {
    return Intl.message(
      'Comment Deleted',
      name: 'comment_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Delete Comment`
  String get delete_comment {
    return Intl.message(
      'Delete Comment',
      name: 'delete_comment',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this comment?`
  String get confirm_delete_comment {
    return Intl.message(
      'Are you sure you want to delete this comment?',
      name: 'confirm_delete_comment',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Deepen your understanding of Islamic teachings and enhance your personal growth. Explore a range of courses designed to enrich your knowledge and strengthen your faith. Begin your journey towards greater wisdom and personal development today!`
  String get learn_with_pleasure {
    return Intl.message(
      'Deepen your understanding of Islamic teachings and enhance your personal growth. Explore a range of courses designed to enrich your knowledge and strengthen your faith. Begin your journey towards greater wisdom and personal development today!',
      name: 'learn_with_pleasure',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get get_started {
    return Intl.message(
      'Get Started',
      name: 'get_started',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Nom`
  String get nom {
    return Intl.message(
      'Nom',
      name: 'nom',
      desc: '',
      args: [],
    );
  }

  /// `Prenom`
  String get prenom {
    return Intl.message(
      'Prenom',
      name: 'prenom',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Modify Profile`
  String get modify_profile {
    return Intl.message(
      'Modify Profile',
      name: 'modify_profile',
      desc: '',
      args: [],
    );
  }

  /// `Modify Password`
  String get modify_password {
    return Intl.message(
      'Modify Password',
      name: 'modify_password',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `French`
  String get french {
    return Intl.message(
      'French',
      name: 'french',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact_us {
    return Intl.message(
      'Contact Us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Disconnected`
  String get disconnect {
    return Intl.message(
      'Disconnected',
      name: 'disconnect',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get telephone {
    return Intl.message(
      'Phone',
      name: 'telephone',
      desc: '',
      args: [],
    );
  }

  /// `Choose the source:`
  String get chooseSource {
    return Intl.message(
      'Choose the source:',
      name: 'chooseSource',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Name must not be empty`
  String get nameMustNotBeEmpty {
    return Intl.message(
      'Name must not be empty',
      name: 'nameMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Surname must not be empty`
  String get prenomMustNotBeEmpty {
    return Intl.message(
      'Surname must not be empty',
      name: 'prenomMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Age must not be empty`
  String get ageMustNotBeEmpty {
    return Intl.message(
      'Age must not be empty',
      name: 'ageMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Email must not be empty`
  String get emailMustNotBeEmpty {
    return Intl.message(
      'Email must not be empty',
      name: 'emailMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Phone must not be empty`
  String get phoneMustNotBeEmpty {
    return Intl.message(
      'Phone must not be empty',
      name: 'phoneMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
