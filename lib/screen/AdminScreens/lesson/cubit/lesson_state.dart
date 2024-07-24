part of 'lesson_cubit.dart';

@immutable
sealed class LessonAdminState {}

final class LessonInitial extends LessonAdminState {}

final class ErrorState extends LessonAdminState {
  final ErrorModel model;
  ErrorState({required this.model});
}

final class GetSectionByIdLoading extends LessonAdminState {}

final class GetSectionByIdStateGood extends LessonAdminState {
  final SectionModel model;

  GetSectionByIdStateGood({required this.model});
}

final class GetSectionByIdStateBad extends LessonAdminState {}

final class ChangeUrlVideoState extends LessonAdminState {}

final class ChangeIndexLessonState extends LessonAdminState {}

final class AddCommentToLessonLoading extends LessonAdminState {}

final class AddCommentToLessonStateGood extends LessonAdminState {
  AddCommentToLessonStateGood();
}

final class AddCommentToLessonStateBad extends LessonAdminState {}

final class GetCommentsLoading extends LessonAdminState {}

final class GetCommentsGood extends LessonAdminState {
  final List<Comment> comments;

  GetCommentsGood({required this.comments});
}

final class GetCommentsBad extends LessonAdminState {}

final class GetQuizLoading extends LessonAdminState {}

final class GetQuizGood extends LessonAdminState {
  final List<Quiz> quiz;

  GetQuizGood({required this.quiz});
}

final class GetQuizBad extends LessonAdminState {}

final class DeleteCommentLoading extends LessonAdminState {}

final class DeleteCommentGood extends LessonAdminState {}

final class DeleteCommentBad extends LessonAdminState {}

final class UpdateQuizLoading extends LessonAdminState {}

final class UpdateQuizGood extends LessonAdminState {}

final class UpdateQuizBad extends LessonAdminState {}
