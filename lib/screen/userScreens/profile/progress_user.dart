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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: progressData.length,
              itemBuilder: (context, index) {
                return SectionCard(sectionData: progressData[index]);
              },
            ),
          ),
        );
      },
    );
  }
}

class SectionCard extends StatelessWidget {
  final ProDataModel sectionData;

  const SectionCard({super.key, required this.sectionData});

  Color _getProgressColor(double score) {
    if (score == 100) {
      return Colors.green; // Gold for 100%
    } else if (score >= 80) {
      return Colors.amber; // Green for 80-99%
    } else if (score >= 50) {
      return Colors.yellow; // Yellow for 50-79%
    } else {
      return Colors.grey; // Default color for below 50%
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionData.section.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            sectionData.section.description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: sectionData.completedLessons.map((lesson) {
              final double score = lesson.score.toDouble();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lesson.lesson.title,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: score / 100,
                            backgroundColor: Colors.grey[300],
                            color: _getProgressColor(score),
                            minHeight: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${lesson.score}%',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
