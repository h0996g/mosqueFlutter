part of 'home_user_cubit.dart';

@immutable
sealed class HomeUserState {}

final class HomeUserInitial extends HomeUserState {}

final class GetMyInformationLoading extends HomeUserState {}

final class GetMyInformationStateGood extends HomeUserState {
  final DataUserModel model;
  GetMyInformationStateGood({required this.model});
}

final class ErrorState extends HomeUserState {
  final ErrorModel model;
  ErrorState({required this.model});
}

final class GetMyInformationStateBad extends HomeUserState {}

final class GetAllSectionLoading extends HomeUserState {}

final class GetAllSectionStateGood extends HomeUserState {
  final List<SectionModel> model;

  GetAllSectionStateGood({required this.model});
}

final class GetAllSectionStateBad extends HomeUserState {}

final class UpdateLessonCompletionStatusLoading extends HomeUserState {}

final class UpdateLessonCompletionStateGood extends HomeUserState {}

final class UpdateLessonCompletionStateBad extends HomeUserState {}
