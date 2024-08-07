import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/const/colors.dart';
import 'package:mosque/generated/l10n.dart';
import 'package:mosque/screen/AdminScreens/home/home.dart';
import 'package:mosque/screen/AdminScreens/lesson/add_section.dart';
import 'package:mosque/screen/AdminScreens/students/cubit/students_cubit.dart';
import 'package:mosque/screen/AdminScreens/students/students.dart';

class StartPageAdmin extends StatefulWidget {
  const StartPageAdmin({super.key});

  @override
  State<StartPageAdmin> createState() => _StartPageAdminState();
}

class _StartPageAdminState extends State<StartPageAdmin> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.dashboard_rounded,
                color: kblue,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_rounded,
                  color: Colors.black,
                ))
          ],
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  navigatAndReturn(
                      context: context, page: const AddSectionScreen());
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
              )
            : null,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: BottomNavigationBar(
            // backgroundColor: Colors.red,
            // fixedColor: Colors.green,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: S.of(context).home, // Updated
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.group),
                label: S.of(context).students, // Updated
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.message),
                label: S.of(context).messages, // Updated
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: S.of(context).profile, // Updated
              ),
            ],
            selectedItemColor: kpink,
            unselectedItemColor: Colors.grey[300],
          ),
        ),
        body: _selectedIndex == 0
            ? const HomeAdmin()
            : _selectedIndex == 1
                ? BlocProvider(
                    create: (context) => StudentsCubit(),
                    child: const Students(),
                  )
                : Container());
  }
}
