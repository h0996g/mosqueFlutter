part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class ErrorCategoryState extends CategoryState {
  final ErrorModel model;
  ErrorCategoryState({required this.model});
}

final class GetAllSectionLoading extends CategoryState {}

final class GetAllSectionStateGood extends CategoryState {
  final List<SectionModel> model;

  GetAllSectionStateGood({required this.model});
}

final class GetAllSectionStateBad extends CategoryState {}

final class DeleteSectionLoading extends CategoryState {}

final class DeleteSectionGood extends CategoryState {}

final class DeleteSectionBad extends CategoryState {}

final class ImagePickerSectionStateGood extends CategoryState {}

final class ImagePickerSectionStateBad extends CategoryState {}

final class UploadSectionImgAndGetUrlStateBad extends CategoryState {}

final class UpdateSectionLoading extends CategoryState {}

final class UpdateSectionGood extends CategoryState {}

final class UpdateSectionBad extends CategoryState {}

final class CreateSectionLoading extends CategoryState {}

final class CreateSectionGood extends CategoryState {}

final class CreateSectionBad extends CategoryState {}

final class ResetImageSectionState extends CategoryState {}
