import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/widgets/lesson_card.dart';
import 'package:mosque/const/colors.dart';
import 'package:mosque/model/section_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:mosque/screen/userScreens/lesson/cubit/lesson_cubit.dart';

class LessonScreen extends StatefulWidget {
  final String idSection;

  const LessonScreen({super.key, required this.idSection});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  LessonCubit lessonCubit = LessonCubit();

  int _selectedTag = 0;

  void changeTab(int index) {
    setState(() {
      _selectedTag = index;
    });
  }

  late YoutubePlayerController _controller;
  late YoutubePlayer player;

  @override
  void initState() {
    super.initState();
    lessonCubit = LessonCubit.get(context);
    lessonCubit.getSectionById(id: widget.idSection);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LessonCubit, LessonState>(
      listener: (context, state) {
        if (state is GetSectionByIdStateGood) {
          // print(state.model.lessons.map((e) => e['urlVideo']));
          _controller = YoutubePlayerController(
            initialVideoId:
                state.model.lessonObjects!.first.urlVideo, // YouTube video ID
            flags: const YoutubePlayerFlags(
                autoPlay: false, mute: false, enableCaption: false),
          )..addListener(() {
              if (!_controller.value.isFullScreen) {
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                    overlays: SystemUiOverlay.values);
              }
            });

          player = YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              print('Player is ready.');
            },
            onEnded: (data) {
              _controller
                  .load('5qap5aO4i9A'); // Example of loading another video
            },
          );
        }
      },
      builder: (context, state) {
        if (state is GetSectionByIdLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetSectionByIdStateBad) {
          return const Center(
            child: Text('Error'),
          );
        } else if (state is GetSectionByIdStateGood) {
          return YoutubePlayerBuilder(
            player: player,
            builder: (context, player) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('YouTube Player'),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Column(
                    children: <Widget>[
                      // some widgets
                      player,
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        state.model.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        state.model.lessonObjects!.first.description,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.grey,
                          ),
                          Text(
                            " 72 Hours",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      CustomTabView(
                        numberOfLessons: state.model.lessonObjects!.length,
                        index: _selectedTag,
                        changeTab: changeTab,
                      ),
                      _selectedTag == 0
                          ? PlayList(
                              lesson: state.model.lessonObjects!,
                            )
                          : Description(
                              description: state.model.description,
                            ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}

class CustomTabView extends StatefulWidget {
  final int numberOfLessons;
  final Function(int) changeTab;
  final int index;
  const CustomTabView(
      {super.key,
      required this.changeTab,
      required this.index,
      required this.numberOfLessons});

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tags = ["Playlist (${widget.numberOfLessons})", "Description"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: _tags.asMap().entries.map((MapEntry map) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                widget.changeTab(map.key);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: widget.index == map.key
                      ? kPrimaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    map.value,
                    style: TextStyle(
                      color:
                          widget.index == map.key ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ignore: must_be_immutable
class PlayList extends StatelessWidget {
  final List<Lesson> lesson;
  List<bool> isPlaying = [true, false, false, false, false, false];
  PlayList({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 20,
          );
        },
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        shrinkWrap: true,
        itemCount: lesson.length,
        itemBuilder: (_, index) {
          bool isPlaying = this.isPlaying[index];
          // bool isCompleted = false;
          // if (index == 0) {
          //   isCompleted = true;
          // }

          return LessonCard(
              lesson: lesson[index], isPlaying: isPlaying, isCompleted: false);
        },
      ),
    );
  }
}

class Description extends StatelessWidget {
  final String description;
  const Description({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0), child: Text(description));
  }
}
