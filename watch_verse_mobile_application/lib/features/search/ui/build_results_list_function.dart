import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_verse/core/helpers/spacing.dart';
import 'package:watch_verse/core/models/movie.dart';
import 'package:watch_verse/core/routing/app_routes.dart';
import 'package:watch_verse/core/widgets/custom_text_form_field.dart';
import 'package:watch_verse/theme/app_text_styles.dart';

Widget buildResultsList(
  MovieResponse movies,
  TextEditingController searchController,
  BuildContext context,
) {
  return ListView.separated(
    separatorBuilder: (context, index) => verticalSpacing(20),
    itemCount: movies.results.length,
    itemBuilder: (context, index) {
      final movie = movies.results[index];
      return Container(
        padding: const EdgeInsets.all(8.0),

        child: InkWell(
          onTap: () {
            if (context.mounted) {
              context.push(
                AppRoutes.movieDetailsPage,
                extra: {"result": movie, "fav": null},
              );
            }
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: movie.posterPath != null
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 150,
                        height: 150,
                        color: Colors.grey,
                        child: Icon(Icons.image, size: 50),
                      ),
              ),
              horizontalSpacing(10),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  height: 150,
                  child: Column(
                    children: [
                      Text(
                        movie.title ?? 'No Title',
                        style: context.textStyles.bodyLargeBold,
                      ),
                      verticalSpacing(10),

                      Expanded(
                        child: SizedBox(
                          height: 150,
                          child: SizedBox(
                            child: Text(
                              movie.overview ?? 'No Overview',
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
