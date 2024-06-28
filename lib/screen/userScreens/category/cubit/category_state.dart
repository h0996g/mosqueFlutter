part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class ErrorState extends CategoryState {
  final ErrorModel model;
  ErrorState({required this.model});
}

final class GetAllSectionLoading extends CategoryState {}

final class GetAllSectionStateGood extends CategoryState {
  final List<SectionModel> model;

  GetAllSectionStateGood({required this.model});
}

final class GetAllSectionStateBad extends CategoryState {}
