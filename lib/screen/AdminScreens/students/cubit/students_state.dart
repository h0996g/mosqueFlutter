part of 'students_cubit.dart';

@immutable
sealed class StudentsState {}

final class StudentsInitial extends StudentsState {}

final class GetStudentsLoading extends StudentsState {}

final class GetStudentsGood extends StudentsState {
  final List<DataUserModel> students;

  GetStudentsGood({required this.students});
}

final class GetStudentsBad extends StudentsState {}

final class StudentsError extends StudentsState {
  final ErrorModel model;
  StudentsError({required this.model});
}
