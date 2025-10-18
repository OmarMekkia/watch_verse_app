import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_verse/features/favourites/data/models/favourite_movie.dart';
import 'package:watch_verse/features/favourites/data/models/favourite_movie_request.dart';
import 'package:watch_verse/features/favourites/data/repos/favourite_repo.dart';
import 'package:watch_verse/features/favourites/logic/favourite_state.dart';
import 'package:watch_verse/core/networking/api_result.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteRepo favouriteRepo;
  final List<FavouriteMovie> moviesList = [];

  FavouriteCubit({required this.favouriteRepo})
    : super(FavouriteState.initial());

  Future<void> fetchFavouriteMovies() async {
    emit(FavouriteState.loading());
    final result = await favouriteRepo.getFavouriteMovies();

    result.when(
      success: (data) {
        moviesList.clear(); // ✅ Clear before adding to prevent duplicates
        moviesList.addAll(data);
        emit(FavouriteState.loaded(moviesList));
      },
      error: (message) => emit(FavouriteState.error(message)),
    );
  }

  Future<void> addFavouriteMovie(FavouriteMovieRequest request) async {
    emit(FavouriteState.loading());
    final result = await favouriteRepo.addFavouriteMovie(request);

    result.when(
      success: (data) {
        // ✅ Check if movie already exists before adding
        final existingIndex = moviesList.indexWhere(
          (movie) => movie.id.toString() == data.id.toString(),
        );

        if (existingIndex == -1) {
          moviesList.add(data);
        } else {
          // Update existing movie instead of adding duplicate
          moviesList[existingIndex] = data;
        }

        emit(FavouriteState.loaded(moviesList));
      },
      error: (message) => emit(FavouriteState.error(message)),
    );
  }

  Future<void> updateFavouriteMovie(FavouriteMovieRequest request) async {
    emit(FavouriteState.loading());
    final result = await favouriteRepo.updateFavouriteMovie(request);

    result.when(
      success: (data) {
        // ✅ Use toString() for consistent comparison
        final index = moviesList.indexWhere(
          (movie) => movie.id.toString() == data.id.toString(),
        );

        if (index != -1) {
          moviesList[index] = data;
        }

        emit(FavouriteState.loaded(moviesList));
      },
      error: (message) => emit(FavouriteState.error(message)),
    );
  }

  Future<void> deleteFavouriteMovie(String id) async {
    emit(FavouriteState.loading());
    final result = await favouriteRepo.deleteFavouriteMovie(id);

    result.when(
      success: (data) {
        // ✅ Use removeWhere instead of removeAt for safer deletion
        moviesList.removeWhere((movie) => movie.id.toString() == id.toString());

        emit(FavouriteState.loaded(moviesList));
      },
      error: (message) => emit(FavouriteState.error(message)),
    );
  }

  Future<void> deleteAllFavouriteMovies() async {
    emit(FavouriteState.loading());
    final result = await favouriteRepo.deleteAllFavouriteMovies();

    result.when(
      success: (data) {
        moviesList.clear();
        emit(FavouriteState.loaded(moviesList));
      },
      error: (message) => emit(FavouriteState.error(message)),
    );
  }

  bool isMovieInFavourites(String movieId) {
    return moviesList.any((movie) => movie.id.toString() == movieId.toString());
  }
}
