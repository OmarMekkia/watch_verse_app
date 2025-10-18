import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_verse/core/widgets/center_circular_progress_indicator.dart';
import 'package:watch_verse/features/favourites/logic/favourite_cubit.dart';
import 'package:watch_verse/features/favourites/logic/favourite_state.dart';
import 'package:watch_verse/features/favourites/ui/widgets/favourite_item_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteCubit>().fetchFavouriteMovies();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<FavouriteCubit>().fetchFavouriteMovies();
  }

  Future<void> _onRefresh() async {
    await context.read<FavouriteCubit>().fetchFavouriteMovies();
  }

  void deleteAllFavorites() async {
    await context.read<FavouriteCubit>().deleteAllFavouriteMovies();
    if (!mounted) return;
    await context.read<FavouriteCubit>().fetchFavouriteMovies();
  }

  void _showDeleteAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete All Favorites'),
        content: const Text(
          'Are you sure you want to delete all favorite movies?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              deleteAllFavorites();
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All favorite movies deleted'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          BlocBuilder<FavouriteCubit, FavouriteState>(
            builder: (context, state) {
              final hasMovies = context
                  .read<FavouriteCubit>()
                  .moviesList
                  .isNotEmpty;

              if (!hasMovies) return const SizedBox.shrink();

              return IconButton(
                icon: const Icon(Icons.delete_forever, color: Colors.red),
                onPressed: _showDeleteAllDialog,
                tooltip: 'Delete all favorites',
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: BlocBuilder<FavouriteCubit, FavouriteState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(
                child: Text(
                  'Pull to refresh',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              loading: () => const CenterCircularProgressIndicator(),
              loaded: (movies) {
                if (movies?.isEmpty ?? true) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 100.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "No favorite movies added.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Add movies to see them here",
                          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                        ),
                      ],
                    ),
                  );
                }

                return SizedBox(
                  width: double.infinity,
                  child: GridView.builder(
                    padding: EdgeInsets.all(10.r),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.55,
                      crossAxisSpacing: 10.r,
                      mainAxisSpacing: 10.r,
                    ),
                    itemCount: movies?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (movies == null) return const SizedBox.shrink();
                      final favouriteMovie = movies[index];
                      return FavouriteItemWidget(
                        favouriteMovie: favouriteMovie,
                        key: ValueKey(
                          favouriteMovie.id,
                        ), // ✅ Add key to prevent widget reuse issues
                      );
                    },
                  ),
                );
              },
              error: (message) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 100.sp,
                        color: Colors.red,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Error: $message",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<FavouriteCubit>().fetchFavouriteMovies();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
