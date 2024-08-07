import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/cache_network_img.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/generated/l10n.dart';
import 'package:mosque/screen/AdminScreens/lesson/cubit/lesson_cubit.dart';
import 'package:mosque/screen/AdminScreens/lesson/edite_section.dart';
import 'package:mosque/screen/AdminScreens/lesson/lessonDetails.dart';
import 'package:mosque/screen/userScreens/lesson/lessonDetails.dart';
import 'package:mosque/model/section_model.dart';
import 'package:mosque/component/category/cubit/category_cubit.dart';
import 'package:shimmer/shimmer.dart';

class CategoryList extends StatefulWidget {
  final bool isAdmin;
  const CategoryList({
    super.key,
    required this.isAdmin,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  CategoryCubit? categoryCubit;
  List<SectionModel> model = [];

  @override
  void initState() {
    categoryCubit = CategoryCubit.get(context);
    categoryCubit?.getAllSection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is GetAllSectionStateGood) {
          model = state.model;
        } else if (state is DeleteSectionGood) {
          CategoryCubit.get(context).getAllSection();
          showToast(
              msg: S.of(context).sectionCreatedSuccessfully, // Updated
              state: ToastStates.success);
        } else if (state is DeleteSectionBad) {
          showToast(
              msg: S.of(context).failedToCreateDelete, // Updated
              state: ToastStates.error);
        } else if (state is ErrorCategoryState) {
          showToast(
              msg: state.model.message ?? S.of(context).error, // Updated
              state: ToastStates.error);
        }
      },
      builder: (context, state) {
        if (state is DeleteSectionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetAllSectionLoading) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.9),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => const ShimmerCategoryCard(),
          );
        } else {
          return GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: model.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.9),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onLongPress: widget.isAdmin
                  ? () => _showOptionsDialog(context, model[index])
                  : null,
              child: CategoryCard(
                isAdmin: widget.isAdmin,
                sectionModel: model[index],
                idSection: model[index].id!,
              ),
            ),
          );
        }
      },
    );
  }

  void _showOptionsDialog(BuildContext context, SectionModel sectionModel) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<LessonAdminCubit, LessonAdminState>(
          listener: (BuildContext context, LessonAdminState state) {},
          builder: (context, state) {
            if (state is DeleteSectionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return AlertDialog(
              title: Text(S.of(context).chooseAnOption), // Updated
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: Text(S.of(context).edit), // Updated
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditSectionPage(
                            section:
                                sectionModel, // pass the relevant sectionModel here
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: Text(S.of(context).delete), // Updated
                    onTap: () {
                      Navigator.pop(context);
                      showDeleteDialog(context, sectionModel);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ShimmerCategoryCard extends StatelessWidget {
  const ShimmerCategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15.0),
                ),
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 18.0,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 100.0,
                    height: 14.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String idSection;
  final bool isAdmin;
  final SectionModel sectionModel;

  const CategoryCard({
    Key? key,
    required this.sectionModel,
    required this.idSection,
    required this.isAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isAdmin) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LessonScreen(
                      idSection: idSection,
                    )),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LessonAdminScreen(
                      idSection: idSection,
                    )),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15.0),
              ),
              child: sectionModel.photo != null
                  ? CachedNetworkImageWidget(
                      imageUrl: sectionModel.photo ?? '',
                    )
                  : Center(
                      child: Text(
                        S.of(context).noPhotoAvailable, // Updated
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
            )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sectionModel.name!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${S.of(context).lessons_numbers}: ${sectionModel.lessonIds?.length} ", // Updated
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
