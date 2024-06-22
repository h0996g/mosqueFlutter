import 'package:flutter/material.dart';
import 'package:mosque/const/colors.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.dashboard_rounded,
              color: kblue,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
            ))
      ],
    );
  }
}
