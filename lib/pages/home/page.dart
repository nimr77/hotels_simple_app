import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hotel_app/generated/l10n.dart';
import 'package:hotel_app/logic/hotel_search/provider.dart';
import 'package:hotel_app/pages/home/widgets/header.dart';
import 'package:hotel_app/setup.dart';
import 'package:hotel_app/style/constants.dart';
import 'package:hotel_app/style/paddings.dart';
import 'package:hotel_app/widgets/card/hotel_card.dart';
import 'package:hotel_app/widgets/card/hotel_card_vertical.dart';
import 'package:hotel_app/widgets/header/home_header_sliver.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final provider = getIt<HotelsSearchProvider>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => provider.loadHotels(),
      child: ValueListenableBuilder(
        valueListenable: provider.loadingState,
        builder: (context, isLoading, _) {
          return ValueListenableBuilder(
            valueListenable: provider.recomandedState,
            builder: (context, recomandedHotels, _) {
              return ValueListenableBuilder(
                valueListenable: provider.listState,
                builder: (context, listOfHotels, _) {
                  return CustomScrollView(
                    slivers: [
                      HeaderSliverWidget(),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: kSpacer),
                          child: HomePageHeaderWidget(),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: pagePadding.add(
                            EdgeInsets.only(top: kSpacer),
                          ),
                          child: Text(
                            S.current.recomandedHotelsTitle,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                      // Horizontal list for most attractive hotels
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: kSpacer * 0.5),
                          child: SizedBox(
                            height: 265,
                            child: Builder(
                              builder: (context) {
                                if (isLoading) {
                                  // Show shimmer loading
                                  return ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    itemCount: 5,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: 12),
                                    itemBuilder: (_, __) =>
                                        Container(
                                          width: 160,
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200
                                                .withAlpha(60),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ).animate(
                                          effects: [
                                            FadeEffect(
                                              duration: 1.seconds,
                                              curve: Curves.easeInOut,
                                            ),
                                            ShimmerEffect(
                                              duration: 3.seconds,
                                              color: Colors.grey,
                                            ),
                                          ],
                                          onComplete: (controller) =>
                                              controller.repeat(),
                                        ),
                                  );
                                }

                                if (listOfHotels.isEmpty) {
                                  return Center(
                                    child: Column(
                                      children: [
                                        Text(S.current.notHotelsAreFound),
                                        Text(S.current.pullToRefresh),
                                      ],
                                    ),
                                  );
                                }
                                // if (bloc.isBackgroundSuccess &&
                                //     bloc.getBackgroundProcessingType() ==
                                //         BackgroundProcessingType.mostAttractive) {
                                //   final hotels = bloc.getProcessedHotels();
                                //   if (hotels.isEmpty) {
                                //     return Center(
                                //       child: Text(S.current.notHotelsAreFound),
                                //     );
                                //   }
                                return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  itemCount: recomandedHotels.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 12),
                                  itemBuilder: (_, index) => SizedBox(
                                    width: 280,
                                    child: HotelCard(
                                      hotel: recomandedHotels[index],
                                    ),
                                  ),
                                ).animate(
                                  effects: [FadeEffect(duration: 300.ms)],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      // Vertical list for all hotels
                      SliverPadding(
                        padding: pagePadding.add(
                          EdgeInsets.only(top: kSpacer * 1.65),
                        ),
                        sliver: Builder(
                          builder: (context) {
                            if (isLoading) {
                              // Show shimmer loading for vertical list
                              return SliverList.builder(
                                itemCount: 6,
                                itemBuilder: (_, __) =>
                                    Container(
                                      height: 120,
                                      margin: const EdgeInsets.only(bottom: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200.withAlpha(
                                          60,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ).animate(
                                      effects: [
                                        FadeEffect(
                                          duration: 1.seconds,
                                          curve: Curves.easeInOut,
                                        ),
                                        ShimmerEffect(
                                          duration: 3.seconds,
                                          color: Colors.grey,
                                        ),
                                      ],
                                      onComplete: (controller) =>
                                          controller.repeat(),
                                    ),
                              );
                            }

                            return SliverList.builder(
                              itemCount: listOfHotels.length,
                              itemBuilder: (_, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: SizedBox(
                                  height: 120,
                                  child: HotelCardVertical(
                                    hotel: listOfHotels[index],
                                  ),
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
            },
          );
        },
      ),
    );
  }
}
