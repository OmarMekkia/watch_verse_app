import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_verse/core/routing/app_routes.dart';
import 'package:watch_verse/features/favourites/data/models/favourite_movie.dart';

class FavouriteItemWidget extends StatelessWidget {
  final FavouriteMovie favouriteMovie;
  const FavouriteItemWidget({super.key, required this.favouriteMovie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          AppRoutes.movieDetailsPage,
          extra: {"result": null, "fav": favouriteMovie},
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          padding: EdgeInsets.all(15.r),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: CachedNetworkImage(
              imageUrl:
                  "https://image.tmdb.org/t/p/w500/${favouriteMovie.posterPath}",
              placeholder: (context, url) => SizedBox.expand(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              width: 150.w,
              height: 300.h,
            ),
          ),
        ),
      ),
    );
  }
}
