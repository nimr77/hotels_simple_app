import 'package:flutter/material.dart';
import 'package:hotel_app/pages/home/widgets/header.dart';
import 'package:hotel_app/widgets/header/home_header_sliver.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        HeaderSliverWidget(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: HomePageHeaderWidget(),
          ),
        ),
      ],
    );
  }
}
