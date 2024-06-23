import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/appbar.dart';
import 'package:mosque/component/category.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/component/sorting.dart';
import 'package:mosque/const/colors.dart';
import 'package:mosque/screen/userScreens/home/cubit/home_user_cubit.dart';
import 'package:mosque/screen/userScreens/profile/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  HomeUserCubit homeUserCubit = HomeUserCubit();
  @override
  void initState() {
    homeUserCubit = HomeUserCubit.get(context);
    homeUserCubit.getMyInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottom bar
      // now we will use bottom bar package
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
        child: BlocConsumer<HomeUserCubit, HomeUserState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return ListView(
              children: [
                const CustomeAppBar(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi Julia",
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
                                            page: const ProfileUser());
                                      },
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage: HomeUserCubit.get(
                                                        context)
                                                    .userDataModel!
                                                    .photo !=
                                                null
                                            ? NetworkImage(
                                                HomeUserCubit.get(context)
                                                    .userDataModel!
                                                    .photo!)
                                            : const AssetImage(
                                                    'assets/images/user.png')
                                                as ImageProvider<Object>,
                                      ),
                                    ),
                            ],
                          ),
                        ],
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
                      const CategoryList(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
