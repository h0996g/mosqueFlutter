// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/model/progress_model.dart';

import 'package:mosque/screen/userScreens/profile/cubit/profile_cubit.dart';

class ProgressUserDetails extends StatefulWidget {
  final String id;
  const ProgressUserDetails({
    super.key,
    required this.id,
  });

  @override
  State<ProgressUserDetails> createState() => _ProgressUserDetailsState();
}

class _ProgressUserDetailsState extends State<ProgressUserDetails> {
  ProfileUserCubit? _cubit;
  List<ProDataModel> progressData = [];
  @override
  void initState() {
    _cubit = ProfileUserCubit.get(context);
    _cubit!.getProgressUser(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileUserCubit, ProfileUserState>(
      listener: (context, state) {
        if (state is GetProgressUserStateGood) {
          progressData = state.model;
        }
      },
      builder: (context, state) {
        if (state is GetProgressUserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            // title: const Text('User Progress'),
            leading: IconButton(
              color: Colors.black,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView.builder(
            itemCount: progressData.length,
            itemBuilder: (context, index) {
              return SectionCard(sectionData: progressData[index]);
            },
          ),
        );
      },
    );
  }
}

class SectionCard extends StatelessWidget {
  final ProDataModel sectionData;

  const SectionCard({super.key, required this.sectionData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sectionData.section.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(sectionData.section.description),
            const SizedBox(height: 10),
            const Divider(),
            ...sectionData.completedLessons.map((lesson) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    lesson.score.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(lesson.lesson.title),
              );
            }),
          ],
        ),
      ),
    );
  }
}
