part of 'lesson_cubit.dart';

@immutable
sealed class LessonState {}

final class LessonInitial extends LessonState {}

final class ErrorState extends LessonState {
  final ErrorModel model;
  ErrorState({required this.model});
}

final class GetSectionByIdLoading extends LessonState {}

final class GetSectionByIdStateGood extends LessonState {
  final List<SectionModel> model;

  GetSectionByIdStateGood({required this.model});
}

final class GetSectionByIdStateBad extends LessonState {}
