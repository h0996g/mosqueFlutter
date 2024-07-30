import 'package:flutter/material.dart';
import 'package:mosque/const/colors.dart';
import 'package:mosque/generated/l10n.dart';

class Sorting extends StatelessWidget {
  const Sorting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        // Space between widgets
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            decoration: BoxDecoration(
                color: kpink, borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              S.of(context).proposal, // e.g., "Proposal"
              style: const TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Text(
              S.of(context).prophetsStories, // e.g., "Prophets' Stories"
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Text(
              S.of(context).Rulings_and_sermons, // e.g., "Sermons"
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
                height: 20, child: Image.asset("assets/icon/sort.png")),
          ),
        ],
      ),
    );
  }
}
