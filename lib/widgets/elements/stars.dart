import 'package:flutter/material.dart';
import 'package:hotel_app/style/common.dart';

class RatingStars extends StatelessWidget {
  final num stars;

  final double size;
  const RatingStars({super.key, required this.stars, this.size = 15});

  @override
  Widget build(BuildContext context) {
    if (stars == 0) {
      return const SizedBox();
    }
    return AbsorbPointer(
      absorbing: true,
      child: Row(
        spacing: 2,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < stars; i++)
            Icon(
              Icons.star_rounded,
              size: size,
              color: isDarkMode ? Colors.yellow : Colors.amber,
            ),
        ],
      ),
      // child: RatingBar(
      //     itemSize: size,
      //     itemCount: 5,
      //     initialRating: (stars).toDouble(),
      //     ratingWidget: RatingWidget(
      //         full: const Icon(Icons.star_rounded, color: Colors.amber),
      //         half: const Icon(Icons.star_half_rounded),
      //         empty: Icon(
      //           Icons.star_outline_rounded,
      //           color: Theme.of(context)
      //               .textTheme
      //               .titleLarge!
      //               .color!
      //               .withOpacity(0.3),
      //         )),
      //     onRatingUpdate: (_) {}),
    );
  }
}
