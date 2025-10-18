import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_verse/features/home/logic/movies_state.dart';
import 'package:watch_verse/core/networking/api_result.dart';
import 'package:watch_verse/features/home/categories/trending/trending_time_window.dart';
import 'package:watch_verse/core/repos/tmdb_repo.dart';

class TrendingMoviesCubit extends Cubit<MoviesState> {
  final TmdbRepo tmdbRepo;
  TrendingMoviesCubit({required this.tmdbRepo}) : super(MoviesState.initial());

  void fetchTrendingMovies({required int page, required TrendingTimeWindow timeWindow}) async {
    emit(MoviesState.loading());
    final movies = await tmdbRepo.getTrendingMovies(
      trendingTimeWindow: timeWindow,
    );

    movies.when(
      success: (data) => emit(MoviesState.loaded(data)),
      error: (message) => emit(MoviesState.error(message)),
    );
  }
}
