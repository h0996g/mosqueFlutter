import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/component/const.dart';
import 'package:mosque/component/widgets/lesson_card.dart';
import 'package:mosque/component/widgets/pdf_view.dart';
import 'package:mosque/const/colors.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/model/section_model.dart';
import 'package:mosque/screen/userScreens/home/cubit/home_user_cubit.dart';
import 'package:mosque/component/widgets/quiz_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:mosque/screen/userScreens/lesson/cubit/lesson_cubit.dart';

class LessonScreen extends StatefulWidget {
  final String idSection;

  const LessonScreen({super.key, required this.idSection});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  bool isFirstTimeSection(String idSection) {
    HomeUserCubit homeUserCubit = HomeUserCubit.get(context);
    for (var element in homeUserCubit.userDataModel!.sectionProgress!) {
      if (element.section == idSection) {
        return true;
      }
    }
    return false;
  }

  LessonCubit lessonCubit = LessonCubit();
  // int? indexLesson;
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
    // indexLesson = CachHelper.getData(key: widget.idSection) ?? 0;

    lessonCubit = LessonCubit.get(context);
    lessonCubit.getSectionById(id: widget.idSection).then((value) {
      _controller = YoutubePlayerController(
        initialVideoId: LessonCubit.get(context).urlVideo, // YouTube video ID

        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          enableCaption: false,
          // hideControls: true,
        ),
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
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LessonCubit, LessonState>(
      listener: (context, state) async {
        if (state is GetSectionByIdStateGood) {
          model = state.model;
          if (!isFirstTimeSection(widget.idSection)) {
            await HomeUserCubit.get(context).updateLessonCompletionStatus(
              idlesson: model!.lessonObjects!.first.id,
              idSection: widget.idSection,
              score: 100,
            );
          }
        }
      },
      builder: (context, state) {
        // if (state is GetMyInformationLoading) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }

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
                  title: const Text('YouTube Player '),
                ),
                body: SingleChildScrollView(
                  child: Padding(
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
                        Row(
                          children: [
                            const Icon(
                              Icons.timer,
                              color: Colors.grey,
                            ),
                            Text(
                              '  ${model?.lessonObjects![LessonCubit.get(context).indexLesson].duration} ',
                              style: const TextStyle(
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
                                // indexLesson: !,
                                controller: _controller,
                                lesson: model?.lessonObjects! ?? [],
                                idSection: widget.idSection,
                              )
                            : Description(
                                lessonId: model
                                        ?.lessonObjects![
                                            LessonCubit.get(context)
                                                .indexLesson]
                                        .id ??
                                    '',
                                // comment: model
                                //         ?.lessonObjects![
                                //             LessonCubit.get(context)
                                //                 .indexLesson]
                                //         .comments ??
                                //     [],
                                pdfUrl: model
                                        ?.lessonObjects![
                                            LessonCubit.get(context)
                                                .indexLesson]
                                        .suplemmentPdf ??
                                    '',
                                description: model
                                        ?.lessonObjects![
                                            LessonCubit.get(context)
                                                .indexLesson]
                                        .description ??
                                    '',
                              ),
                      ],
                    ),
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
    _tags = ["Playlist (${widget.numberOfLessons})", "More Info"];
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
  // int indexLesson;
  YoutubePlayerController controller;

  PlayList({
    super.key,
    required this.lesson,
    required this.idSection,
    required this.controller,
    // required this.indexLesson
  });

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  int index = 0;
  List<bool> isPlaying = [false, false, false, false, false, false];
  int score = 0;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var isThisSection = isSameSection(widget.idSection);
    return BlocListener<HomeUserCubit, HomeUserState>(
      listener: (context, state) {
        if (state is UpdateLessonCompletionStateGood) {
          LessonCubit.get(context).changeIndexLesson(index: index);
          widget.controller
              .load(getYoutubeVideoId(widget.lesson[index].urlVideo));
          CachHelper.putcache(key: widget.idSection, value: index);

          setState(() {});
        }
      },
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 20,
          );
        },
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        itemCount: widget.lesson.length,
        itemBuilder: (_, index) {
          bool isSelected = index == LessonCubit.get(context).indexLesson;
          bool isPlaying = index == LessonCubit.get(context).indexLesson;

          // if (isThisSection) {
          return InkWell(
            onTap: () async {
              if (isCompletedlesson(widget.lesson[index], widget.idSection)) {
                LessonCubit.get(context).changeIndexLesson(index: index);
                widget.controller
                    .load(getYoutubeVideoId(widget.lesson[index].urlVideo));
                CachHelper.putcache(key: widget.idSection, value: index);
              } else {
                if (isCompletedlesson(
                    widget.lesson[index - 1], widget.idSection)) {
                  showToast(msg: 'msg', state: ToastStates.success);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(
                        lesson: widget.lesson[index],
                        onQuizCompleted: (int score) async {
                          if (score / widget.lesson[index].quize.length >=
                              0.5) {
                            this.index = index;
                          }
                        },
                      ),
                    ),
                  );
                }
              }
            },
            child: LessonCard(
              lesson: widget.lesson[index],
              isPlaying: isPlaying,
              isCompleted: isCompletedlesson(
                widget.lesson[index],
                widget.idSection,
              ),
              isSelected: isSelected,
            ),
          );
        },
      ),
    );
  }
}

class Description extends StatefulWidget {
  final String description;
  final String pdfUrl;
  final String lessonId;

  const Description({
    super.key,
    required this.description,
    required this.pdfUrl,
    required this.lessonId,
  });

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  List<Comment> comments = [];
  @override
  void initState() {
    LessonCubit.get(context).getComments(lessonID: widget.lessonId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Text(
            widget.description,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewerPage(url: widget.pdfUrl),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
            ),
            icon: const Icon(
              Icons.picture_as_pdf,
              color: Colors.white,
            ),
            label: const Text(
              'Supplement',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          BlocConsumer<LessonCubit, LessonState>(
            listener: (context, state) {
              if (state is GetCommentsGood) {
                comments = state.comments;
              }
            },
            builder: (context, state) {
              if (state is GetCommentsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CommentSection(
                comments: comments,
                lessonId: widget.lessonId,
              );
            },
          ),
        ],
      ),
    );
  }
}

class CommentSection extends StatefulWidget {
  final List<Comment> comments;
  final String lessonId;
  const CommentSection(
      {super.key, required this.comments, required this.lessonId});

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _commentController = TextEditingController();
  // final List<String> _comments = [];

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        // _comments.add(_commentController.text);
        LessonCubit.get(context).addCommentToLesson(
            lessinId: widget.lessonId,
            comment: _commentController.text,
            userID: HomeUserCubit.get(context).userDataModel!.id!,
            onModel: 'User');
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Comments',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _commentController,
          decoration: InputDecoration(
            hintText: 'Add a comment...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: _addComment,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.comments.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.comments[index].comment),
            );
          },
        ),
      ],
    );
  }
}
