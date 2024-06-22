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