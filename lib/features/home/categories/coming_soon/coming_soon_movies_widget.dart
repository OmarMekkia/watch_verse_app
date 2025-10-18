import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_verse/features/home/categories/coming_soon/coming_soon_movies_cubit.dart';
import 'package:watch_verse/features/home/logic/movies_state.dart';
import 'package:watch_verse/core/widgets/center_circular_progress_indicator.dart';
import 'package:watch_verse/features/auth/ui/widgets/error_dialog.dart';

class ComingSoonMoviesWidget extends StatefulWidget {
  const ComingSoonMoviesWidget({super.key});

  @override
  State<ComingSoonMoviesWidget> createState() => _ComingSoonMoviesWidgetState();
}

class _ComingSoonMoviesWidgetState extends State<ComingSoonMoviesWidget> {
  late ComingSoonCubit comingSoonCubit;

  @override
  void initState() {
    super.initState();
    comingSoonCubit = context.read<ComingSoonCubit>();
    comingSoonCubit.fetchComingSoonMovies(page: 1);
  }

  final carouselOptions = CarouselOptions(
    autoPlay: true,
    viewportFraction: 1,
    height: 250,
    enlargeCenterPage: false,
    enableInfiniteScroll: true,
    autoPlayInterval: const Duration(seconds: 3),
    autoPlayAnimationDuration: const Duration(milliseconds: 800),
    scrollPhysics: const BouncingScrollPhysics(),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 175.h,
      child: BlocBuilder<ComingSoonCubit, MoviesState>(
        builder: (context, state) {
          return state.when(
            initial: () => const CenterCircularProgressIndicator(),
            loading: () => const CenterCircularProgressIndicator(),
            loaded: (data) {
              return CarouselSlider.builder(
                itemCount: data.results.length,
                itemBuilder: (context, index, realIndex) {
                  final movie = data.results[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(color: Colors.grey[300]),
                      ),
                      errorWidget: (context, url, error) => ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
                options: carouselOptions,
              );
            },
            error: (error) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                errorDialog(context, error);
              });
              return const Center(child: Text("Failed to load movies"));
            },
          );
        },
      ),
    );
  }
}
