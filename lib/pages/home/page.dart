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
      child: CustomScrollView(
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
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: kSpacer * 0.5),
              child: SizedBox(
                height: 250,
                child: BlocBuilder<HotelSearchBloc, HotelSearchState>(
                  bloc: getIt<HotelSearchBloc>(),
                  buildWhen: (prev, curr) =>
                      curr is HotelSearchBackgroundProcessing ||
                      curr is HotelSearchBackgroundSuccess ||
                      curr is HotelSearchBackgroundError ||
                      curr is HotelSearchSuccess,
                  builder: (context, state) {
                    final bloc = getIt<HotelSearchBloc>();
                    if (bloc.isBackgroundProcessing &&
                        bloc.getBackgroundProcessingType() ==
                            BackgroundProcessingType.mostAttractive) {
                      // Show shimmer loading
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 5,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (_, __) =>
                            Container(
                              width: 160,
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200.withAlpha(60),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ).animate(
                              effects: [
                                ShimmerEffect(
                                  duration: 3.seconds,
                                  color: Colors.grey,
                                ),
                              ],
                              onComplete: (controller) => controller.repeat(),
                            ),
                      );
                    }
                    if (bloc.isBackgroundSuccess &&
                        bloc.getBackgroundProcessingType() ==
                            BackgroundProcessingType.mostAttractive) {
                      final hotels = bloc.getProcessedHotels();
                      if (hotels.isEmpty) {
                        return Center(child: Text(S.current.notHotelsAreFound));
                      }
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: hotels.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (_, index) => SizedBox(
                          width: 160,
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
        ],
      ),
    );
  }
}
