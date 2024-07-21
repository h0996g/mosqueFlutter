import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/appbar.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:mosque/const/colors.dart';
import 'package:mosque/screen/AdminScreens/profile/profile.dart';

import '../../../component/category/category.dart';
import '../../../component/sorting.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int _selectedIndex = 0;

  HomeAdminCubit? homeAdminCubit;
  @override
  void initState() {
    homeAdminCubit = HomeAdminCubit.get(context);
    homeAdminCubit!.getMyInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: kpink,
        unselectedItemColor: Colors.grey[300],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const CustomeAppBar(),
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
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi Owner!",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Today is a good day\nto learn something new!",
                                style: TextStyle(
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
                                            page: const ProfileAdmin());
                                      },
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage: HomeAdminCubit.get(
                                                        context)
                                                    .adminModel!
                                                    .photo !=
                                                null
                                            ? CachedNetworkImageProvider(
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
                  //sorting
                  const Sorting(),
                  const SizedBox(
                    height: 20,
                  ),
                  //category list

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "See All",
                          style: TextStyle(fontSize: 16, color: kblue),
                        ),
                      ),
                    ],
                  ),

                  //now we create model of our images and colors which we will use in our app
                  const SizedBox(
                    height: 20,
                  ),
                  //we can not use gridview inside column
                  //use shrinkwrap and physical scroll

                  const CategoryList(
                    isAdmin: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // NavigationBarTheme navigationBar(BuildContext context) {
  //   return NavigationBarTheme(
  //       data: NavigationBarThemeData(
  //         indicatorColor: Colors.blue[100],
  //         labelTextStyle: MaterialStateProperty.all(
  //           const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  //         ),
  //       ),
  //       child: NavigationBar(
  //         height: 70,
  //         selectedIndex: HomeAdminCubit.get(context).selectedIndex,
  //         onDestinationSelected: (index) =>
  //             {HomeAdminCubit.get(context).changeIndexNavBar(index)},
  //         destinations: const [
  //           NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
  //           NavigationDestination(
  //               icon: Icon(Icons.more_time_rounded), label: 'Reservation'),
  //           NavigationDestination(icon: Icon(Icons.add), label: 'Annonce'),
  //           NavigationDestination(icon: Icon(Icons.groups_2), label: 'tournoi'),
  //         ],
  //       ));
  // }
}
