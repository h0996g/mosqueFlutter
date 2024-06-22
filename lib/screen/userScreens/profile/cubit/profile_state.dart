part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ErrorState extends ProfileState {
  final ErrorModel model;
  ErrorState({required this.model});
}

final class ImagePickerProfileUserStateGood extends ProfileState {}

final class ImagePickerProfileUserStateBad extends ProfileState {}

final class UploadProfileUserImgAndGetUrlStateBad extends ProfileState {}

final class UpdateUserLoadingState extends ProfileState {}

final class UpdateUserStateGood extends ProfileState {
  final DataUserModel model;

  UpdateUserStateGood({required this.model});
}

final class UpdateUserStateBad extends ProfileState {}
