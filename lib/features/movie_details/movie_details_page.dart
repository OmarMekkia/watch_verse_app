import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_verse/core/constants/string_constants.dart';
import 'package:watch_verse/core/helpers/spacing.dart';
import 'package:watch_verse/core/models/movie.dart';
import 'package:watch_verse/features/favourites/data/models/favourite_movie.dart';
import 'package:watch_verse/features/favourites/data/models/favourite_movie_request.dart';
import 'package:watch_verse/features/favourites/logic/favourite_cubit.dart';
import 'package:watch_verse/features/favourites/logic/favourite_state.dart';
import 'package:watch_verse/theme/app_colors.dart';
import 'package:watch_verse/theme/app_text_styles.dart';

class MovieDetailsPage extends StatefulWidget {
  final Result? result;
  final FavouriteMovie? favouriteMovie;

  const MovieDetailsPage({super.key, this.result, this.favouriteMovie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late dynamic movie;
  late FavouriteCubit cubit;

  @override
  void initState() {
    super.initState();
    movie = widget.result ?? widget.favouriteMovie;
    cubit = context.read<FavouriteCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          bool isFav = cubit.isMovieInFavourites(movie.id.toString());
          return FloatingActionButton(
            backgroundColor: context.colors.button,
            onPressed: () {
              try {
                isFav = !isFav;
                if (!isFav) {
                  context.read<FavouriteCubit>().deleteFavouriteMovie(
                    movie.id.toString(),
                  );
                  cubit.moviesList.removeWhere(
                    (fav) => fav.id.toString() == movie.id.toString(),
                  );
                  return;
                }
                if (isFav) {
                  context.read<FavouriteCubit>().addFavouriteMovie(
                    FavouriteMovieRequest(
                      movieId: movie.id.toString(),
                      title: movie.title,
                      overview: movie.overview,
                      posterPath: movie.posterPath,
                      backdropPath: movie.backdropPath,
                      releaseDate: movie.releaseDate,
                      originalLanguage: movie.originalLanguage,
                      voteAverage: movie.voteAverage.toDouble(),
                      voteCount: movie.voteCount,
                      adult: movie.adult,
                      genreIds: movie.genreIds,
                      originalTitle: movie.originalTitle,
                      popularity: movie.popularity.toDouble(),
                      video: movie.video,
                    ),
                  );
                  cubit.moviesList.add(
                    FavouriteMovie(
                      id: movie.id.toString(),
                      title: movie.title,
                      overview: movie.overview,
                      posterPath: movie.posterPath,
                      backdropPath: movie.backdropPath,
                      releaseDate: movie.releaseDate,
                      originalLanguage: movie.originalLanguage,
                      voteAverage: movie.voteAverage.toDouble(),
                      voteCount: movie.voteCount,
                      adult: movie.adult,
                      genreIds: movie.genreIds,
                      originalTitle: movie.originalTitle,
                      popularity: movie.popularity.toDouble(),
                      video: movie.video,
                    ),
                  );
                  return;
                }
              } on Exception catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }
            },
            child: Icon(isFav ? Icons.favorite : Icons.favorite_border),
          );
        },
      ),
      appBar: AppBar(title: Text(movie.title ?? "")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Opacity(
                  opacity: 0.5,
                  child: SizedBox(
                    height: 400.h,
                    child: CachedNetworkImage(
                      imageUrl:
                          "${StringConstants.imageBaseUrl}${movie.backdropPath}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  top: 240.h,
                  left: 20.w,
                  child: Expanded(
                    child: SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 250.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${StringConstants.imageBaseUrl}${movie.posterPath}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          horizontalSpacing(10),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150.w,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    movie.title ?? "",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                verticalSpacing(10),
                                SizedBox(
                                  width: 175,
                                  height: 60,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: context.colors.button,
                                      foregroundColor: context.colors.secondary,
                                    ),
                                    onPressed: () {},

                                    child: Text('Watch Trailer'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpacing(110),
            Text(
              'Overview: ${movie.overview}',
              style: context.textStyles.bodyLargeBold,
            ),
            verticalSpacing(20),
            Text(
              'Release Date: ${movie.releaseDate}',
              style: context.textStyles.bodyLargeBold,
            ),
            Text(
              movie.originalLanguage != null
                  ? 'Original Language: ${movie.originalLanguage}'
                  : 'Original Language: N/A',
              style: context.textStyles.bodyLargeBold,
            ),
            Text(
              'Vote Average: ${movie.voteAverage}',
              style: context.textStyles.bodyLargeBold,
            ),
            Text(
              'Vote Count: ${movie.voteCount}',
              style: context.textStyles.bodyLargeBold,
            ),
          ],
        ),
      ),
    );
  }
}
