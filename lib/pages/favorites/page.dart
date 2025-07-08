import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_app/generated/l10n.dart';
import 'package:hotel_app/logic/favorite/provider.dart';
import 'package:hotel_app/logic/hotel_search/models/hotel.dart';
import 'package:hotel_app/setup.dart';
import 'package:hotel_app/style/constants.dart';
import 'package:hotel_app/style/paddings.dart';
import 'package:hotel_app/widgets/card/hotel_card_vertical.dart';
import 'package:hotel_app/widgets/navigation/container.dart';
import 'package:hotel_app/widgets/navigation/navigation_title.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final provider = getIt<FavoriteProvider>();

  final listState = ValueNotifier<List<Hotel>>([]);
  @override
  Widget build(BuildContext context) {
    final height = 140.toDouble();
    return ValueListenableBuilder(
      valueListenable: listState,
      builder: (context, list, child) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(
                context,
              ).scaffoldBackgroundColor.withAlpha(0),
              surfaceTintColor: Theme.of(
                context,
              ).scaffoldBackgroundColor.withAlpha(0),

              floating: true,
              toolbarHeight: height,
              expandedHeight: height,
              pinned: true,
              flexibleSpace: NavigationContainer(
                color: Theme.of(context).scaffoldBackgroundColor.withAlpha(200),
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            NavigationTitle(
                              title: S.current.favorites,
                              onTap: () {
                                context.pop();
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: pagePadding,
                        child: TextField(
                          onChanged: (p0) => search(p0),
                          decoration: InputDecoration(
                            hintText: S.current.searchInYourFavorites,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: pagePadding.add(EdgeInsets.only(top: kSpacer * 1.65)),
              sliver: Builder(
                builder: (context) {
                  if (!list.isNotEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(S.current.clickOnTheHeartToAddToFavorites),
                      ),
                    );
                  }
                  return SliverList.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        height: 120,
                        child: HotelCardVertical(hotel: list[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    listState.value = [...provider.favoriteList.value];
    provider.favoriteList.addListener(() {
      listState.value = [...provider.favoriteList.value];
    });
    super.initState();
  }

  void search(String text) {
    listState.value = [
      if (text.isEmpty)
        ...provider.favoriteList.value
      else
        ...provider.favoriteList.value.where(
          (element) => element.name.toLowerCase().contains(text.toLowerCase()),
        ),
    ];
  }
}
