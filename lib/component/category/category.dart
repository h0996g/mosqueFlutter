import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        // TODO: implement listener
      },
      builder: (context, state) {
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
        }
        if (state is GetAllSectionStateGood) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: state.model.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.9),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => CategoryCard(
              isAdmin: widget.isAdmin,
              sectionModel: state.model[index],
              idSection: state.model[index].id!,
            ),
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
  const CategoryCard(
      {super.key,
      required this.sectionModel,
      required this.idSection,
      required this.isAdmin});
  final SectionModel sectionModel;

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
                child: Image.network(
                  sectionModel.photo ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
                    "${sectionModel.lessonIds?.length} lessons",
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
