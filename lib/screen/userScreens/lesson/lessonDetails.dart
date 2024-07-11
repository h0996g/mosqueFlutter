import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/widgets/lesson_card.dart';
import 'package:mosque/const/colors.dart';
import 'package:mosque/model/section_model.dart';
import 'package:mosque/screen/userScreens/home/cubit/home_user_cubit.dart';
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
  int indexLesson = 0;
  int _selectedTag = 0;

  void changeTab(int index) {
    setState(() {
      _selectedTag = index;
    });
  }

  SectionModel? model;

  late YoutubePlayerController _controller;
  late YoutubePlayer player;

  @override
  void initState() {
    super.initState();
    lessonCubit = LessonCubit.get(context);
    lessonCubit.getSectionById(id: widget.idSection);
    _controller = YoutubePlayerController(
      initialVideoId:
          // LessonCubit.get(context).urlVideo, // YouTube video ID
          'pB7uZzu2dLI',
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
        _controller.load('5qap5aO4i9A'); // Example of loading another video
      },
    );
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
          model = state.model;
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
        } else {
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
                        model?.name ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        model
                                ?.lessonObjects![
                                    LessonCubit.get(context).indexLesson]
                                .description ??
                            '',
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
                        numberOfLessons: model?.lessonObjects!.length ?? 0,
                        index: _selectedTag,
                        changeTab: changeTab,
                      ),
                      _selectedTag == 0
                          ? PlayList(
                              indexLesson: indexLesson,
                              controller: _controller,
                              lesson: model?.lessonObjects! ?? [],
                              idSection: widget.idSection,
                            )
                          : Description(
                              description: model?.description ?? '',
                            ),
                    ],
                  ),
                ),
              );
            },
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
class PlayList extends StatefulWidget {
  final String idSection;
  final List<Lesson> lesson;
  int indexLesson;
  YoutubePlayerController controller;

  PlayList(
      {super.key,
      required this.lesson,
      required this.idSection,
      required this.controller,
      required this.indexLesson});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  List<bool> isPlaying = [true, false, false, false, false, false];
  bool isSameSection(String idSection) {
    HomeUserCubit homeUserCubit = HomeUserCubit.get(context);
    for (var element in homeUserCubit.userDataModel!.sectionProgress!) {
      if (element.section == idSection) {
        return true;
      }
    }
    return false;
  }

  bool isCompletedlesson(Lesson lesson, String idSection) {
    HomeUserCubit homeUserCubit = HomeUserCubit.get(context);
    // homeUserCubit.getMyInfo();
    for (var element in homeUserCubit.userDataModel!.sectionProgress!) {
      if (element.section == idSection) {
        for (var element in element.completedLessons!) {
          if (element.id == lesson.id) {
            // isCompleted[widget.lesson.indexOf(lesson)] = true;
            return true;
          }
        }
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isThisSection = isSameSection(widget.idSection);
    print(widget.idSection);
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 20,
          );
        },
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        shrinkWrap: true,
        itemCount: widget.lesson.length,
        itemBuilder: (_, index) {
          bool isPlaying = this.isPlaying[index];

          if (isThisSection) {
            return InkWell(
              onTap: () {
                LessonCubit.get(context).changeIndexLesson(index: index);

                // widget.controller
                //     .load(getYoutubeVideoId(widget.lesson[index].urlVideo));
              },
              child: LessonCard(
                  lesson: widget.lesson[index],
                  isPlaying: isPlaying,
                  isCompleted: isCompletedlesson(
                      widget.lesson[index], widget.idSection)),
            );
          }
          return null;
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
