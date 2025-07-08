import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/logic/hotel_search/bloc.dart';
import 'package:hotel_app/logic/hotel_search/models/search_results_hotels.dart';

/// Example widget showing how to use background processing states
class BackgroundProcessingExample extends StatelessWidget {
  const BackgroundProcessingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSearchBloc, HotelSearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Background Processing Example')),
          body: Column(
            children: [
              // Control buttons
              _buildControlButtons(),
              const SizedBox(height: 20),

              // Content based on state
              Expanded(child: _buildContent(state)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBackgroundErrorContent(HotelSearchBackgroundError state) {
    return Column(
      children: [
        // Error info
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Icon(Icons.error, color: Colors.red, size: 32),
              const SizedBox(height: 8),
              Text(
                'Error processing ${_getProcessingTypeText(state.processingType)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(state.error),
            ],
          ),
        ),

        // Show original hotels as fallback
        Expanded(child: _buildHotelsList(state.hotels)),
      ],
    );
  }

  Widget _buildBackgroundProcessingContent(
    HotelSearchBackgroundProcessing state,
  ) {
    return Column(
      children: [
        // Processing info
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Processing ${_getProcessingTypeText(state.processingType)}...',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (state.limit != null) Text('Limit: ${state.limit}'),
              if (state.minPrice != null || state.maxPrice != null)
                Text(
                  'Price: \$${state.minPrice ?? 0} - \$${state.maxPrice ?? '∞'}',
                ),
            ],
          ),
        ),

        // Shimmer loading for hotels
        Expanded(child: _buildShimmerList()),
      ],
    );
  }

  Widget _buildBackgroundSuccessContent(HotelSearchBackgroundSuccess state) {
    return Column(
      children: [
        // Success info
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 32),
              const SizedBox(height: 8),
              Text(
                '${_getProcessingTypeText(state.processingType)} completed!',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Found ${state.processedHotels.length} hotels'),
            ],
          ),
        ),

        // Results list
        Expanded(child: _buildHotelsList(state.processedHotels)),
      ],
    );
  }

  Widget _buildContent(HotelSearchState state) {
    if (state is HotelSearchInitial) {
      return const Center(
        child: Text('Search for hotels first to use background processing'),
      );
    }

    if (state is HotelSearchLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is HotelSearchError) {
      return Center(child: Text('Error: ${state.message}'));
    }

    if (state is HotelSearchBackgroundProcessing) {
      return _buildBackgroundProcessingContent(state);
    }

    if (state is HotelSearchBackgroundSuccess) {
      return _buildBackgroundSuccessContent(state);
    }

    if (state is HotelSearchBackgroundError) {
      return _buildBackgroundErrorContent(state);
    }

    if (state is HotelSearchSuccess) {
      return _buildSuccessContent(state);
    }

    return const Center(child: Text('Unknown state'));
  }

  Widget _buildControlButtons() {
    return BlocBuilder<HotelSearchBloc, HotelSearchState>(
      builder: (context, state) {
        final bloc = context.read<HotelSearchBloc>();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed:
                    state is HotelSearchSuccess && !bloc.isBackgroundProcessing
                    ? () => bloc.getHighlyAttractiveHotelsInBackground()
                    : null,
                child: const Text('Highly Attractive'),
              ),
              ElevatedButton(
                onPressed:
                    state is HotelSearchSuccess && !bloc.isBackgroundProcessing
                    ? () => bloc.getMostAttractiveHotelsInBackground(limit: 5)
                    : null,
                child: const Text('Most Attractive'),
              ),
              ElevatedButton(
                onPressed:
                    state is HotelSearchSuccess && !bloc.isBackgroundProcessing
                    ? () => bloc.getLuxuryHotelsInBackground()
                    : null,
                child: const Text('Luxury Hotels'),
              ),
              ElevatedButton(
                onPressed:
                    state is HotelSearchSuccess && !bloc.isBackgroundProcessing
                    ? () => bloc.getHotelsByPriceRangeInBackground(
                        minPrice: 100,
                        maxPrice: 200,
                      )
                    : null,
                child: const Text('Price Range'),
              ),
              ElevatedButton(
                onPressed:
                    state is HotelSearchSuccess && !bloc.isBackgroundProcessing
                    ? () => bloc.getHotelsWithFreeCancellationInBackground()
                    : null,
                child: const Text('Free Cancellation'),
              ),
              ElevatedButton(
                onPressed:
                    state is HotelSearchSuccess && !bloc.isBackgroundProcessing
                    ? () => bloc.getTopRatedHotelsInBackground(limit: 3)
                    : null,
                child: const Text('Top Rated'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHotelsList(List<Hotel> hotels) {
    if (hotels.isEmpty) {
      return const Center(child: Text('No hotels found'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: hotels.length,
      itemBuilder: (context, index) {
        final hotel = hotels[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: Text(hotel.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rating: ${hotel.overallRating} ⭐'),
                Text('Price: \$${hotel.extractedPrice}'),
                Text('Class: ${hotel.hotelClass} stars'),
                Text(
                  'Attractiveness: ${hotel.attractivenessScore.toStringAsFixed(1)}',
                ),
              ],
            ),
            trailing: hotel.freeCancellation
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
          ),
        );
      },
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 16,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 16,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSuccessContent(HotelSearchSuccess state) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Icon(Icons.hotel, size: 32),
              const SizedBox(height: 8),
              Text(
                '${state.hotels.length} hotels loaded',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Use buttons above to filter in background'),
            ],
          ),
        ),

        Expanded(child: _buildHotelsList(state.hotels)),
      ],
    );
  }

  String _getProcessingTypeText(BackgroundProcessingType type) {
    switch (type) {
      case BackgroundProcessingType.highlyAttractive:
        return 'Highly Attractive Hotels';
      case BackgroundProcessingType.mostAttractive:
        return 'Most Attractive Hotels';
      case BackgroundProcessingType.luxury:
        return 'Luxury Hotels';
      case BackgroundProcessingType.priceRange:
        return 'Hotels by Price Range';
      case BackgroundProcessingType.freeCancellation:
        return 'Hotels with Free Cancellation';
      case BackgroundProcessingType.topRated:
        return 'Top Rated Hotels';
      case BackgroundProcessingType.moderatelyAttractive:
        return 'Moderately Attractive Hotels';
    }
  }
}
