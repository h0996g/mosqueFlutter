import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/const.dart';
import 'package:mosque/component/widgets/lesson_card_admin.dart';
import 'package:mosque/component/widgets/pdf_view.dart';
import 'package:mosque/const/colors.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/helper/socket.dart';
import 'package:mosque/model/section_model.dart';
import 'package:mosque/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:mosque/screen/AdminScreens/lesson/cubit/lesson_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonAdminScreen extends StatefulWidget {
  final String idSection;

  const LessonAdminScreen({super.key, required this.idSection});

  @override
  _LessonAdminScreenState createState() => _LessonAdminScreenState();
}

class _LessonAdminScreenState extends State<LessonAdminScreen> {
  HomeAdminCubit? homeAdminCubit;
  // bool isFirstTimeSection(String idSection) {
  //   for (var element in homeUserCubit!.userDataModel!.sectionProgress!) {
  //     if (element.section == idSection) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  LessonAdminCubit? lessonAdminCubit;
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
    lessonAdminCubit = LessonAdminCubit.get(context);
    lessonAdminCubit?.getSectionById(id: widget.idSection).then((value) {
      _controller = YoutubePlayerController(
        initialVideoId:
            LessonAdminCubit.get(context).urlVideo, // YouTube video ID

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
    return BlocConsumer<LessonAdminCubit, LessonAdminState>(
      listener: (context, state) async {
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
                                      LessonAdminCubit.get(context).indexLesson]
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
                              '  ${model?.lessonObjects![LessonAdminCubit.get(context).indexLesson].duration} ',
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
                                            LessonAdminCubit.get(context)
                                                .indexLesson]
                                        .id ??
                                    '',
                                pdfUrl: model
                                        ?.lessonObjects![
                                            LessonAdminCubit.get(context)
                                                .indexLesson]
                                        .suplemmentPdf ??
                                    '',
                                description: model
                                        ?.lessonObjects![
                                            LessonAdminCubit.get(context)
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
    // print(widget.lesson.length);
    // var isThisSection = isSameSection(widget.idSection);
    return SizedBox(
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
          bool isSelected = index == LessonAdminCubit.get(context).indexLesson;
          bool isPlaying = index == LessonAdminCubit.get(context).indexLesson;

          // if (isThisSection) {
          return InkWell(
            onTap: () async {
              LessonAdminCubit.get(context).changeIndexLesson(index: index);
              widget.controller
                  .load(getYoutubeVideoId(widget.lesson[index].urlVideo ?? ''));
              CachHelper.putcache(key: widget.idSection, value: index);
            },
            child: LessonCardAdmin(
              lesson: widget.lesson[index],
              isPlaying: isPlaying,
              isSelected: isSelected,
            ),
          );
        },
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
    LessonAdminCubit.get(context).getComments(lessonID: widget.lessonId);
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
          BlocConsumer<LessonAdminCubit, LessonAdminState>(
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
              // return Text('Comments');
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
  HomeAdminCubit? homeAdminCubit;

  @override
  void initState() {
    super.initState();
    homeAdminCubit = HomeAdminCubit.get(context);
    _comments = widget.comments;
    _socketService.joinLesson(widget.lessonId);
    _socketService.listenForNewComments((data) {
      print(data);
      data['_id'] = LessonAdminCubit.get(context).newCommentId;
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
      final userId = homeAdminCubit!
          .adminModel!.id!; // Get the user ID from your user management
      const onModel = 'Admin'; // or 'Admin'
      LessonAdminCubit.get(context)
          .addCommentToLesson(
              lessinId: widget.lessonId,
              comment: comment,
              userID: userId,
              onModel: onModel)
          .then((value) {
        _socketService.sendComment(widget.lessonId, comment, userId, onModel,
            homeAdminCubit!.adminModel!.username!);
      });

      _commentController.clear();
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
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
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
                userID: homeAdminCubit!.adminModel!.id!,
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

  const CommentsItems(
      {super.key,
      required this.comments,
      required this.userID,
      required this.lessonID});

  @override
  State<CommentsItems> createState() => _CommentsItemsState();
}

class _CommentsItemsState extends State<CommentsItems> {
  bool isDelete = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: widget.userID == widget.comments.user?.id
            ? Border.all(color: Colors.grey.shade800)
            : Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.comments.user?.username ?? 'Unknown User',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                widget.comments.isDeleted == true || isDelete == true
                    ? Text(
                        'Comment Deleted',
                        style: TextStyle(color: Colors.red[300]),
                      )
                    : Text(widget.comments.comment ?? ''),
                const SizedBox(height: 5),
                Text(
                  widget.comments.createdAt ?? '',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          if (widget.userID == widget.comments.user?.id &&
              (widget.comments.isDeleted == false && isDelete == false))
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete Comment'),
                        content: const Text(
                            'Are you sure you want to delete this comment?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              LessonAdminCubit.get(context)
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
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    });
              },
            ),
        ],
      ),
    );
  }
}
