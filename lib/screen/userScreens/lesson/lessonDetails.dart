import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/const.dart';
import 'package:mosque/component/widgets/lesson_card.dart';
import 'package:mosque/component/widgets/pdf_view.dart';
import 'package:mosque/const/colors.dart';
import 'package:mosque/generated/l10n.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/helper/socket.dart';
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
  HomeUserCubit? homeUserCubit;
  bool isFirstTimeSection(String idSection) {
    for (var element in homeUserCubit!.userDataModel!.sectionProgress!) {
      if (element.section == idSection) {
        return true;
      }
    }
    return false;
  }

  LessonCubit? lessonCubit;
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
    homeUserCubit = HomeUserCubit.get(context);
    lessonCubit = LessonCubit.get(context);
    lessonCubit?.getSectionById(id: widget.idSection).then((value) {
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
          if (state.model.lessonObjects!.isNotEmpty) {
            if (!isFirstTimeSection(widget.idSection)) {
              await homeUserCubit!.updateLessonCompletionStatus(
                idlesson: model!.lessonObjects!.first.id!,
                idSection: widget.idSection,
                score: 100,
              );
            }
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
          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
              color: Colors.black,
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is GetSectionByIdStateBad) {
          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
              color: Colors.black,
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
            body: const Center(
              child: Text('Error'),
            ),
          );
        } else {
          if (state is GetSectionByIdStateGood &&
              state.model.lessonObjects!.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                color: Colors.black,
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
              body: Center(
                child: Container(
                  child: Text(
                    S.of(context).there_are_no_lessons_yet,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            );
          }
          return YoutubePlayerBuilder(
            player: player,
            builder: (context, player) {
              return Scaffold(
                appBar: AppBar(
                    // title: const Text('YouTube Player '),
                    leading: IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
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
                            : MorInfo(
                                lessonId: model
                                        ?.lessonObjects![
                                            LessonCubit.get(context)
                                                .indexLesson]
                                        .id ??
                                    '',
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

class CustomTabView extends StatelessWidget {
  final int numberOfLessons;
  final Function(int) changeTab;
  final int index;

  const CustomTabView(
      {super.key,
      required this.changeTab,
      required this.index,
      required this.numberOfLessons});

  @override
  Widget build(BuildContext context) {
    final List<String> tags = [
      "${S.of(context).playlist} ($numberOfLessons)",
      (S.of(context).moreInfo),
    ];
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tags.asMap().entries.map((MapEntry map) {
          bool isSelected = index == map.key;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                changeTab(map.key);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blueAccent : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    map.value,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
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
  HomeUserCubit? homeUserCubit;

  int index = 0;
  List<bool> isPlaying = [false, false, false, false, false, false];
  int score = 0;
  bool isSameSection(String idSection) {
    for (var element in homeUserCubit!.userDataModel!.sectionProgress!) {
      if (element.section == idSection) {
        return true;
      }
    }
    return false;
  }

  bool isCompletedlesson(Lesson lesson, String idSection) {
    // homeUserCubit.getMyInfo();
    for (var element in homeUserCubit!.userDataModel!.sectionProgress!) {
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
    homeUserCubit = HomeUserCubit.get(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeUserCubit, HomeUserState>(
      listener: (context, state) {
        if (state is UpdateLessonCompletionStateGood) {
          LessonCubit.get(context).changeIndexLesson(index: index);
          widget.controller
              .load(getYoutubeVideoId(widget.lesson[index].urlVideo ?? ''));
          CachHelper.putcache(key: '${widget.idSection}user', value: index);

          setState(() {});
        }
      },
      child: SizedBox(
        height: 400,
        child: ListView.separated(
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
                  widget.controller.load(
                      getYoutubeVideoId(widget.lesson[index].urlVideo ?? ''));
                  CachHelper.putcache(
                      key: "${widget.idSection}user", value: index);
                } else {
                  if (isCompletedlesson(
                      widget.lesson[index - 1], widget.idSection)) {
                    widget.controller.pause();
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(
                          sectionId: widget.idSection,
                          lessonId: widget.lesson[index].id!,
                          onQuizCompleted: (int score) async {
                            if (score >= 0.5) {
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
      ),
    );
  }
}

class MorInfo extends StatefulWidget {
  final String description;
  final String pdfUrl;
  final String lessonId;

  const MorInfo({
    super.key,
    required this.description,
    required this.pdfUrl,
    required this.lessonId,
  });

  @override
  State<MorInfo> createState() => _MorInfoState();
}

class _MorInfoState extends State<MorInfo> {
  List<Comment> comments = [];
  String? newCommentId;
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
            label: Text(
              S.of(context).supplement,
              style: const TextStyle(
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
  final String lessonId;
  final List<Comment> comments;

  const CommentSection({
    super.key,
    required this.lessonId,
    required this.comments,
  });

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _commentController = TextEditingController();
  final SocketService _socketService = SocketService();
  late List<Comment> _comments;
  HomeUserCubit? homeUserCubit;

  @override
  void initState() {
    super.initState();
    homeUserCubit = HomeUserCubit.get(context);
    _comments = widget.comments;
    _socketService.joinLesson(widget.lessonId);
    _socketService.listenForNewComments((data) {
      print(data);
      data['_id'] = LessonCubit.get(context).newCommentId;
      print(data);
      setState(() {
        _comments.add(Comment.fromJson(data));
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    _socketService.leaveLesson(widget.lessonId);
    // SocketService.socket!.disconnect();
    super.dispose();
  }

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      final comment = _commentController.text;
      final userId = homeUserCubit!
          .userDataModel!.id!; // Get the user ID from your user management
      // const onModel = 'User'; // or 'Admin'
      LessonCubit.get(context)
          .addCommentUserToLesson(
        lessinId: widget.lessonId,
        comment: comment,
        // userID: userId,
        // onModel: onModel
      )
          .then((value) {
        _socketService.sendComment(widget.lessonId, comment, userId,
            homeUserCubit!.userDataModel!.username!);
      });

      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).comments,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: S.of(context).add_a_comment,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _addComment,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 400,
          child: ListView.builder(
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: _comments.length,
            itemBuilder: (context, index) {
              return CommentsItems(
                comments: _comments[index],
                userID: homeUserCubit!.userDataModel!.id!,
                lessonID: widget.lessonId,
              );
            },
          ),
        ),
      ],
    );
  }
}

class CommentsItems extends StatefulWidget {
  final Comment comments;
  final String userID;
  final String lessonID;

  const CommentsItems({
    super.key,
    required this.comments,
    required this.userID,
    required this.lessonID,
  });

  @override
  State<CommentsItems> createState() => _CommentsItemsState();
}

class _CommentsItemsState extends State<CommentsItems> {
  bool isDelete = false;

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = widget.userID == widget.comments.user?.id;
    bool isAdmin = widget.comments.isAdmin ?? false;

    // Define a primary color for the design
    final Color primaryColor = Colors.blue[50]!;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isCurrentUser ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isCurrentUser &&
                !isDelete &&
                !(widget.comments.isDeleted ?? false))
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(S.of(context).delete_comment),
                            content: Text(S.of(context).confirm_delete_comment),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(S.of(context).no),
                              ),
                              TextButton(
                                onPressed: () {
                                  LessonCubit.get(context)
                                      .deleteComment(
                                    lessonID: widget.lessonID,
                                    commentID: widget.comments.id!,
                                  )
                                      .then((value) {
                                    setState(() {
                                      isDelete = true;
                                    });
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(S.of(context).yes),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            if (!isCurrentUser)
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 20,
                backgroundImage: widget.comments.user?.photo != null
                    ? NetworkImage(widget.comments.user!.photo!)
                    : const AssetImage('assets/images/user.png')
                        as ImageProvider,
              ),
            if (!isCurrentUser) const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: isCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: isCurrentUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.comments.user?.username ??
                            S.of(context).unknown_user,
                        style: TextStyle(
                          fontWeight:
                              isAdmin ? FontWeight.bold : FontWeight.normal,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      if (isAdmin) ...[
                        const SizedBox(width: 5),
                        const Icon(Icons.verified,
                            size: 16, color: Colors.black87),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  widget.comments.isDeleted == true || isDelete == true
                      ? Text(
                          S.of(context).comment_deleted,
                          style: TextStyle(color: Colors.red[300]),
                        )
                      : Text(
                          widget.comments.comment ?? '',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black87),
                        ),
                  const SizedBox(height: 5),
                  Text(
                    widget.comments.createdAt ?? '',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (isCurrentUser) const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
