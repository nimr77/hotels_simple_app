import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/generated/l10n.dart';
import 'package:hotel_app/logic/hotel_search/bloc.dart';
import 'package:hotel_app/pages/home/widgets/header.dart';
import 'package:hotel_app/setup.dart';
import 'package:hotel_app/style/constants.dart';
import 'package:hotel_app/style/paddings.dart';
import 'package:hotel_app/widgets/card/hotel_card.dart';
import 'package:hotel_app/widgets/card/hotel_card_vertical.dart';
import 'package:hotel_app/widgets/header/home_header_sliver.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HotelSearchBloc>(),
      child: const HomePageContent(),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HotelSearchBloc, HotelSearchState>(
      bloc: getIt<HotelSearchBloc>(),
      listenWhen: (previous, current) =>
          previous is! HotelSearchSuccess && current is HotelSearchSuccess,
      listener: (context, state) {
        getIt<HotelSearchBloc>().getMostAttractiveHotelsInBackground(limit: 10);
      },
      child: Builder(
        builder: (context) {
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
                  padding: pagePadding.add(EdgeInsets.only(top: kSpacer)),
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
                    child: BlocBuilder<HotelSearchBloc, HotelSearchState>(
                      bloc: getIt<HotelSearchBloc>(),
                      buildWhen: (prev, curr) =>
                          curr is HotelSearchBackgroundProcessing ||
                          curr is HotelSearchBackgroundSuccess ||
                          curr is HotelSearchBackgroundError ||
                          curr is HotelSearchSuccess,
                      builder: (context, state) {
                        final bloc = getIt<HotelSearchBloc>();
                        if (bloc.isBackgroundProcessing || bloc.isLoading) {
                          // Show shimmer loading
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    color: Colors.grey.shade200.withAlpha(60),
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
                        if (bloc.isBackgroundSuccess &&
                            bloc.getBackgroundProcessingType() ==
                                BackgroundProcessingType.mostAttractive) {
                          final hotels = bloc.getProcessedHotels();
                          if (hotels.isEmpty) {
                            return Center(
                              child: Text(S.current.notHotelsAreFound),
                            );
                          }
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: hotels.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (_, index) => SizedBox(
                              width: 280,
                              child: HotelCard(hotel: hotels[index]),
                            ),
                          ).animate(effects: [FadeEffect(duration: 300.ms)]);
                        }
                        // Fallback: show nothing or a placeholder
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ),
              // Vertical list for all hotels
              SliverPadding(
                padding: pagePadding.add(EdgeInsets.only(top: kSpacer * 1.65)),
                sliver: BlocBuilder<HotelSearchBloc, HotelSearchState>(
                  bloc: getIt<HotelSearchBloc>(),
                  buildWhen: (prev, curr) =>
                      curr is HotelSearchLoading ||
                      curr is HotelSearchSuccess ||
                      curr is HotelSearchError,
                  builder: (context, state) {
                    final bloc = getIt<HotelSearchBloc>();
                    if (bloc.isLoading) {
                      // Show shimmer loading for vertical list
                      return SliverList.builder(
                        itemCount: 6,
                        itemBuilder: (_, __) =>
                            Container(
                              height: 120,
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200.withAlpha(60),
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
                              onComplete: (controller) => controller.repeat(),
                            ),
                      );
                    }
                    if (state is HotelSearchSuccess) {
                      final allHotels = state.hotels;
                      final mostAttractive = bloc.getMostAttractiveHotels();
                      // Remove most attractive hotels from the main list (by property_token)
                      final filteredHotels = allHotels
                          .where(
                            (hotel) => !mostAttractive.any(
                              (attrHotel) =>
                                  attrHotel.property_token ==
                                  hotel.property_token,
                            ),
                          )
                          .toList();
                      if (filteredHotels.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text(S.current.notHotelsAreFound),
                          ),
                        );
                      }
                      return SliverList.builder(
                        itemCount: filteredHotels.length,
                        itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: SizedBox(
                            height: 120,
                            child: HotelCardVertical(
                              hotel: filteredHotels[index],
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is HotelSearchError) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text(state.message)),
                      );
                    }
                    // Default/fallback: return an empty sliver
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        },
      ),
    );
  }
}
