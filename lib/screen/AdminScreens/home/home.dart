// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/cache_network_img.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:mosque/const/colors.dart';
import 'package:mosque/screen/AdminScreens/profile/profile.dart';

import '../../../component/category/category.dart';
import '../../../component/sorting.dart';
import 'package:mosque/generated/l10n.dart'; // Import your localization file

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  HomeAdminCubit? homeAdminCubit;
  @override
  void initState() {
    homeAdminCubit = HomeAdminCubit.get(context);
    homeAdminCubit!.getMyInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // floatingActionButton:
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: _selectedIndex,
        //   onTap: (index) {
        //     setState(() {
        //       _selectedIndex = index;
        //     });
        //   },
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: const Icon(Icons.home),
        //       label: S.of(context).home, // Updated
        //     ),
        //     BottomNavigationBarItem(
        //       icon: const Icon(Icons.group),
        //       label: S.of(context).students, // Updated
        //     ),
        //     BottomNavigationBarItem(
        //       icon: const Icon(Icons.message),
        //       label: S.of(context).messages, // Updated
        //     ),
        //     BottomNavigationBarItem(
        //       icon: const Icon(Icons.person),
        //       label: S.of(context).profile, // Updated
        //     ),
        //   ],
        //   selectedItemColor: kpink,
        //   unselectedItemColor: Colors.grey[300],
        // ),

        ListView(
      children: [
        // const CustomeAppBar(),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              BlocConsumer<HomeAdminCubit, HomeAdminState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).hiTeacher, // Updated
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7),
                            child: Text(
                              S.of(context).goodDayToLearn, // Updated
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black54,
                                wordSpacing: 2.5,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          state is GetMyInformationLoading
                              ? const Center(child: CircularProgressIndicator())
                              : InkWell(
                                  onTap: () {
                                    navigatAndReturn(
                                        context: context,
                                        page: const ProfileAdmin());
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 35,
                                    backgroundImage: HomeAdminCubit.get(context)
                                                .adminModel!
                                                .photo !=
                                            null
                                        ? CachedNetworkImageWidgetProvider
                                            .getImageProvider(
                                            HomeAdminCubit.get(context)
                                                .adminModel!
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
              const SizedBox(
                height: 20,
              ),
              // sorting
              const Sorting(),
              const SizedBox(
                height: 20,
              ),
              // category list
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).categories, // Updated
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      S.of(context).seeAll, // Updated
                      style: const TextStyle(fontSize: 16, color: kblue),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const CategoryList(
                isAdmin: true,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
