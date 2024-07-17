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
  final SectionModel model;

  GetSectionByIdStateGood({required this.model});
}

final class GetSectionByIdStateBad extends LessonState {}

final class ChangeUrlVideoState extends LessonState {}

final class changeIndexLessonState extends LessonState {}

final class AddCommentToLessonLoading extends LessonState {}

final class AddCommentToLessonStateGood extends LessonState {}

final class AddCommentToLessonStateBad extends LessonState {}

final class GetCommentsLoading extends LessonState {}

final class GetCommentsGood extends LessonState {
  final List<Comment> comments;

  GetCommentsGood({required this.comments});
}

final class GetCommentsBad extends LessonState {}
