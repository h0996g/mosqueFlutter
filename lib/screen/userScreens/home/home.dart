import 'package:flutter/material.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/screen/userScreens/profile/profile.dart';

class HomeUser extends StatelessWidget {
  const HomeUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeJouer'),
        actions: [
          TextButton(
              onPressed: () {
                navigatAndReturn(context: context, page: const ProfileUser());
              },
              child: const Text("Profile"))
        ],
      ),
    );
  }
}
