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

final class ChangeIndexLessonState extends LessonState {}

final class AddCommentToLessonLoading extends LessonState {}

final class AddCommentToLessonStateGood extends LessonState {
  AddCommentToLessonStateGood();
}

final class AddCommentToLessonStateBad extends LessonState {}

final class GetCommentsLoading extends LessonState {}

final class GetCommentsGood extends LessonState {
  final List<Comment> comments;

  GetCommentsGood({required this.comments});
}

final class GetCommentsBad extends LessonState {}

final class GetQuizLoading extends LessonState {}

final class GetQuizGood extends LessonState {
  final List<Quiz> quiz;

  GetQuizGood({required this.quiz});
}

final class GetQuizBad extends LessonState {}

final class DeleteCommentLoading extends LessonState {}

final class DeleteCommentGood extends LessonState {}

final class DeleteCommentBad extends LessonState {}
