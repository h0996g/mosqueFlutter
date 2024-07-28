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
