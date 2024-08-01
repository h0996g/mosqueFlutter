part of 'profile_cubit.dart';

@immutable
sealed class ProfileUserState {}

final class ProfileInitial extends ProfileUserState {}

final class ErrorState extends ProfileUserState {
  final ErrorModel model;
  ErrorState({required this.model});
}

final class ImagePickerProfileUserStateGood extends ProfileUserState {}

final class ImagePickerProfileUserStateBad extends ProfileUserState {}

final class UploadProfileUserImgAndGetUrlStateBad extends ProfileUserState {}

final class UpdateUserLoadingState extends ProfileUserState {}

final class UpdateUserStateGood extends ProfileUserState {
  final DataUserModel model;

  UpdateUserStateGood({required this.model});
}

final class UpdateUserStateBad extends ProfileUserState {}

final class UpdateMdpUserLoadingState extends ProfileUserState {}

final class UpdateMdpUserStateGood extends ProfileUserState {}

final class UpdateMdpAdminStateBad extends ProfileUserState {}

final class PasswordVisibilityChanged extends ProfileUserState {}
