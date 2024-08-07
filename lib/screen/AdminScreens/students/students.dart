import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/cache_network_img.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/model/user_model.dart';
import 'package:mosque/screen/AdminScreens/students/cubit/students_cubit.dart';
import 'package:mosque/screen/userScreens/profile/profile_other.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  late final List<DataUserModel> students;
  StudentsCubit? studentsCubit;
  @override
  void initState() {
    studentsCubit = StudentsCubit.get(context);
    studentsCubit!.getStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentsCubit, StudentsState>(
      listener: (context, state) {
        if (state is GetStudentsGood) {
          students = state.students;
        }
      },
      builder: (context, state) {
        if (state is GetStudentsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  navigatAndReturn(
                      context: context,
                      page: ProfileOtherStudent(
                        id: students[index].id!,
                      ));
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: students[index].photo != null
                      ? CachedNetworkImageWidgetProvider.getImageProvider(
                          students[index].photo!,
                        )
                      : Image.asset('assets/images/user.png').image,
                ),
                title: Text(students[index].username!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text(students[index].email!),
              );
            },
            itemCount: students.length);
      },
    );
  }
}
