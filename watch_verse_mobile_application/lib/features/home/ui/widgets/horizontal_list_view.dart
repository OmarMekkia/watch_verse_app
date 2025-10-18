import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_verse/core/helpers/spacing.dart';
import 'package:watch_verse/core/models/movie.dart';
import 'package:watch_verse/core/routing/app_routes.dart';
import 'package:watch_verse/theme/app_colors.dart';

class HorizontalListView extends StatelessWidget {
  final MovieResponse movieResponse;
  const HorizontalListView({super.key, required this.movieResponse});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => horizontalSpacing(15),
      itemCount: movieResponse.results.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 140.w,
            height: 260.h,
            decoration: BoxDecoration(
              color: context.colors.onSurface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () {
                context.push(AppRoutes.movieDetailsPage, extra: {
                  "result": movieResponse.results[index],
                  "fav": null
                });
              },
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://image.tmdb.org/t/p/w500${movieResponse.results[index].posterPath}",
                    placeholder: (context, url) => SizedBox.expand(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                    height: 260,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          movieResponse.results[index].title ?? 'No Title',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
