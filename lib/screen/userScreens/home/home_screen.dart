// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/appbar.dart';
import 'package:mosque/component/cache_network_img.dart';
import 'package:mosque/component/category/category.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/component/sorting.dart';
import 'package:mosque/const/colors.dart';
import 'package:mosque/generated/l10n.dart';
import 'package:mosque/screen/userScreens/home/cubit/home_user_cubit.dart';
import 'package:mosque/screen/userScreens/profile/profile.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  HomeUserCubit? homeUserCubit;

  @override
  void initState() {
    homeUserCubit = HomeUserCubit.get(context);
    homeUserCubit?.getMyInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      // Bottom bar
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: S.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_rounded),
              label: S.of(context).favorite,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.message),
              label: S.of(context).messages,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: S.of(context).profile,
            ),
          ],
          selectedItemColor: kpink,
          unselectedItemColor: Colors.grey[300],
        ),
      ),

      body: SafeArea(
        child: ListView(
          children: [
            const CustomeAppBar(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  BlocConsumer<HomeUserCubit, HomeUserState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Row(
                        children: [
                          state is GetMyInformationLoading
                              ? const HiShimmer()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${S.of(context).hi} ${homeUserCubit!.userDataModel!.username}', // e.g., "Hi Houssam!"
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      S
                                          .of(context)
                                          .motivationalQuote, // e.g., "Today is a good day\nto learn something new!"
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        wordSpacing: 2.5,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                          const Spacer(),
                          Column(
                            children: [
                              state is GetMyInformationLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : InkWell(
                                      onTap: () {
                                        navigatAndReturn(
                                            context: context,
                                            page: const ProfileUser());
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 35,
                                        backgroundImage: HomeUserCubit.get(
                                                        context)
                                                    .userDataModel!
                                                    .photo !=
                                                null
                                            ? CachedNetworkImageWidgetProvider
                                                .getImageProvider(
                                                HomeUserCubit.get(context)
                                                    .userDataModel!
                                                    .photo!,
                                              )
                                            : const AssetImage(
                                                    'assets/images/user.png')
                                                as ImageProvider,
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Sorting(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).categories, // e.g., "Categories"
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          S.of(context).seeAll, // e.g., "See All"
                          style: const TextStyle(fontSize: 16, color: kblue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const CategoryList(
                    isAdmin: false,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HiShimmer extends StatelessWidget {
  const HiShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(
          milliseconds: 1200), // Adjust duration for shimmer speed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: 180,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
