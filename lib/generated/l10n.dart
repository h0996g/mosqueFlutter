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

  /// `Students`
  String get students {
    return Intl.message(
      'Students',
      name: 'students',
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

  /// `About Us`
  String get about_us {
    return Intl.message(
      'About Us',
      name: 'about_us',
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

  /// `Hi Teacher!`
  String get hiTeacher {
    return Intl.message(
      'Hi Teacher!',
      name: 'hiTeacher',
      desc: '',
      args: [],
    );
  }

  /// `Today is a great opportunity to impart wisdom and foster learning`
  String get goodDayToLearn {
    return Intl.message(
      'Today is a great opportunity to impart wisdom and foster learning',
      name: 'goodDayToLearn',
      desc: '',
      args: [],
    );
  }

  /// `Create a New Lesson`
  String get createNewLesson {
    return Intl.message(
      'Create a New Lesson',
      name: 'createNewLesson',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the details for your new lesson.`
  String get fillInLessonDetails {
    return Intl.message(
      'Fill in the details for your new lesson.',
      name: 'fillInLessonDetails',
      desc: '',
      args: [],
    );
  }

  /// `Title must not be empty`
  String get titleEmptyError {
    return Intl.message(
      'Title must not be empty',
      name: 'titleEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Description must not be empty`
  String get descriptionEmptyError {
    return Intl.message(
      'Description must not be empty',
      name: 'descriptionEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Video URL must not be empty`
  String get videoUrlEmptyError {
    return Intl.message(
      'Video URL must not be empty',
      name: 'videoUrlEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Duration must not be empty`
  String get durationEmptyError {
    return Intl.message(
      'Duration must not be empty',
      name: 'durationEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Upload Supplement PDF`
  String get uploadSupplementPdf {
    return Intl.message(
      'Upload Supplement PDF',
      name: 'uploadSupplementPdf',
      desc: '',
      args: [],
    );
  }

  /// `Uploading lesson PDF...`
  String get uploadingPdf {
    return Intl.message(
      'Uploading lesson PDF...',
      name: 'uploadingPdf',
      desc: '',
      args: [],
    );
  }

  /// `Create Lesson`
  String get createLesson {
    return Intl.message(
      'Create Lesson',
      name: 'createLesson',
      desc: '',
      args: [],
    );
  }

  /// `Lesson created successfully`
  String get lessonCreatedSuccess {
    return Intl.message(
      'Lesson created successfully',
      name: 'lessonCreatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to create lesson`
  String get lessonCreationFailed {
    return Intl.message(
      'Failed to create lesson',
      name: 'lessonCreationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Lesson Title`
  String get lessonTitle {
    return Intl.message(
      'Lesson Title',
      name: 'lessonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Video URL`
  String get videoUrl {
    return Intl.message(
      'Video URL',
      name: 'videoUrl',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Create a New Section`
  String get createNewSection {
    return Intl.message(
      'Create a New Section',
      name: 'createNewSection',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the details for your new section.`
  String get fillInSectionDetails {
    return Intl.message(
      'Fill in the details for your new section.',
      name: 'fillInSectionDetails',
      desc: '',
      args: [],
    );
  }

  /// `Section name must not be empty`
  String get sectionNameEmptyError {
    return Intl.message(
      'Section name must not be empty',
      name: 'sectionNameEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Upload Section Photo`
  String get uploadSectionPhoto {
    return Intl.message(
      'Upload Section Photo',
      name: 'uploadSectionPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Uploading section photo...`
  String get uploadingPhoto {
    return Intl.message(
      'Uploading section photo...',
      name: 'uploadingPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Add Section`
  String get addSection {
    return Intl.message(
      'Add Section',
      name: 'addSection',
      desc: '',
      args: [],
    );
  }

  /// `Section created successfully`
  String get sectionCreatedSuccess {
    return Intl.message(
      'Section created successfully',
      name: 'sectionCreatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to create section`
  String get sectionCreationFailed {
    return Intl.message(
      'Failed to create section',
      name: 'sectionCreationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Section Name`
  String get sectionName {
    return Intl.message(
      'Section Name',
      name: 'sectionName',
      desc: '',
      args: [],
    );
  }

  /// `Edit Section`
  String get editSection {
    return Intl.message(
      'Edit Section',
      name: 'editSection',
      desc: '',
      args: [],
    );
  }

  /// `Update the details for your section.`
  String get updateSectionDetails {
    return Intl.message(
      'Update the details for your section.',
      name: 'updateSectionDetails',
      desc: '',
      args: [],
    );
  }

  /// `Update Section`
  String get updateSection {
    return Intl.message(
      'Update Section',
      name: 'updateSection',
      desc: '',
      args: [],
    );
  }

  /// `Section updated successfully`
  String get sectionUpdatedSuccess {
    return Intl.message(
      'Section updated successfully',
      name: 'sectionUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update section. Please try again later.`
  String get sectionUpdateFailed {
    return Intl.message(
      'Failed to update section. Please try again later.',
      name: 'sectionUpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Edit Lesson`
  String get editLesson {
    return Intl.message(
      'Edit Lesson',
      name: 'editLesson',
      desc: '',
      args: [],
    );
  }

  /// `Update the details of your lesson.`
  String get updateLessonDetails {
    return Intl.message(
      'Update the details of your lesson.',
      name: 'updateLessonDetails',
      desc: '',
      args: [],
    );
  }

  /// `Video URL`
  String get videoURL {
    return Intl.message(
      'Video URL',
      name: 'videoURL',
      desc: '',
      args: [],
    );
  }

  /// `Upload Supplement PDF`
  String get uploadSupplementPDF {
    return Intl.message(
      'Upload Supplement PDF',
      name: 'uploadSupplementPDF',
      desc: '',
      args: [],
    );
  }

  /// `Update Lesson`
  String get updateLesson {
    return Intl.message(
      'Update Lesson',
      name: 'updateLesson',
      desc: '',
      args: [],
    );
  }

  /// `Lesson updated successfully`
  String get lessonUpdatedSuccess {
    return Intl.message(
      'Lesson updated successfully',
      name: 'lessonUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update lesson. Please try again later.`
  String get lessonUpdateFailed {
    return Intl.message(
      'Failed to update lesson. Please try again later.',
      name: 'lessonUpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Video URL must not be empty`
  String get videoURLEmptyError {
    return Intl.message(
      'Video URL must not be empty',
      name: 'videoURLEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Quiz Editor`
  String get quizEditorTitle {
    return Intl.message(
      'Quiz Editor',
      name: 'quizEditorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Quiz updated successfully`
  String get quizUpdatedSuccessfully {
    return Intl.message(
      'Quiz updated successfully',
      name: 'quizUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error updating quiz`
  String get errorUpdatingQuiz {
    return Intl.message(
      'Error updating quiz',
      name: 'errorUpdatingQuiz',
      desc: '',
      args: [],
    );
  }

  /// `Delete Question`
  String get deleteQuestionTitle {
    return Intl.message(
      'Delete Question',
      name: 'deleteQuestionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this question?`
  String get deleteQuestionContent {
    return Intl.message(
      'Are you sure you want to delete this question?',
      name: 'deleteQuestionContent',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Add Question`
  String get addQuestion {
    return Intl.message(
      'Add Question',
      name: 'addQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Edit Question`
  String get editQuestion {
    return Intl.message(
      'Edit Question',
      name: 'editQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Question`
  String get question {
    return Intl.message(
      'Question',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get options {
    return Intl.message(
      'Options',
      name: 'options',
      desc: '',
      args: [],
    );
  }

  /// `Add Option`
  String get addOption {
    return Intl.message(
      'Add Option',
      name: 'addOption',
      desc: '',
      args: [],
    );
  }

  /// `Option`
  String get option {
    return Intl.message(
      'Option',
      name: 'option',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Verify Password`
  String get verifyPassword {
    return Intl.message(
      'Verify Password',
      name: 'verifyPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password to verify your identity.`
  String get enterPassword {
    return Intl.message(
      'Please enter your password to verify your identity.',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enterYourPassword {
    return Intl.message(
      'Enter your password',
      name: 'enterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delete`
  String get confirmDelete {
    return Intl.message(
      'Confirm Delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this lesson?`
  String get deleteLessonConfirmation {
    return Intl.message(
      'Are you sure you want to delete this lesson?',
      name: 'deleteLessonConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Lesson Options`
  String get lessonOptionsTitle {
    return Intl.message(
      'Lesson Options',
      name: 'lessonOptionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Show Quiz`
  String get showQuiz {
    return Intl.message(
      'Show Quiz',
      name: 'showQuiz',
      desc: '',
      args: [],
    );
  }

  /// `Delete Lesson`
  String get deleteLesson {
    return Intl.message(
      'Delete Lesson',
      name: 'deleteLesson',
      desc: '',
      args: [],
    );
  }

  /// `Delete Section`
  String get deleteSectionTitle {
    return Intl.message(
      'Delete Section',
      name: 'deleteSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete "{sectionName}"?`
  String deleteSectionContent(Object sectionName) {
    return Intl.message(
      'Are you sure you want to delete "$sectionName"?',
      name: 'deleteSectionContent',
      desc: '',
      args: [sectionName],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Surname`
  String get surname {
    return Intl.message(
      'Surname',
      name: 'surname',
      desc: '',
      args: [],
    );
  }

  /// `Modify Profile`
  String get modifyProfile {
    return Intl.message(
      'Modify Profile',
      name: 'modifyProfile',
      desc: '',
      args: [],
    );
  }

  /// `Modify Password`
  String get modifyPassword {
    return Intl.message(
      'Modify Password',
      name: 'modifyPassword',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must not be empty`
  String get passwordMustNotBeEmpty {
    return Intl.message(
      'Password must not be empty',
      name: 'passwordMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get passwordChangedSuccessfully {
    return Intl.message(
      'Password changed successfully',
      name: 'passwordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Server crashed`
  String get serverCrashed {
    return Intl.message(
      'Server crashed',
      name: 'serverCrashed',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Username must not be empty`
  String get usernameMustNotBeEmpty {
    return Intl.message(
      'Username must not be empty',
      name: 'usernameMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Show progress`
  String get show_progress {
    return Intl.message(
      'Show progress',
      name: 'show_progress',
      desc: '',
      args: [],
    );
  }

  /// `Quiz`
  String get quizTitle {
    return Intl.message(
      'Quiz',
      name: 'quizTitle',
      desc: '',
      args: [],
    );
  }

  /// `Time remaining: {remainingSeconds} seconds`
  String timeRemaining(Object remainingSeconds) {
    return Intl.message(
      'Time remaining: $remainingSeconds seconds',
      name: 'timeRemaining',
      desc: '',
      args: [remainingSeconds],
    );
  }

  /// `Error loading quiz`
  String get errorLoadingQuiz {
    return Intl.message(
      'Error loading quiz',
      name: 'errorLoadingQuiz',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Your Score`
  String get yourScore {
    return Intl.message(
      'Your Score',
      name: 'yourScore',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuee {
    return Intl.message(
      'Continue',
      name: 'continuee',
      desc: '',
      args: [],
    );
  }

  /// `Check Answer`
  String get checkAnswer {
    return Intl.message(
      'Check Answer',
      name: 'checkAnswer',
      desc: '',
      args: [],
    );
  }

  /// `There are no lessons yet`
  String get there_are_no_lessons_yet {
    return Intl.message(
      'There are no lessons yet',
      name: 'there_are_no_lessons_yet',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations`
  String get congratulations {
    return Intl.message(
      'Congratulations',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Focus and try again`
  String get focusAndTryAgain {
    return Intl.message(
      'Focus and try again',
      name: 'focusAndTryAgain',
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
